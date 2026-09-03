/* DEPRECATED — DO NOT USE FOR NEW IMPORTS
   Use: node scripts/import_places.js --source "<source-file>" --country "<country>"
   This script is retained for historical reference only. */
console.error('DEPRECATED: generate_sql.js is retired. Use: node scripts/import_places.js --source "<source-file>" --country "<country>"');
process.exit(1);
const fs=require('fs');
const path=require('path');
const xml=fs.readFileSync(process.env.TEMP+'\\docx_read\\data.xml','utf8');
const reP=/<w:p[^>]*>([\s\S]*?)<\/w:p>/g;
function fixEncoding(s){
  if (/[ÃÂ]/.test(s)) {
    try { const fixed = Buffer.from(s, 'binary').toString('utf8'); if (fixed && !fixed.includes('Ã') && !fixed.includes('�')) return fixed; } catch(e){}
  }
  return s;
}
let paras=[];
let m;
while(m=reP.exec(xml)){
  const pXml=m[1];
  let t=[...pXml.matchAll(/<w:t[^>]*>([^<]*)<\/w:t>/g)].map(x=>x[1]).join('').trim().replace(/\s+/g,' ');
  if(!t) continue;
  t = fixEncoding(t);
  t = t.replace(/&amp;/g,'&');
  const il=(pXml.match(/<w:ilvl[^>]*w:val="([0-9]+)"/)||[])[1]||null;
  const num=(pXml.match(/<w:numId[^>]*w:val="([0-9]+)"/)||[])[1]||null;
  paras.push({t,il,num});
}
const catsSet=new Set(['Historical Sights','For the Art Lovers','For the Art & Culture Lovers','For the Art &amp; Culture Lovers','Hidden Gems','Atmosphere & Experiences','Atmosphere &amp; Experiences','Atmosphere & experience','Close by']);
const countryNames=['Italy','France','Spain','Portugal','Ireland','England','Scotland','Belgium','The Netherlands','Netherlands','Germany','Switzerland'];
let doc={};
let curC=null,curCity=null,curCat=null;
for(const p of paras){
  if(p.t==='PinMap Data') continue;
  if(countryNames.includes(p.t) && p.il==='0' && p.num==='1'){
    curC=p.t==='Netherlands'?'The Netherlands':p.t;
    curCity=null;curCat=null;
    if(!doc[curC]) doc[curC]={cities:{}};
    continue;
  }
  if(curC && catsSet.has(p.t)){
    let n=p.t.replace(/&amp;/g,'&');
    if(n==='For the Art & Culture Lovers') n='For the Art Lovers';
    if(n==='Atmosphere & Experiences') n='Atmosphere & Experiences';
    curCat=n;
    if(curCity && !doc[curC].cities[curCity][curCat]) doc[curC].cities[curCity][curCat]=[];
    continue;
  }
  if(curC && p.il==='1' && p.num==='1' && !catsSet.has(p.t)){
    // city: heuristic ensure not a place (places never have num=1)
    // also filter short activity sentences that slipped? cities are short, no dash, no parenthesis time
    if(p.t.includes('—')||p.t.includes('–')) continue;
    // city names are <=4 words, no sentence punctuation
    if(p.t.length>50) continue;
    curCity=p.t;
    curCat=null;
    if(!doc[curC].cities[curCity]) doc[curC].cities[curCity]={};
    continue;
  }
  if(curC && curCity && curCat && p.il==='1' && (p.num!=='1')){
    const hasDash = p.t.match(/\s+[—–]\s+|\s+â€”\s+/);
    if(!hasDash){
      if(/^(Walk|Explore|Visit|Take|Cross|Climb|Try|Watch|Wander|Go |Sit |Use |See |Experience|Ride|Enjoy|Admire|Discover|Browse|Relax|Look |Hike|Small lanes|Traditional|The |Explore traditional|Visit local|Look for|Discover the|Small lanes)/.test(p.t)) continue;
      if(p.t.length>80) continue;
    }
    let name=p.t, desc='';
    let m=p.t.match(/\s+[—–]\s+|\s+â€”\s+/);
    let idx=m? m.index : -1;
    let sepLen=m? m[0].length : 0;
    if(idx!==-1){ name=p.t.slice(0,idx).trim(); desc=p.t.slice(idx+sepLen).trim(); } else if(curCat==='Close by'){ name=p.t; desc=''; } else {
      name=p.t; desc='';
    }
    if(!name) continue;
    if(!doc[curC].cities[curCity][curCat]) doc[curC].cities[curCity][curCat]=[];
    doc[curC].cities[curCity][curCat].push({name,desc});
  }
}
console.log(Object.keys(doc));
for(const [c,d] of Object.entries(doc)) console.log(c, Object.keys(d.cities).length, Object.keys(d.cities).join(', '));

