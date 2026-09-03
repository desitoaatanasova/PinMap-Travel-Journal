/* DEPRECATED — DO NOT USE FOR NEW IMPORTS
   Use: node scripts/import_places.js --source "<source-file>" --country "<country>" */
console.error('DEPRECATED: parse_doc.js is retired. Use: node scripts/import_places.js --source "<source-file>" --country "<country>"');
process.exit(1);
const fs=require('fs');
const path=require('path');
const xml=fs.readFileSync(process.env.TEMP+'\\docx_read\\data.xml','utf8');
const reP=/<w:p[^>]*>([\s\S]*?)<\/w:p>/g;
let paras=[];
let m;
while(m=reP.exec(xml)){
  const pXml=m[1];
  const t=[...pXml.matchAll(/<w:t[^>]*>([^<]*)<\/w:t>/g)].map(x=>x[1]).join('').trim().replace(/\s+/g,' ');
  if(!t) continue;
  const il=(pXml.match(/<w:ilvl[^>]*w:val="([0-9]+)"/)||[])[1]||null;
  paras.push({t,il});
}
const knownCats=new Set(['Historical Sights','For the Art Lovers','Hidden Gems','Atmosphere & Experiences','Atmosphere & experience','Close by']);
const countriesSet=new Set(['Italy','France','Spain','Portugal','Ireland','England','Scotland','Belgium','The Netherlands','Netherlands','Germany','Switzerland']);
let doc={};
let curCountry=null,curCity=null,curCat=null;
for(const p of paras){
  if(p.t==='PinMap Data') continue;
  if(countriesSet.has(p.t) && p.il==='0'){ curCountry=p.t==='Netherlands'?'The Netherlands':p.t; curCity=null; curCat=null; if(!doc[curCountry]) doc[curCountry]={cities:{}}; continue; }
  if(curCountry && knownCats.has(p.t)){ curCat=p.t; if(curCity && !doc[curCountry].cities[curCity][curCat]) doc[curCountry].cities[curCity][curCat]=[]; continue; }
  if(curCountry && p.il==='1' && !p.t.includes('—') && !p.t.includes('–') && !p.t.includes(' - ') && !knownCats.has(p.t) && p.t.length<40 && !p.t.startsWith('Walk') && !p.t.startsWith('Visit') && !p.t.startsWith('Take') && !p.t.startsWith('Explore') && !p.t.startsWith('Cross') && !p.t.startsWith('Climb') && !p.t.startsWith('Try') && !p.t.startsWith('Watch') && !p.t.startsWith('Wander') && !p.t.startsWith('Go ') && !p.t.startsWith('Sit ') && !p.t.startsWith('Use ') && !p.t.startsWith('See ') && !p.t.startsWith('Experience')){
    // heuristic city detection: no dash, short, and previous was country or Close by or category change
    // also check that next paras are categories, not places under city incorrectly
    // We'll treat as city if it doesn't look like a place description
    // Places always have — or are short but with dash; cities are single words or short phrases
    // Additional filter: city names are known to be capitalised single word or 2 words, not sentences
    if(p.t.split(' ').length<=3 && !p.t.includes('.') && !p.t.includes('(')){
      curCity=p.t; curCat=null;
      if(!doc[curCountry].cities[curCity]) doc[curCountry].cities[curCity]={};
      continue;
    }
  }
  // place
  if(curCountry && curCity && curCat){
    // p.t should be like "Colosseum — description" or "Trastevere — ..."
    // Close by places have "Tivoli (≅1 hour) — ..." or just "Tivoli (≅1 hour)" with next line description
    // We'll capture as place entry even if no dash, but filter out atmosphere instructions that are sentences
    // For now, only capture if it looks like a place: contains — or is short and next is description, or is under Close by with parenthesis
    const isPlace = p.t.includes('—') || p.t.includes('–') || p.t.includes(' - ') || curCat==='Close by' || curCat==='Historical Sights' || curCat==='For the Art Lovers' || curCat==='Hidden Gems';
    if(isPlace){
      // skip atmosphere instructions that are verbose sentences without a clear name — they are under Atmosphere but many are activities not places
      // We'll still capture but filter later: if Atmosphere and no dash and sentence length > 80, maybe skip? Keep but they are valid atmosphere entries in DB (like Trastevere)
      // For Germany parsing, many atmosphere entries are like "Walk along the Rhine..." – those should be skipped as they are activity suggestions, not DB places? But existing Italy places include Trastevere, Piazza Navona etc which are atmosphere places that are valid. How to distinguish?
      // Heuristic: atmosphere places that are named places have — and short name; activity sentences are longer and start with verb
      if(curCat==='Atmosphere & Experiences' || curCat==='Atmosphere & experience'){
        if(!p.t.includes('—') && !p.t.includes('–') && (p.t.startsWith('Walk')||p.t.startsWith('Visit')||p.t.startsWith('Take')||p.t.startsWith('Explore')||p.t.startsWith('Cross')||p.t.startsWith('Climb')||p.t.startsWith('Try')||p.t.startsWith('Watch')||p.t.startsWith('Wander')||p.t.startsWith('Go ')||p.t.startsWith('Sit ')||p.t.startsWith('Use ')||p.t.startsWith('See ')||p.t.startsWith('Experience')||p.t.startsWith('Ride')||p.t.startsWith('Enjoy')||p.t.startsWith('Admire')||p.t.startsWith('Discover')||p.t.length>70)) continue;
      }
      if(!doc[curCountry].cities[curCity][curCat]) doc[curCountry].cities[curCity][curCat]=[];
      // split name and desc
      let name=p.t, desc='';
      const dashIdx=p.t.indexOf('—')!==-1?p.t.indexOf('—'):p.t.indexOf('–')!==-1?p.t.indexOf('–'):p.t.indexOf(' - ');
      if(dashIdx!==-1){ name=p.t.slice(0,dashIdx).trim(); desc=p.t.slice(dashIdx+1).trim().replace(/^[\-—–]\s*/,''); } else if(curCat==='Close by' && p.t.includes('(')){ // e.g. "Tivoli (≅1 hour)"
        name=p.t; desc='';
      }
      // clean name: remove trailing ' —' remnants
      name=name.replace(/\s+$/,'');
      if(name) doc[curCountry].cities[curCity][curCat].push({name,desc,raw:p.t});
    }
  }
}
// print summary
for(const [c, data] of Object.entries(doc)){
  console.log(c+': '+Object.keys(data.cities).length+' cities');
  for(const [city,cats] of Object.entries(data.cities)){
    const total=Object.values(cats).reduce((s,a)=>s+a.length,0);
    console.log('  '+city+': '+total+' places ('+Object.entries(cats).map(([k,v])=>k+':'+v.length).join(', ')+')');
  }
}
fs.writeFileSync(path.join(__dirname,'doc_parsed.json'), JSON.stringify(doc,null,2),'utf8');
console.log('written doc_parsed.json');
