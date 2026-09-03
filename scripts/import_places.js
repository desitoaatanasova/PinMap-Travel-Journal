const fs=require('fs');
const path=require('path');
const pool=require('../backend/db');

function validateUnicode(text, context){
  if(text==null) return;
  const s=String(text);
  if(Buffer.from(s,'utf8').toString('utf8')!==s){
    throw new Error(`INVALID UTF-8 in ${context}: "${s.slice(0,120)}"`);
  }
  if(/\?{3,}/.test(s)){
    const m=s.match(/\?{3,}/);
    throw new Error(`CORRUPTION detected (??? run) in ${context}: "${s.slice(0,120)}" pattern ${m[0]}`);
  }
  const mojibakePatterns=[/Ã/, /Â/, /â€™/, /â€œ/, /â€/, /â€”/, /â€/];
  for(const re of mojibakePatterns){
    if(re.test(s)){
      throw new Error(`MOJIBAKE detected ${re} in ${context}: "${s.slice(0,120)}"`);
    }
  }
}

function esc(s){ return s.replace(/'/g,"''").replace(/\\/g,'\\\\'); }

function legacyFixEncoding(s){
  let out=s;
  const map=[['â€”','—'],['â€“','–'],['â€œ','“'],['â€','”'],['â€™','’'],['â€˜','‘'],['Ã¶','ö'],['Ã–','Ö'],['Ã¼','ü'],['Ãœ','Ü'],['Ã¤','ä'],['Ã„','Ä'],['ÃŸ','ß'],['Ã©','é'],['Ã¨','è'],['Ãê','ê'],['Ãë','ë'],['Ã¡','á'],['Ã ','à'],['Ã¢','â'],['Ã´','ô'],['Ã³','ó'],['Ã²','ò'],['Ãñ','ñ'],['Ã‘','Ñ'],['Ã§','ç'],['Ã‰','É'],['Ã–','Ö'],['Ã¼','ü'],['Ã¶','ö'],['Ã¤','ä']];
  map.sort((a,b)=>b[0].length-a[0].length);
  for(const [f,t] of map){ out=out.split(f).join(t); }
  if(/[ÃÂ]/.test(out)){
    try{ const fixed=Buffer.from(out,'binary').toString('utf8'); if(fixed && !fixed.includes('Ã') && !fixed.includes('�')) out=fixed; }catch(e){}
  }
  return out;
}
async function importFromDocx({sourceXml, targetCountries}){
  const xml=fs.readFileSync(sourceXml,'utf8');
  if(!xml) throw new Error(`Source ${sourceXml} empty or not utf8`);
  const reP=/<w:p[^>]*>([\s\S]*?)<\/w:p>/g;
  let paras=[]; let m;
  while((m=reP.exec(xml))){
    const pXml=m[1];
    let t=[...pXml.matchAll(/<w:t[^>]*>([^<]*)<\/w:t>/g)].map(x=>x[1]).join('').trim().replace(/\s+/g,' ');
    if(!t) continue;
    t=legacyFixEncoding(t);
    t=t.replace(/&amp;/g,'&');
    const il=(pXml.match(/<w:ilvl[^>]*w:val="([0-9]+)"/)||[])[1]||null;
    const num=(pXml.match(/<w:numId[^>]*w:val="([0-9]+)"/)||[])[1]||null;
    paras.push({t,il,num});
  }
  const catsSet=new Set(['Historical Sights','For the Art Lovers','Hidden Gems','Atmosphere & Experiences','Close by']);
  const countryNames=['Italy','France','Spain','Portugal','Ireland','England','Scotland','Belgium','The Netherlands','Netherlands','Germany','Switzerland'];
  let doc={}; let curC=null,curCity=null,curCat=null;
  for(const p of paras){
    if(p.t==='PinMap Data') continue;
    if(countryNames.includes(p.t) && p.il==='0' && p.num==='1'){
      curC=p.t==='Netherlands'?'The Netherlands':p.t;
      curCity=null;curCat=null;
      if(!targetCountries.includes(curC)) {curC=null; continue;}
      if(!doc[curC]) doc[curC]={cities:{}};
      continue;
    }
    if(!curC) continue;
    if(catsSet.has(p.t)){
      let n=p.t.replace(/&amp;/g,'&');
      curCat=n;
      if(curCity && !doc[curC].cities[curCity][curCat]) doc[curC].cities[curCity][curCat]=[];
      continue;
    }
    if(p.il==='1' && p.num==='1' && !catsSet.has(p.t)){
      if(p.t.includes('—')||p.t.includes('–')) continue;
      if(p.t.length>50) continue;
      curCity=p.t;
      validateUnicode(curCity, `city ${curC}/${curCity}`);
      curCat=null;
      if(!doc[curC].cities[curCity]) doc[curC].cities[curCity]={};
      continue;
    }
    if(curCity && curCat && p.il==='1' && (p.num!=='1')){
      const hasDash = p.t.match(/\s+[—–]\s+/);
      if(!hasDash){
        if(/^(Walk|Explore|Visit|Take|Cross|Climb|Try|Watch|Wander|Go |Sit |Use |See |Experience|Ride|Enjoy|Admire|Discover|Browse|Relax|Look |Hike)/.test(p.t)) continue;
        if(p.t.length>80) continue;
      }
      let name=p.t, desc='';
      let mm=p.t.match(/\s+[—–]\s+/);
      let idx=mm? mm.index : -1;
      let sepLen=mm? mm[0].length : 0;
      if(idx!==-1){ name=p.t.slice(0,idx).trim(); desc=p.t.slice(idx+sepLen).trim(); } else if(curCat==='Close by'){ name=p.t; desc=''; }
      if(!name) continue;
      validateUnicode(name, `place name ${curC}/${curCity}/${name}`);
      validateUnicode(desc, `place desc ${curC}/${curCity}/${name}`);
      if(!doc[curC].cities[curCity][curCat]) doc[curC].cities[curCity][curCat]=[];
      doc[curC].cities[curCity][curCat].push({name,desc});
    }
  }
  for(const c of Object.keys(doc)){
    for(const [city,cats] of Object.entries(doc[c].cities)){
      for(const [cat,places] of Object.entries(cats)){
        for(const p of places){
          validateUnicode(p.name, `final ${c}/${city}/${cat} name`);
          validateUnicode(p.desc, `final ${c}/${city}/${cat} desc`);
        }
      }
    }
  }
  const coords={'Berlin':[52.52,13.405],'Munich':[48.1351,11.582],'Hamburg':[53.5511,9.9937],'Cologne':[50.9375,6.9603],'Dresden':[51.0504,13.7373],'Heidelberg':[49.3988,8.6724],'Nuremberg':[49.4521,11.0767],'Rothenburg ob der Tauber':[49.3772,10.1795],'Frankfurt':[50.1109,8.6821],'Freiburg':[47.999,7.8421],'Zurich':[47.3769,8.5417],'Geneva':[46.2044,6.1432],'Lucerne':[47.0502,8.3093],'Bern':[46.948,7.4474],'Interlaken':[46.6863,7.8632],'Zermatt':[46.0207,7.7491],'Lauterbrunnen':[46.5933,7.9087],'St. Moritz':[46.4908,9.8355],'Basel':[47.5596,7.5886],'Montreux':[46.4312,6.9107]};
  const countryInfo={'Germany':{continent:'Europe',desc:'Historic cities, medieval castles, vibrant culture, and diverse landscapes from the Baltic coast to the Bavarian Alps.',flag:'https://flagcdn.com/de.svg',primary:'#000000',secondary:'#DD0000'},'Switzerland':{continent:'Europe',desc:'Alpine peaks, pristine lakes, historic old towns, and world-class mountain railways in the heart of Europe.',flag:'https://flagcdn.com/ch.svg',primary:'#DA021E',secondary:'#FFFFFF'}};
  let sql='-- PinMap Import '+targetCountries.join(',')+'\nUSE pinmap;\nSET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;\n\n';
  for(const c of targetCountries){
    if(!doc[c]) continue;
    const info=countryInfo[c]||{continent:'Europe',desc:c,flag:'',primary:'#000',secondary:'#FFF'};
    validateUnicode(c, 'country name');
    sql+=`INSERT INTO countries (name, continent, description, flag_image, primary_color, secondary_color)\nSELECT '${esc(c)}','${info.continent}','${esc(info.desc)}','${info.flag}','${info.primary}','${info.secondary}' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM countries WHERE name='${esc(c)}');\n`;
    sql+=`SET @${c.toLowerCase().replace(/[^a-z]/g,'')}_id = (SELECT country_id FROM countries WHERE name='${esc(c)}');\n\n`;
  }
  for(const c of targetCountries){
    if(!doc[c]) continue;
    const varC='@'+c.toLowerCase().replace(/[^a-z]/g,'')+'_id';
    for(const city of Object.keys(doc[c].cities)){
      const co=coords[city]||[null,null];
      const lat=co[0]||'NULL', lng=co[1]||'NULL';
      let desc='';
      const cityDescMap={'Berlin':"Germany's vibrant capital of history, culture, and reunification.",'Munich':'Bavarian capital of beer halls, Baroque palaces, and Alpine gateways.','Hamburg':'Historic port city of canals, warehouses, and maritime heritage.','Cologne':'Riverside city dominated by its twin-spired Gothic cathedral.','Dresden':'Baroque jewel on the Elbe, rebuilt after WWII.','Heidelberg':'Romantic university town beneath a hilltop castle ruins.','Nuremberg':'Medieval walled city of imperial castles and historic trials.','Rothenburg ob der Tauber':'Perfectly preserved medieval town on the Romantic Road.','Frankfurt':'Modern skyline meets medieval old town on the River Main.','Freiburg':'Sunny university city at the edge of the Black Forest.','Zurich':'Cosmopolitan lakeside city of finance, art, and medieval lanes.','Geneva':'International city on Lake Geneva, gateway to the Alps.','Lucerne':'Picture-perfect lakeside city surrounded by Alpine peaks.','Bern':"Switzerland's charming capital of arcades and medieval towers.",'Interlaken':'Adventure capital nestled between two lakes and mountain peaks.','Zermatt':'Car-free Alpine village beneath the iconic Matterhorn.','Lauterbrunnen':'Valley of waterfalls and gateway to the Jungfrau region.','St. Moritz':'Glamorous Alpine resort town in the Engadin valley.','Basel':'Cultural city on the Rhine, famed for art museums and old town.','Montreux':'Lakeside resort town famed for its jazz festival and castle.'};
      desc=cityDescMap[city]||city;
      validateUnicode(city, 'city name');
      validateUnicode(desc, 'city desc');
      const cityVar='@'+city.toLowerCase().replace(/[^a-z]/g,'')+'_id';
      sql+=`INSERT INTO cities (country_id, name, description, latitude, longitude)\nSELECT ${varC}, '${esc(city)}','${esc(desc)}', ${lat}, ${lng} FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cities WHERE name='${esc(city)}' AND country_id=${varC});\n`;
      sql+=`SET ${cityVar} = (SELECT city_id FROM cities WHERE name='${esc(city)}' AND country_id=${varC});\n`;
    }
    sql+='\n';
  }
  const catMap={'Historical Sights':1,'For the Art Lovers':2,'Hidden Gems':4};
  let inserts=[];
  for(const c of targetCountries){
    if(!doc[c]) continue;
    for(const [city,cats] of Object.entries(doc[c].cities)){
      const cityVar='@'+city.toLowerCase().replace(/[^a-z]/g,'')+'_id';
      for(const [cat,places] of Object.entries(cats)){
        if(cat==='Close by' || cat==='Atmosphere & Experiences') continue;
        const catId=catMap[cat]||4;
        for(const p of places){
          sql+=`INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)\nSELECT ${cityVar}, ${catId}, '${esc(p.name)}','${esc(p.desc)}', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=${cityVar} AND name='${esc(p.name)}');\n`;
          inserts.push({city,name:p.name,desc:p.desc});
        }
      }
    }
  }
  validateUnicode(sql.slice(0,10000), 'generated SQL header');
  if(/\?{3,}/.test(sql)) throw new Error('Generated SQL contains ??? corruption');
  if(/[ÃÂ]/.test(sql) && /Ã/.test(sql) && sql.includes('Ã¶')) throw new Error('Generated SQL contains mojibake Ã');
  const outPath=path.join(__dirname,'..',`pinmap_import_${targetCountries.join('_')}.sql`);
  fs.writeFileSync(outPath, sql, 'utf8');
  console.log(`Generated SQL ${outPath} length ${sql.length} with ${inserts.length} places`);
  const conn=await pool.getConnection();
  try{
    await conn.beginTransaction();
    await conn.query('SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci');
    const statements=sql.split(';\n').map(s=>s.trim()).filter(s=>s && !s.startsWith('--'));
    for(const stmt of statements){
      if(!stmt) continue;
      await conn.query(stmt);
    }
    const [hexCheck]=await conn.query("SELECT place_id,name,HEX(name) hx,HEX(short_description) dhx FROM places WHERE name IN ("+inserts.slice(0,5).map(()=> '?').join(',')+")", inserts.slice(0,5).map(i=>i.name));
    console.log('post-import hex sample', hexCheck.map(r=>`${r.name}:${r.hx.slice(0,40)}`).join(' | '));
    for(const r of hexCheck){
      if(r.hx.includes('3F3F3F')) throw new Error(`Post-import corrupted hex for ${r.name}`);
    }
    const [qCount]=await conn.query("SELECT COUNT(*) AS c FROM places WHERE short_description LIKE '%\\?\\?\\?%' AND city_id IN (SELECT city_id FROM cities WHERE country_id IN (SELECT country_id FROM countries WHERE name IN (?)))", [targetCountries]);
    if(qCount[0].c>0) throw new Error(`Post-import found ${qCount[0].c} corrupted ??? rows`);
    await conn.commit();
    console.log(`COMMIT SUCCESS for ${targetCountries.join(',')}`);
  }catch(e){
    await conn.rollback();
    console.error('ROLLBACK due to', e.message);
    throw e;
  }finally{ conn.release(); }
  return {sqlPath: `pinmap_import_${targetCountries.join('_')}.sql`, count: inserts.length};
}

if(require.main===module){
  const args=process.argv.slice(2);
  const sourceIdx=args.indexOf('--source');
  const countryIdx=args.indexOf('--country');
  const source=sourceIdx!==-1?args[sourceIdx+1]:process.env.TEMP+'\\docx_read\\data.xml';
  const countries=countryIdx!==-1?args[countryIdx+1].split(',').map(s=>s.trim()):['Germany','Switzerland'];
  importFromDocx({sourceXml:source, targetCountries:countries}).then(r=>console.log('Done',r)).catch(e=>{console.error('IMPORT FAILED:',e.message); process.exit(1);});
}
module.exports={importFromDocx, validateUnicode};