// Only keep Germany and Switzerland for generation, but verify others match existing
const target=['Germany','Switzerland'];
let out=[];
for(const c of target){
  const cities=doc[c].cities;
  console.log(`\n${c} cities:`,Object.keys(cities));
  for(const [city,cats] of Object.entries(cities)){
    for(const [cat,places] of Object.entries(cats)){
      console.log(` ${city} / ${cat}: ${places.length}`);
    }
  }
}
fs.writeFileSync(path.join(__dirname,'doc_filtered.json'),JSON.stringify(Object.fromEntries(target.map(c=>[c,doc[c]])),null,2),'utf8');

// city coords
const coords={
  'Berlin':[52.5200,13.4050],
  'Munich':[48.1351,11.5820],
  'Hamburg':[53.5511,9.9937],
  'Cologne':[50.9375,6.9603],
  'Dresden':[51.0504,13.7373],
  'Heidelberg':[49.3988,8.6724],
  'Nuremberg':[49.4521,11.0767],
  'Rothenburg ob der Tauber':[49.3772,10.1795],
  'Frankfurt':[50.1109,8.6821],
  'Freiburg':[47.9990,7.8421],
  'Zurich':[47.3769,8.5417],
  'Geneva':[46.2044,6.1432],
  'Lucerne':[47.0502,8.3093],
  'Bern':[46.9480,7.4474],
  'Interlaken':[46.6863,7.8632],
  'Zermatt':[46.0207,7.7491],
  'Lauterbrunnen':[46.5933,7.9087],
  'St. Moritz':[46.4908,9.8355],
  'St Moritz':[46.4908,9.8355],
  'Basel':[47.5596,7.5886],
  'Montreux':[46.4312,6.9107],
};
const countryInfo={
  'Germany':{continent:'Europe',desc:'Historic cities, medieval castles, vibrant culture, and diverse landscapes from the Baltic coast to the Bavarian Alps.',flag:'https://flagcdn.com/de.svg',primary:'#000000',secondary:'#DD0000'},
  'Switzerland':{continent:'Europe',desc:'Alpine peaks, pristine lakes, historic old towns, and world-class mountain railways in the heart of Europe.',flag:'https://flagcdn.com/ch.svg',primary:'#DA021E',secondary:'#FFFFFF'}
};
function esc(s){ return s.replace(/'/g,"''").replace(/\\/g,'\\\\'); }

let sql='-- PinMap Germany & Switzerland Data\n-- Source: PinMap data updated.docx + Colour scheme.docx\n-- Idempotent: safe to run multiple times (WHERE NOT EXISTS)\nUSE pinmap;\n\n';
for(const c of target){
  const info=countryInfo[c];
  sql+=`-- ===== ${c.toUpperCase()} =====\n`;
  sql+=`INSERT INTO countries (name, continent, description, flag_image, primary_color, secondary_color)\nSELECT '${esc(c)}','${info.continent}','${esc(info.desc)}','${info.flag}','${info.primary}','${info.secondary}' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM countries WHERE name='${esc(c)}');\n`;
  sql+=`SET @${c.toLowerCase().replace(/[^a-z]/g,'')}_id = (SELECT country_id FROM countries WHERE name='${esc(c)}');\n\n`;
}
for(const c of target){
  const varC='@'+c.toLowerCase().replace(/[^a-z]/g,'')+'_id';
  for(const city of Object.keys(doc[c].cities)){
    const co=coords[city]||[null,null];
    const lat=co[0]||'NULL', lng=co[1]||'NULL';
    let desc='';
    if(city==='Berlin') desc="Germany's vibrant capital of history, culture, and reunification.";
    else if(city==='Munich') desc='Bavarian capital of beer halls, Baroque palaces, and Alpine gateways.';
    else if(city==='Hamburg') desc='Historic port city of canals, warehouses, and maritime heritage.';
    else if(city==='Cologne') desc='Riverside city dominated by its twin-spired Gothic cathedral.';
    else if(city==='Dresden') desc='Baroque jewel on the Elbe, rebuilt after WWII.';
    else if(city==='Heidelberg') desc='Romantic university town beneath a hilltop castle ruins.';
    else if(city==='Nuremberg') desc='Medieval walled city of imperial castles and historic trials.';
    else if(city==='Rothenburg ob der Tauber') desc='Perfectly preserved medieval town on the Romantic Road.';
    else if(city==='Frankfurt') desc='Modern skyline meets medieval old town on the River Main.';
    else if(city==='Freiburg') desc='Sunny university city at the edge of the Black Forest.';
    else if(city==='Zurich') desc='Cosmopolitan lakeside city of finance, art, and medieval lanes.';
    else if(city==='Geneva') desc='International city on Lake Geneva, gateway to the Alps.';
    else if(city==='Lucerne') desc='Picture-perfect lakeside city surrounded by Alpine peaks.';
    else if(city==='Bern') desc="Switzerland's charming capital of arcades and medieval towers.";
    else if(city==='Interlaken') desc='Adventure capital nestled between two lakes and mountain peaks.';
    else if(city==='Zermatt') desc='Car-free Alpine village beneath the iconic Matterhorn.';
    else if(city==='Lauterbrunnen') desc='Valley of waterfalls and gateway to the Jungfrau region.';
    else if(city==='St. Moritz' || city==='St Moritz') desc='Glamorous Alpine resort town in the Engadin valley.';
    else if(city==='Basel') desc='Cultural city on the Rhine, famed for art museums and old town.';
    else if(city==='Montreux') desc='Lakeside resort town famed for its jazz festival and castle.';
    else desc=city;
    const cityVar='@'+city.toLowerCase().replace(/[^a-z]/g,'')+'_id';
    sql+=`INSERT INTO cities (country_id, name, description, latitude, longitude)\nSELECT ${varC}, '${esc(city)}','${esc(desc)}', ${lat}, ${lng} FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cities WHERE name='${esc(city)}' AND country_id=${varC});\n`;
    sql+=`SET ${cityVar} = (SELECT city_id FROM cities WHERE name='${esc(city)}' AND country_id=${varC});\n`;
  }
  sql+='\n';
}
const catMap={'Historical Sights':1,'For the Art Lovers':2,'Atmosphere & Experiences':3,'Hidden Gems':4,'Close by':5};
for(const c of target){
  for(const [city,cats] of Object.entries(doc[c].cities)){
    const cityVar='@'+city.toLowerCase().replace(/[^a-z]/g,'')+'_id';
    for(const [cat,places] of Object.entries(cats)){
      if(cat==='Close by' || cat==='Atmosphere & Experiences') continue;
      const catId=catMap[cat]||4;
      for(const p of places){
        // skip duplicates within doc (e.g., Philosophers Walk appears twice)
        sql+=`INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)\nSELECT ${cityVar}, ${catId}, '${esc(p.name)}','${esc(p.desc)}', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=${cityVar} AND name='${esc(p.name)}');\n`;
      }
    }
  }
}
fs.writeFileSync(path.join(__dirname,'..','pinmap_germany_switzerland.sql'),sql,'utf8');
console.log('generated sql length',sql.length);

// also generate dedup check summary
let existingPlaces=new Set();
for(const f of fs.readdirSync(path.join(__dirname,'..')).filter(f=>f.startsWith('pinmap_places'))){
  const content=fs.readFileSync(path.join(__dirname,'..',f),'utf8');
  for(const mm of content.matchAll(/'([^']+)'\s*,\s*'([^']*)'\s*,\s*([0-9.\-]+)\s*,\s*([0-9.\-]+)/g)){}
}
