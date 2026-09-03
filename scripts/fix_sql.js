/* DEPRECATED — DO NOT USE FOR NEW IMPORTS
   Use: node scripts/import_places.js --source "<source-file>" --country "<country>"
   This legacy repair script is retained for historical reference only. */
console.error('DEPRECATED: fix_sql.js is retired. Use: node scripts/import_places.js --source "<source-file>" --country "<country>"');
process.exit(1);
const fs=require('fs');
let sql=fs.readFileSync('C:\\Users\\User\\Desktop\\Desi\\App\\pinmap_germany_switzerland.sql','utf8');
const map=[
  ['Ã¶','ö'],
  ['Ã–','Ö'],
  ['Ã¼','ü'],
  ['Ãœ','Ü'],
  ['Ã¤','ä'],
  ['Ã„','Ä'],
  ['ÃŸ','ß'],
  ['Ã©','é'],
  ['Ã¨','è'],
  ['Ãê','ê'],
  ['Ãë','ë'],
  ['Ã¡','á'],
  ['Ã ','à'],
  ['Ã¢','â'],
  ['Ã´','ô'],
  ['Ã³','ó'],
  ['Ã²','ò'],
  ['Ãñ','ñ'],
  ['Ã±','ñ'],
  ['Ã‘','Ñ'],
  ['Ã§','ç'],
  ['Ã‰','É'],
  ['Ã ','à '], // sometimes
  ['â€”','—'],
  ['â€“','–'],
  ['â€œ','“'],
  ['â€','”'],
  ['â€™','’'],
  ['â€˜','‘'],
  ['Ã³','ó'],
  ['Ã','à'], // fallback?
];
// do longer first
map.sort((a,b)=>b[0].length-a[0].length);
for(const [from,to] of map){
  sql=sql.split(from).join(to);
}
// specific fixes for known issues
sql=sql.replace(/Ã³bidos/g,'Óbidos');
sql=sql.replace(/SchÃ¶ner/g,'Schöner');
sql=sql.replace(/TiergÃ¤rtnertorplatz/g,'Tiergärtnertorplatz');
sql=sql.replace(/FÃ¼rstenzug/g,'Fürstenzug');
sql=sql.replace(/BrÃ¼hl/g,'Brühl');
sql=sql.replace(/SÃ¼dfriedhof/g,'Südfriedhof');
sql=sql.replace(/SchnÃ¼tgen/g,'Schnütgen');
sql=sql.replace(/KÃ¤figturm/g,'Käfigturm');
sql=sql.replace(/MÃ¼nster/g,'Münster');
sql=sql.replace(/BÃ¤chle/g,'Bächle');
sql=sql.replace(/StraÃŸe/g,'Straße');
sql=sql.replace(/GroÃŸmÃ¼nster/g,'Großmünster');
sql=sql.replace(/FraumÃ¼nster/g,'Fraumünster');
sql=sql.replace(/ZÃ¼rich/g,'Zürich');
sql=sql.replace(/RÃ¶mer/g,'Römer');
sql=sql.replace(/StÃ¤del/g,'Städel');
sql=sql.replace(/ChÃ¢teau/g,'Château');
sql=sql.replace(/Bains des PÃ¢quis/g,'Bains des Pâquis');
sql=sql.replace(/ÃŽle/g,'Île');
sql=sql.replace(/MÃ¼rren/g,'Mürren');
sql=sql.replace(/TrÃ¼mmelbach/g,'Trümmelbach');
sql=sql.replace(/KÃ¶nigssee/g,'Königssee');
sql=sql.replace(/DÃ¼rer/g,'Dürer');
sql=sql.replace(/NÃ¼rnberg/g,'Nürnberg');
sql=sql.replace(/WeiÃŸgerber/g,'Weißgerber');
sql=sql.replace(/PlÃ¶nlein/g,'Plönlein');
sql=sql.replace(/HÃ¶heweg/g,'Höheweg');
sql=sql.replace(/Freiburg BÃ¤chle/g,'Freiburg Bächle');
sql=sql.replace(/KonviktstraÃŸe/g,'Konviktstraße');
sql=sql.replace(/Ã–velgÃ¶nne/g,'Övelgönne');
sql=sql.replace(/MÃ¡laga/g,'Málaga');
sql=sql.replace(/San SebastiÃ¡n/g,'San Sebastián');
sql=sql.replace(/Ã“bidos/g,'Óbidos');
sql=sql.replace(/Ã–/g,'Ö');
sql=sql.replace(/Ã¼/g,'ü');
sql=sql.replace(/Ã¶/g,'ö');
sql=sql.replace(/Ã¤/g,'ä');

fs.writeFileSync('C:\\Users\\User\\Desktop\\Desi\\App\\pinmap_germany_switzerland.sql',sql,'utf8');
console.log('fixed');
console.log(sql.slice(0,500));
console.log(sql.includes('Schöner')?'has Schöner':'no');
console.log(sql.includes('Brühl')?'has Brühl':'no');
