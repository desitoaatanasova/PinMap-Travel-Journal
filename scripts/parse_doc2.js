/* DEPRECATED — DO NOT USE FOR NEW IMPORTS
   Use: node scripts/import_places.js --source "<source-file>" --country "<country>" */
console.error('DEPRECATED: parse_doc2.js is retired. Use: node scripts/import_places.js --source "<source-file>" --country "<country>"');
process.exit(1);
const fs=require('fs');
const xml=fs.readFileSync(process.env.TEMP+'\\docx_read\\data.xml','utf8');
const reP=/<w:p[^>]*>([\s\S]*?)<\/w:p>/g;
let paras=[];
let m;
while(m=reP.exec(xml)){
  const pXml=m[1];
  const t=[...pXml.matchAll(/<w:t[^>]*>([^<]*)<\/w:t>/g)].map(x=>x[1]).join('').trim().replace(/\s+/g,' ');
  if(!t) continue;
  const il=(pXml.match(/<w:ilvl[^>]*w:val="([0-9]+)"/)||[])[1]||null;
  const num=(pXml.match(/<w:numId[^>]*w:val="([0-9]+)"/)||[])[1]||null;
  paras.push({t,il,num});
}
paras.slice(0,40).forEach(p=>console.log(JSON.stringify(p)));
console.log('---');
let countries=new Set(['Italy','France','Spain','Portugal','Ireland','England','Scotland','Belgium','The Netherlands','Netherlands','Germany','Switzerland']);
let cats=new Set(['Historical Sights','For the Art Lovers','Hidden Gems','Atmosphere & Experiences','Atmosphere & experience','Close by']);
// find sequence for Germany
let inGer=false;
for(let i=0;i<paras.length;i++){
  const p=paras[i];
  if(p.t==='Germany'){ inGer=true; console.log(`\n=== Germany start at ${i}`); }
  if(p.t==='Switzerland' && inGer){ console.log(`=== Switzerland start at ${i}`); break; }
  if(inGer) console.log(i, JSON.stringify(p));
}
