const mangled="SchÃ¶ner Brunnen â€” Extraordinary collection";
function fix(s){
  if (/[ÃÂ]/.test(s)) {
    try { const fixed = Buffer.from(s, 'binary').toString('utf8'); console.log('fixed', fixed, 'has Ã', fixed.includes('Ã'), 'has �', fixed.includes('�')); if (fixed && !fixed.includes('Ã') && !fixed.includes('�')) return fixed; } catch(e){ console.log(e)}
  }
  return s;
}
console.log(fix(mangled));
// try reading actual file's string
const fs=require('fs');
const xml=fs.readFileSync(process.env.TEMP+'\\docx_read\\data.xml','utf8');
const m=xml.match(/Sch[^<]*Brunnen/);
console.log('found', m?m[0]:'none');
console.log('hex', m?Buffer.from(m[0],'utf8').toString('hex'):'');

const raw=Buffer.from(m[0],'binary').toString('utf8');
console.log('raw fixed', raw);

const direct=fs.readFileSync(process.env.TEMP+'\\docx_read\\data.xml');
console.log('direct bytes hex', direct.slice(direct.indexOf(Buffer.from('Sch'))-10, direct.indexOf(Buffer.from('Sch'))+40).toString('hex'));
