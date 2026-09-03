const pool=require('../backend/db');
const {validateUnicode}=require('./import_places');
(async()=>{
  const [before]=await pool.query("SELECT COUNT(*) AS c FROM places");
  console.log(`before count ${before[0].c}`);
  const badDesc="Berlin????????s test";
  try{
    validateUnicode(badDesc, 'test corrupted description');
    console.error("FAIL should have thrown");
    process.exit(1);
  }catch(e){
    console.log(`PASS pre-import rejected: ${e.message}`);
  }
  const conn=await pool.getConnection();
  try{
    await conn.beginTransaction();
    await conn.query("INSERT INTO places (city_id, category_id, name, short_description) VALUES (1,1, 'TestCorruptPlace', ?)", [badDesc]);
    const [check]=await conn.query("SELECT COUNT(*) AS c FROM places WHERE name='TestCorruptPlace'");
    console.log(`inside tx count for TestCorruptPlace ${check[0].c}`);
    validateUnicode(badDesc, 'post-import check');
    await conn.commit();
    console.error("FAIL should not commit");
  }catch(e){
    await conn.rollback();
    console.log(`ROLLBACK as expected: ${e.message}`);
  }finally{ conn.release(); }
  const [after]=await pool.query("SELECT COUNT(*) AS c FROM places");
  const [exists]=await pool.query("SELECT COUNT(*) AS c FROM places WHERE name='TestCorruptPlace'");
  console.log(`after count ${after[0].c} exists ${exists[0].c}`);
  if(exists[0].c!==0) {console.error("FAIL rollback left corrupted row"); process.exit(1)}
  if(before[0].c!==after[0].c) {console.error("FAIL count changed"); process.exit(1)}
  console.log("PASS rollback test — no corrupted data persisted");
  await pool.end();
})();
