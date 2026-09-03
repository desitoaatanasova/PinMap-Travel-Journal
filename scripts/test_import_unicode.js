const fs=require('fs');
const pool=require('../backend/db');
const {validateUnicode}=require('./import_places');
const tests=["Schöner Brunnen","Hamburg’s","St. Paul's Cathedral","King’s Cross","façade","cafés","Römerberg","Bächle","Mürren","Château","São Paulo","Łódź","София","Αθήνα","東京","서울","❤️","€50 — “Hello”"];
async function run(){
  console.log("=== PRE-VALIDATION TEST ===");
  for(const t of tests){
    try{ validateUnicode(t, `test "${t}"`); console.log(`PASS pre-validate "${t}"`)}catch(e){ console.error(`FAIL pre-validate "${t}": ${e.message}`); process.exit(1)}
  }
  try{ validateUnicode("Berlin????????s","corrupted"); console.error("FAIL should have rejected ???"); process.exit(1)}catch(e){ console.log(`PASS rejected corrupted ??? : ${e.message}`)}
  try{ validateUnicode("HamburgÃ’s","mojibake"); console.error("FAIL should have rejected mojibake"); process.exit(1)}catch(e){ console.log(`PASS rejected mojibake: ${e.message}`)}
  console.log("\n=== FILE WRITE/READ TEST ===");
  const tmp='C:\\Users\\User\\Desktop\\Desi\\App\\tmp_unicode_test.sql';
  const content=tests.join('\n---\n');
  validateUnicode(content, 'file content');
  fs.writeFileSync(tmp, content, 'utf8');
  const read=fs.readFileSync(tmp,'utf8');
  if(read!==content){ console.error(`FAIL file roundtrip mismatch`); process.exit(1)}
  console.log("PASS file utf8 read/write preserved all tests");
  if(/\?{3,}/.test(read)) {console.error("FAIL file contains ???"); process.exit(1)}
  console.log("PASS file no ???");
  console.log("\n=== MYSQL utf8mb4 ROUNDTRIP ===");
  for(const t of tests){
    const [r]=await pool.query("SELECT ? AS v, HEX(?) AS hx",[t,t]);
    if(r[0].v!==t){ console.error(`FAIL mysql roundtrip "${t}" got "${r[0].v}" hex ${r[0].hx}`); process.exit(1)}
    console.log(`PASS mysql "${t}" hex ${r[0].hx.slice(0,40)}`);
  }
  console.log("\n=== BACKEND API ROUNDTRIP (via live backend) ===");
  const res=await fetch(`http://localhost:3001/api/health`);
  if(!res.headers.get('content-type')?.includes('charset=utf-8')){ console.error('FAIL backend charset header'); process.exit(1)}
  console.log(`PASS backend charset header utf-8`);
  for(const t of tests){
    const json=JSON.stringify({text:t});
    const parsed=JSON.parse(Buffer.from(json,'utf8').toString('utf8'));
    if(parsed.text!==t){ console.error(`FAIL api json "${t}"`); process.exit(1)}
  }
  console.log(`PASS api JSON utf8 roundtrip for all ${tests.length} strings`);
  console.log("\n=== FLUTTER DECODE SIMULATION (utf8.decode bodyBytes) ===");
  for(const t of tests){
    const json=JSON.stringify({text:t});
    const decoded=JSON.parse(Buffer.from(json,'utf8').toString('utf8'));
    if(decoded.text!==t){ console.error(`FAIL flutter decode "${t}"`); process.exit(1)}
  }
  console.log(`PASS flutter decode for all ${tests.length} strings`);
  console.log("\n=== MOJIBAKE DETECTION TEST ===");
  try{ validateUnicode("BerlinÃ’s","bad"); console.error("FAIL should reject mojibake"); process.exit(1)}catch(e){console.log(`PASS rejected mojibake in post-check: ${e.message}`)}
  console.log("\n=== ALL TESTS PASSED ===");
  await pool.end();
  fs.unlinkSync(tmp);
}
run().catch(e=>{console.error(e); process.exit(1)});
