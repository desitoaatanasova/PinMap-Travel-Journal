function fix(s){
  // try various
  try { return Buffer.from(s, 'binary').toString('utf8'); } catch(e){ return 'err1' }
}
const tests = ["SchÃ¶ner Brunnen", "BrÃ¼hl's Terrace", "FÃ¼rstenzug", "MÃ¼nsterplatz", "ChÃ¢teau de Chillon", "TiergÃ¤rtnertorplatz", "SchÃ¶ner"];
for(const t of tests){
  console.log(t, "->", fix(t));
  console.log("  alt:", Buffer.from(t, 'latin1').toString('utf8'));
  console.log("  utf8->latin1:", Buffer.from(t, 'utf8').toString('latin1'));
}
console.log(fix("MÃ¡laga"));
console.log(Buffer.from("MÃ¡laga", 'binary').toString('utf8'));
