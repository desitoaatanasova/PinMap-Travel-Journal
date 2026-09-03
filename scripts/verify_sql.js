const fs=require('fs');
const s=fs.readFileSync('C:\\Users\\User\\Desktop\\Desi\\App\\pinmap_germany_switzerland.sql','utf8');
console.log(s.includes('Ã')?'still mangled Ã':'clean');
console.log(s.includes('â€”')?'has emdash encoded':'clean dash');
console.log((s.match(/Schöner/g)||[]).length);
console.log((s.match(/Fürstenzug/g)||[]).length);
console.log((s.match(/Brühl/g)||[]).length);
