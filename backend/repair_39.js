const fs=require('fs');
const pool=require('./db');
(async()=>{
  const sqlFile=fs.readFileSync('C:\\Users\\User\\Desktop\\Desi\\App\\pinmap_germany_switzerland.sql','utf8');
  const re=/SELECT @\w+,\s*\d+,\s*'((?:''|[^'])*)','((?:''|[^'])*)'/g;
  const fileMap=new Map();
  let m;
  while((m=re.exec(sqlFile))!==null){
    const name=m[1].replace(/''/g,"'");
    const descr=m[2].replace(/''/g,"'");
    if(!fileMap.has(name)) fileMap.set(name,descr);
  }
  console.log(`fileMap entries ${fileMap.size}`);
  const [affected]=await pool.query("SELECT p.place_id,p.name,p.short_description, c.name AS city, co.name AS country, HEX(p.short_description) hx FROM places p JOIN cities c ON p.city_id=c.city_id JOIN countries co ON c.country_id=co.country_id WHERE p.short_description LIKE '%\\?\\?\\?%' ORDER BY p.place_id");
  console.log(`affected count ${affected.length}`);
  affected.forEach(r=>console.log(`${r.place_id} | ${r.country}/${r.city} | ${r.name} | ${r.short_description.slice(0,80)}`));
  if(affected.length!==39){
    console.error(`EXPECTED 39 but found ${affected.length} — STOPPING, no update`);
    await pool.end(); process.exit(1);
  }
  const toUpdate=[];
  const backup=[];
  for(const r of affected){
    const canonical=fileMap.get(r.name);
    if(!canonical){
      console.error(`No canonical for ${r.name} id ${r.place_id} — STOP`);
      await pool.end(); process.exit(1);
    }
    if(r.short_description===canonical){
      console.error(`Row ${r.place_id} already equals canonical — unexpected`);
      continue;
    }
    if(!r.short_description.includes('???')){
      console.error(`Row ${r.place_id} does not contain ??? — unexpected`);
    }
    toUpdate.push({place_id:r.place_id,name:r.name,city:r.city,country:r.country,old:r.short_description,oldHex:r.hx,newDescr:canonical,newHex:Buffer.from(canonical,'utf8').toString('hex').slice(0,120)});
    backup.push({place_id:r.place_id,name:r.name,city:r.city,country:r.country,old_description:r.short_description,old_hex:r.hx,new_description:canonical,new_hex:Buffer.from(canonical,'utf8').toString('hex')});
  }
  console.log(`\n=== TO UPDATE ${toUpdate.length} ===`);
  toUpdate.forEach(u=>{console.log(`\n${u.place_id} ${u.name} (${u.country}/${u.city})`); console.log(`  OLD: "${u.old}"`); console.log(`  OLD hex head: ${u.oldHex.slice(0,100)}`); console.log(`  NEW: "${u.newDescr}"`); console.log(`  NEW hex head: ${u.newHex.slice(0,100)}`);});
  if(toUpdate.length!==39){
    console.error(`toUpdate length ${toUpdate.length} !=39 — STOP`);
    await pool.end(); process.exit(1);
  }
  fs.writeFileSync('C:\\Users\\User\\Desktop\\Desi\\App\\repair_backup_39.json', JSON.stringify(backup,null,2), 'utf8');
  console.log('\nBackup written to repair_backup_39.json');
  const conn=await pool.getConnection();
  try{
    await conn.beginTransaction();
    for(const u of toUpdate){
      await conn.query('UPDATE places SET short_description = ? WHERE place_id = ?', [u.newDescr, u.place_id]);
    }
    const [check]=await conn.query("SELECT place_id,name,short_description,HEX(short_description) hx FROM places WHERE place_id IN ("+toUpdate.map(()=> '?').join(',')+")", toUpdate.map(u=>u.place_id));
    let ok=true;
    for(const row of check){
      const exp=fileMap.get(row.name);
      if(row.short_description!==exp){
        console.error(`VERIFY FAIL id ${row.place_id} not equal canonical`);
        console.error(` got: "${row.short_description}"`);
        console.error(` exp: "${exp}"`);
        ok=false;
      }
      if(row.short_description.includes('???') || row.hx.includes('3F3F3F')){
        console.error(`VERIFY FAIL id ${row.place_id} still contains ???`);
        ok=false;
      }
    }
    const [stillQ]=await conn.query("SELECT COUNT(*) AS c FROM places p JOIN cities c2 ON p.city_id=c2.city_id JOIN countries co ON c2.country_id=co.country_id WHERE (co.name='Germany' OR co.name='Switzerland') AND p.short_description LIKE '%\\?\\?\\?%'");
    console.log(`remaining Germany/Switzerland with ??? after update: ${stillQ[0].c}`);
    if(stillQ[0].c!==0) ok=false;
    const samples=[1332,1335,1349,1359,1423,1441,1556,1540];
    for(const id of samples){
      const [r]=await conn.query("SELECT name,short_description,HEX(short_description) hx FROM places WHERE place_id=?",[id]);
      if(r.length){
        const hasCurly=r[0].hx.includes('E28099');
        const hasEacute=r[0].hx.includes('C3A9');
        const hasCcedil=r[0].hx.includes('C3A7');
        console.log(`sample ${id} ${r[0].name} hex has E28099?${hasCurly} C3A9?${hasEacute} C3A7?${hasCcedil} -> "${r[0].short_description.slice(0,60)}"`);
      }
    }
    if(!ok){
      await conn.rollback();
      console.error('VERIFICATION FAILED — ROLLED BACK');
      conn.release(); await pool.end(); process.exit(1);
    }
    await conn.commit();
    console.log(`\nCOMMIT SUCCESS — updated ${toUpdate.length} rows`);
    conn.release();
  }catch(e){
    await conn.rollback();
    console.error('ERROR, ROLLED BACK',e);
    conn.release();
    await pool.end(); process.exit(1);
  }
  const [final]=await pool.query("SELECT COUNT(*) AS c FROM places WHERE short_description LIKE '%\\?\\?\\?%'");
  console.log(`final total with ??? (all countries): ${final[0].c}`);
  const [verify]=await pool.query("SELECT place_id,name,HEX(short_description) hx FROM places WHERE place_id IN (1332,1335) ");
  console.log(JSON.stringify(verify,null,2));
  await pool.end();
})();
