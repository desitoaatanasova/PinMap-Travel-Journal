console.log(Buffer.from("â€”", 'binary').toString('utf8').charCodeAt(0).toString(16));
console.log(Buffer.from("â€”", 'binary').toString('utf8'));
console.log(Buffer.from(" — ", 'binary').toString('utf8'));
console.log("SchÃ¶ner Brunnen â€” Extraordinary".split(''));
console.log(Buffer.from("SchÃ¶ner Brunnen â€” Extraordinary", 'binary').toString('utf8'));
console.log(Buffer.from("SchÃ¶ner Brunnen â€” Extraordinary", 'binary').toString('utf8').split('').map(c=>c.charCodeAt(0).toString(16)));
