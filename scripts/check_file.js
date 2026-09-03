const fs=require('fs');
const data=fs.readFileSync('C:\\Users\\User\\Desktop\\Desi\\App\\pinmap_germany_switzerland.sql','utf8');
const m=data.match(/Sch.{0,10}ner Brunnen/);
console.log(m?m[0]:'not found');
console.log(data.includes('Schöner Brunnen')?'has correct':'no correct');
console.log(data.includes('SchÃ¶ner')?'has mangled':'no mangled');
console.log(data.includes('Sch????')?'has ????':'no ????');
// hex of first occurrence
const idx=data.indexOf('Schöner');
if(idx!==-1){
  const slice=data.slice(idx, idx+20);
  console.log(slice);
  console.log(Buffer.from(slice,'utf8').toString('hex'));
}
// check file bytes
const buf=fs.readFileSync('C:\\Users\\User\\Desktop\\Desi\\App\\pinmap_germany_switzerland.sql');
const idx2=buf.indexOf(Buffer.from('Sch'));
if(idx2!==-1){
  console.log(buf.slice(idx2, idx2+30).toString('hex'));
  console.log(buf.slice(idx2, idx2+30).toString('utf8'));
}
