-- PinMap Germany & Switzerland Data
-- Source: PinMap data updated.docx + Colour scheme.docx
-- Idempotent: safe to run multiple times (WHERE NOT EXISTS)
USE pinmap;

-- ===== GERMANY =====
INSERT INTO countries (name, continent, description, flag_image, primary_color, secondary_color)
SELECT 'Germany','Europe','Historic cities, medieval castles, vibrant culture, and diverse landscapes from the Baltic coast to the Bavarian Alps.','https://flagcdn.com/de.svg','#000000','#DD0000' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM countries WHERE name='Germany');
SET @germany_id = (SELECT country_id FROM countries WHERE name='Germany');

-- ===== SWITZERLAND =====
INSERT INTO countries (name, continent, description, flag_image, primary_color, secondary_color)
SELECT 'Switzerland','Europe','Alpine peaks, pristine lakes, historic old towns, and world-class mountain railways in the heart of Europe.','https://flagcdn.com/ch.svg','#DA021E','#FFFFFF' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM countries WHERE name='Switzerland');
SET @switzerland_id = (SELECT country_id FROM countries WHERE name='Switzerland');

INSERT INTO cities (country_id, name, description, latitude, longitude)
SELECT @germany_id, 'Berlin','Germany''s vibrant capital of history, culture, and reunification.', 52.52, 13.405 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cities WHERE name='Berlin' AND country_id=@germany_id);
SET @berlin_id = (SELECT city_id FROM cities WHERE name='Berlin' AND country_id=@germany_id);
INSERT INTO cities (country_id, name, description, latitude, longitude)
SELECT @germany_id, 'Munich','Bavarian capital of beer halls, Baroque palaces, and Alpine gateways.', 48.1351, 11.582 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cities WHERE name='Munich' AND country_id=@germany_id);
SET @munich_id = (SELECT city_id FROM cities WHERE name='Munich' AND country_id=@germany_id);
INSERT INTO cities (country_id, name, description, latitude, longitude)
SELECT @germany_id, 'Hamburg','Historic port city of canals, warehouses, and maritime heritage.', 53.5511, 9.9937 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cities WHERE name='Hamburg' AND country_id=@germany_id);
SET @hamburg_id = (SELECT city_id FROM cities WHERE name='Hamburg' AND country_id=@germany_id);
INSERT INTO cities (country_id, name, description, latitude, longitude)
SELECT @germany_id, 'Cologne','Riverside city dominated by its twin-spired Gothic cathedral.', 50.9375, 6.9603 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cities WHERE name='Cologne' AND country_id=@germany_id);
SET @cologne_id = (SELECT city_id FROM cities WHERE name='Cologne' AND country_id=@germany_id);
INSERT INTO cities (country_id, name, description, latitude, longitude)
SELECT @germany_id, 'Dresden','Baroque jewel on the Elbe, rebuilt after WWII.', 51.0504, 13.7373 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cities WHERE name='Dresden' AND country_id=@germany_id);
SET @dresden_id = (SELECT city_id FROM cities WHERE name='Dresden' AND country_id=@germany_id);
INSERT INTO cities (country_id, name, description, latitude, longitude)
SELECT @germany_id, 'Heidelberg','Romantic university town beneath a hilltop castle ruins.', 49.3988, 8.6724 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cities WHERE name='Heidelberg' AND country_id=@germany_id);
SET @heidelberg_id = (SELECT city_id FROM cities WHERE name='Heidelberg' AND country_id=@germany_id);
INSERT INTO cities (country_id, name, description, latitude, longitude)
SELECT @germany_id, 'Nuremberg','Medieval walled city of imperial castles and historic trials.', 49.4521, 11.0767 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cities WHERE name='Nuremberg' AND country_id=@germany_id);
SET @nuremberg_id = (SELECT city_id FROM cities WHERE name='Nuremberg' AND country_id=@germany_id);
INSERT INTO cities (country_id, name, description, latitude, longitude)
SELECT @germany_id, 'Rothenburg ob der Tauber','Perfectly preserved medieval town on the Romantic Road.', 49.3772, 10.1795 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cities WHERE name='Rothenburg ob der Tauber' AND country_id=@germany_id);
SET @rothenburgobdertauber_id = (SELECT city_id FROM cities WHERE name='Rothenburg ob der Tauber' AND country_id=@germany_id);
INSERT INTO cities (country_id, name, description, latitude, longitude)
SELECT @germany_id, 'Frankfurt','Modern skyline meets medieval old town on the River Main.', 50.1109, 8.6821 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cities WHERE name='Frankfurt' AND country_id=@germany_id);
SET @frankfurt_id = (SELECT city_id FROM cities WHERE name='Frankfurt' AND country_id=@germany_id);
INSERT INTO cities (country_id, name, description, latitude, longitude)
SELECT @germany_id, 'Freiburg','Sunny university city at the edge of the Black Forest.', 47.999, 7.8421 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cities WHERE name='Freiburg' AND country_id=@germany_id);
SET @freiburg_id = (SELECT city_id FROM cities WHERE name='Freiburg' AND country_id=@germany_id);

INSERT INTO cities (country_id, name, description, latitude, longitude)
SELECT @switzerland_id, 'Zurich','Cosmopolitan lakeside city of finance, art, and medieval lanes.', 47.3769, 8.5417 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cities WHERE name='Zurich' AND country_id=@switzerland_id);
SET @zurich_id = (SELECT city_id FROM cities WHERE name='Zurich' AND country_id=@switzerland_id);
INSERT INTO cities (country_id, name, description, latitude, longitude)
SELECT @switzerland_id, 'Geneva','International city on Lake Geneva, gateway to the Alps.', 46.2044, 6.1432 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cities WHERE name='Geneva' AND country_id=@switzerland_id);
SET @geneva_id = (SELECT city_id FROM cities WHERE name='Geneva' AND country_id=@switzerland_id);
INSERT INTO cities (country_id, name, description, latitude, longitude)
SELECT @switzerland_id, 'Lucerne','Picture-perfect lakeside city surrounded by Alpine peaks.', 47.0502, 8.3093 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cities WHERE name='Lucerne' AND country_id=@switzerland_id);
SET @lucerne_id = (SELECT city_id FROM cities WHERE name='Lucerne' AND country_id=@switzerland_id);
INSERT INTO cities (country_id, name, description, latitude, longitude)
SELECT @switzerland_id, 'Bern','Switzerland''s charming capital of arcades and medieval towers.', 46.948, 7.4474 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cities WHERE name='Bern' AND country_id=@switzerland_id);
SET @bern_id = (SELECT city_id FROM cities WHERE name='Bern' AND country_id=@switzerland_id);
INSERT INTO cities (country_id, name, description, latitude, longitude)
SELECT @switzerland_id, 'Interlaken','Adventure capital nestled between two lakes and mountain peaks.', 46.6863, 7.8632 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cities WHERE name='Interlaken' AND country_id=@switzerland_id);
SET @interlaken_id = (SELECT city_id FROM cities WHERE name='Interlaken' AND country_id=@switzerland_id);
INSERT INTO cities (country_id, name, description, latitude, longitude)
SELECT @switzerland_id, 'Zermatt','Car-free Alpine village beneath the iconic Matterhorn.', 46.0207, 7.7491 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cities WHERE name='Zermatt' AND country_id=@switzerland_id);
SET @zermatt_id = (SELECT city_id FROM cities WHERE name='Zermatt' AND country_id=@switzerland_id);
INSERT INTO cities (country_id, name, description, latitude, longitude)
SELECT @switzerland_id, 'Lauterbrunnen','Valley of waterfalls and gateway to the Jungfrau region.', 46.5933, 7.9087 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cities WHERE name='Lauterbrunnen' AND country_id=@switzerland_id);
SET @lauterbrunnen_id = (SELECT city_id FROM cities WHERE name='Lauterbrunnen' AND country_id=@switzerland_id);
INSERT INTO cities (country_id, name, description, latitude, longitude)
SELECT @switzerland_id, 'St. Moritz','Glamorous Alpine resort town in the Engadin valley.', 46.4908, 9.8355 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cities WHERE name='St. Moritz' AND country_id=@switzerland_id);
SET @stmoritz_id = (SELECT city_id FROM cities WHERE name='St. Moritz' AND country_id=@switzerland_id);
INSERT INTO cities (country_id, name, description, latitude, longitude)
SELECT @switzerland_id, 'Basel','Cultural city on the Rhine, famed for art museums and old town.', 47.5596, 7.5886 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cities WHERE name='Basel' AND country_id=@switzerland_id);
SET @basel_id = (SELECT city_id FROM cities WHERE name='Basel' AND country_id=@switzerland_id);
INSERT INTO cities (country_id, name, description, latitude, longitude)
SELECT @switzerland_id, 'Montreux','Lakeside resort town famed for its jazz festival and castle.', 46.4312, 6.9107 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM cities WHERE name='Montreux' AND country_id=@switzerland_id);
SET @montreux_id = (SELECT city_id FROM cities WHERE name='Montreux' AND country_id=@switzerland_id);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @berlin_id, 1, 'Brandenburg Gate','Berlinâ€™s most recognizable landmark and a powerful symbol of German reunification.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@berlin_id AND name='Brandenburg Gate');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @berlin_id, 1, 'Reichstag Building','Historic parliament building topped by Norman Fosterâ€™s famous glass dome.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@berlin_id AND name='Reichstag Building');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @berlin_id, 1, 'Berlin Cathedral','Monumental Baroque-style cathedral overlooking Museum Island.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@berlin_id AND name='Berlin Cathedral');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @berlin_id, 1, 'Berlin Wall Memorial','Preserved section of the former Berlin Wall with an open-air exhibition about the cityâ€™s division.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@berlin_id AND name='Berlin Wall Memorial');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @berlin_id, 1, 'Checkpoint Charlie','Former Cold War crossing point between East and West Berlin.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@berlin_id AND name='Checkpoint Charlie');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @berlin_id, 1, 'Charlottenburg Palace','Magnificent Baroque palace and gardens built for the Prussian royal family.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@berlin_id AND name='Charlottenburg Palace');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @berlin_id, 2, 'Museum Island','UNESCO-listed museum complex containing five major museums.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@berlin_id AND name='Museum Island');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @berlin_id, 2, 'Pergamon Museum','Famous archaeological museum; currently closed for renovation, so check its reopening status before planning around it.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@berlin_id AND name='Pergamon Museum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @berlin_id, 2, 'Alte Nationalgalerie','Beautiful collection of 19th-century European art.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@berlin_id AND name='Alte Nationalgalerie');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @berlin_id, 2, 'Neues Museum','Famous for Egyptian collections, including the bust of Nefertiti.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@berlin_id AND name='Neues Museum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @berlin_id, 2, 'East Side Gallery','Long preserved section of the Berlin Wall covered in murals by international artists.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@berlin_id AND name='East Side Gallery');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @berlin_id, 2, 'Hamburger Bahnhof','Major contemporary art museum housed in a former railway station.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@berlin_id AND name='Hamburger Bahnhof');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @berlin_id, 4, 'Hackesche HÃ¶fe','Beautiful interconnected courtyards filled with boutiques, cafÃ©s, and Art Nouveau architecture.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@berlin_id AND name='Hackesche HÃ¶fe');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @berlin_id, 4, 'ClÃ¤rchens Ballhaus','Historic ballroom dating from 1913, famous for its old-world atmosphere.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@berlin_id AND name='ClÃ¤rchens Ballhaus');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @berlin_id, 4, 'Pfaueninsel','Peaceful island on the River Havel with a whimsical little palace and free-roaming peacocks.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@berlin_id AND name='Pfaueninsel');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @berlin_id, 4, 'Teufelsberg','Abandoned Cold War listening station covered in street art, with panoramic views.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@berlin_id AND name='Teufelsberg');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @berlin_id, 4, 'Nikolaiviertel','Reconstructed historic quarter around Berlinâ€™s oldest church, offering a very different side of the city.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@berlin_id AND name='Nikolaiviertel');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @munich_id, 1, 'Marienplatz','The historic heart of Munich, dominated by the magnificent Neues Rathaus.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@munich_id AND name='Marienplatz');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @munich_id, 1, 'Neues Rathaus','Elaborate Neo-Gothic town hall famous for its Glockenspiel.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@munich_id AND name='Neues Rathaus');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @munich_id, 1, 'Munich Residenz','Former royal palace of the Bavarian rulers, filled with lavish rooms and treasures.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@munich_id AND name='Munich Residenz');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @munich_id, 1, 'Nymphenburg Palace','Magnificent Baroque palace and former summer residence of the Bavarian electors and kings.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@munich_id AND name='Nymphenburg Palace');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @munich_id, 1, 'Frauenkirche','Munichâ€™s iconic twin-towered cathedral.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@munich_id AND name='Frauenkirche');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @munich_id, 1, 'Asam Church','Tiny but extraordinarily ornate late-Baroque/Rococo church created by the Asam brothers.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@munich_id AND name='Asam Church');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @munich_id, 2, 'Alte Pinakothek','One of Europeâ€™s most important collections of Old Master paintings.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@munich_id AND name='Alte Pinakothek');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @munich_id, 2, 'Neue Pinakothek','Traditionally dedicated to 19th-century art; currently closed for renovation, with selected works displayed elsewhere.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@munich_id AND name='Neue Pinakothek');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @munich_id, 2, 'Pinakothek der Moderne','Major museum covering modern art, architecture, design, and graphic arts.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@munich_id AND name='Pinakothek der Moderne');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @munich_id, 2, 'Lenbachhaus','Particularly famous for its collection of works by the Blue Rider group.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@munich_id AND name='Lenbachhaus');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @munich_id, 2, 'Deutsches Museum','One of the world''s largest museums of science and technology.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@munich_id AND name='Deutsches Museum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @munich_id, 2, 'BMW Museum','Museum exploring the history and design of BMW.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@munich_id AND name='BMW Museum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @munich_id, 4, 'Hofgarten','Elegant Renaissance-style garden beside the Residenz.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@munich_id AND name='Hofgarten');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @munich_id, 4, 'Michaelskirche','Monumental Renaissance church with an impressive interior and royal tombs.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@munich_id AND name='Michaelskirche');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @munich_id, 4, 'Alter SÃ¼dfriedhof','Atmospheric historic cemetery filled with old monuments and sculptures.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@munich_id AND name='Alter SÃ¼dfriedhof');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @munich_id, 4, 'Lehel','Elegant historic neighborhood with quiet streets and beautiful architecture.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@munich_id AND name='Lehel');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @munich_id, 4, 'Westpark','Large landscaped park with Asian gardens and peaceful walking paths.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@munich_id AND name='Westpark');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @hamburg_id, 1, 'Speicherstadt','UNESCO-listed warehouse district of magnificent red-brick Gothic Revival buildings and canals.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@hamburg_id AND name='Speicherstadt');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @hamburg_id, 1, 'Hamburg Rathaus','Monumental Neo-Renaissance city hall with an ornate interior.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@hamburg_id AND name='Hamburg Rathaus');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @hamburg_id, 1, 'St Michael''s Church','Hamburgâ€™s iconic Baroque church, known as the Michel.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@hamburg_id AND name='St Michael''s Church');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @hamburg_id, 1, 'St Nikolai Memorial','Atmospheric WWII memorial preserved from the former church.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@hamburg_id AND name='St Nikolai Memorial');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @hamburg_id, 1, 'Chile House','Striking 1920s expressionist office building famous for its ship-like shape.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@hamburg_id AND name='Chile House');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @hamburg_id, 1, 'Hamburg Harbour','Historic working harbor that shaped Hamburgâ€™s identity and wealth.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@hamburg_id AND name='Hamburg Harbour');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @hamburg_id, 2, 'Hamburger Kunsthalle','One of Germanyâ€™s most important art museums, spanning medieval art to modern works.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@hamburg_id AND name='Hamburger Kunsthalle');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @hamburg_id, 2, 'Deichtorhallen Hamburg','Major exhibition space for contemporary art and photography.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@hamburg_id AND name='Deichtorhallen Hamburg');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @hamburg_id, 2, 'International Maritime Museum Hamburg','Huge collection exploring thousands of years of maritime history.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@hamburg_id AND name='International Maritime Museum Hamburg');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @hamburg_id, 2, 'Elbphilharmonie','Spectacular modern concert hall and one of the cityâ€™s architectural icons.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@hamburg_id AND name='Elbphilharmonie');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @hamburg_id, 2, 'Miniatur Wunderland','Enormous model railway and miniature world, one of Hamburgâ€™s most popular attractions.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@hamburg_id AND name='Miniatur Wunderland');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @hamburg_id, 4, 'Treppenviertel','Picturesque hillside neighborhood overlooking the Elbe, filled with narrow stairways and charming houses.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@hamburg_id AND name='Treppenviertel');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @hamburg_id, 4, 'Alsterarkaden','Elegant Venetian-inspired arcades beside the Alster.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@hamburg_id AND name='Alsterarkaden');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @hamburg_id, 4, 'Kontorhausviertel','Historic business district surrounding the Chile House, with beautiful 1920s architecture.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@hamburg_id AND name='Kontorhausviertel');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @hamburg_id, 4, 'Planten un Blomen','Beautiful botanical gardens and park in the heart of the city.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@hamburg_id AND name='Planten un Blomen');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @hamburg_id, 4, 'Ã–velgÃ¶nne','Former fishing village on the Elbe with a small beach and historic houses.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@hamburg_id AND name='Ã–velgÃ¶nne');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @cologne_id, 1, 'Cologne Cathedral','Cologneâ€™s spectacular Gothic cathedral and one of Europeâ€™s most famous landmarks. Climb the tower for views over the Rhine and historic center.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@cologne_id AND name='Cologne Cathedral');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @cologne_id, 1, 'Roman-Germanic Museum','Museum exploring Cologneâ€™s Roman origins and archaeological heritage.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@cologne_id AND name='Roman-Germanic Museum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @cologne_id, 1, 'Great St Martin Church','Striking Romanesque church overlooking the Rhine.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@cologne_id AND name='Great St Martin Church');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @cologne_id, 1, 'Historic Town Hall','One of Germanyâ€™s oldest city halls, with a beautifully decorated Renaissance-style faÃ§ade.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@cologne_id AND name='Historic Town Hall');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @cologne_id, 1, 'Hohenzollern Bridge','Famous railway bridge across the Rhine with spectacular cathedral views.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@cologne_id AND name='Hohenzollern Bridge');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @cologne_id, 2, 'Museum Ludwig','Excellent collection of modern and contemporary art, including works by Pablo Picasso.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@cologne_id AND name='Museum Ludwig');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @cologne_id, 2, 'Wallraf-Richartz Museum','One of Germanyâ€™s oldest museums, with European art from the medieval period through the 19th century.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@cologne_id AND name='Wallraf-Richartz Museum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @cologne_id, 2, 'Museum SchnÃ¼tgen','Fascinating collection of medieval Christian art housed in a historic Romanesque church.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@cologne_id AND name='Museum SchnÃ¼tgen');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @cologne_id, 2, 'Museum of Applied Arts Cologne','Design and decorative arts from the Middle Ages to contemporary works.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@cologne_id AND name='Museum of Applied Arts Cologne');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @cologne_id, 2, 'Museum of East Asian Art','Important collection of Japanese, Chinese, and Korean art.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@cologne_id AND name='Museum of East Asian Art');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @cologne_id, 4, 'Flora and Botanical Garden Cologne','Beautiful historic botanical garden with exotic plants and elegant glasshouses.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@cologne_id AND name='Flora and Botanical Garden Cologne');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @cologne_id, 4, 'EL-DE Haus','Former Gestapo headquarters, now a museum documenting Nazi persecution in Cologne.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@cologne_id AND name='EL-DE Haus');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @cologne_id, 4, 'St Gereon''s Basilica','Unusual Romanesque church incorporating an ancient Roman structure.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@cologne_id AND name='St Gereon''s Basilica');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @cologne_id, 4, 'Belgian Quarter','Stylish neighborhood filled with independent boutiques, cafÃ©s, galleries, and street art.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@cologne_id AND name='Belgian Quarter');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @cologne_id, 4, 'Melaten Cemetery','Atmospheric historic cemetery filled with elaborate monuments and sculptures.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@cologne_id AND name='Melaten Cemetery');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @dresden_id, 1, 'Zwinger','Magnificent Baroque palace complex with ornate pavilions, courtyards, and gardens.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@dresden_id AND name='Zwinger');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @dresden_id, 1, 'Frauenkirche Dresden','Iconic Baroque church rebuilt after its destruction during WWII.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@dresden_id AND name='Frauenkirche Dresden');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @dresden_id, 1, 'Semperoper','Grand 19th-century opera house and one of Dresdenâ€™s architectural symbols.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@dresden_id AND name='Semperoper');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @dresden_id, 1, 'Dresden Castle','Former residence of the Saxon electors and kings, now home to several museums.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@dresden_id AND name='Dresden Castle');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @dresden_id, 1, 'BrÃ¼hl''s Terrace','Elegant riverside promenade overlooking the Elbe, nicknamed the â€œBalcony of Europe.â€', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@dresden_id AND name='BrÃ¼hl''s Terrace');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @dresden_id, 1, 'FÃ¼rstenzug','Huge porcelain mural depicting the rulers of Saxony.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@dresden_id AND name='FÃ¼rstenzug');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @dresden_id, 2, 'GemÃ¤ldegalerie Alte Meister','Outstanding collection of European Old Masters, including works by Raphael, Titian, and Rembrandt.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@dresden_id AND name='GemÃ¤ldegalerie Alte Meister');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @dresden_id, 2, 'Green Vault','One of Europe''s most spectacular historic treasure collections.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@dresden_id AND name='Green Vault');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @dresden_id, 2, 'Albertinum','Museum of 19th- and 20th-century art, including works from the Romantic and modern periods.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@dresden_id AND name='Albertinum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @dresden_id, 2, 'Porzellansammlung','Extraordinary collection of Meissen and other porcelain.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@dresden_id AND name='Porzellansammlung');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @dresden_id, 2, 'Kunsthofpassage','Creative collection of courtyards featuring colorful faÃ§ades, independent shops, and cafÃ©s.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@dresden_id AND name='Kunsthofpassage');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @dresden_id, 4, 'Pillnitz Palace and Park','Beautiful riverside palace complex surrounded by landscaped gardens.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@dresden_id AND name='Pillnitz Palace and Park');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @dresden_id, 4, 'Neustadt Dresden','Creative district filled with street art, independent boutiques, cafÃ©s, and unusual architecture.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@dresden_id AND name='Neustadt Dresden');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @dresden_id, 4, 'Pfunds Molkerei','Historic dairy shop famous for its incredibly elaborate hand-painted tiled interior.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@dresden_id AND name='Pfunds Molkerei');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @dresden_id, 4, 'Grosser Garten','Vast Baroque park perfect for escaping the busy historic center.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@dresden_id AND name='Grosser Garten');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @dresden_id, 4, 'Loschwitz Bridge','Historic blue bridge with beautiful views of the Elbe valley.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@dresden_id AND name='Loschwitz Bridge');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @heidelberg_id, 1, 'Heidelberg Castle','Dramatic Renaissance castle ruins overlooking the city and Neckar Valley; one of Germanyâ€™s most iconic landmarks.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@heidelberg_id AND name='Heidelberg Castle');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @heidelberg_id, 1, 'Altstadt Heidelberg','Beautiful historic center filled with Baroque buildings, narrow streets, and traditional squares.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@heidelberg_id AND name='Altstadt Heidelberg');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @heidelberg_id, 1, 'Old Bridge Heidelberg','Historic stone bridge across the Neckar, with excellent views toward the castle.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@heidelberg_id AND name='Old Bridge Heidelberg');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @heidelberg_id, 1, 'Church of the Holy Spirit','Landmark Gothic church on the HauptstraÃŸe.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@heidelberg_id AND name='Church of the Holy Spirit');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @heidelberg_id, 1, 'Heidelberg University','Founded in 1386, it is Germanyâ€™s oldest university.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@heidelberg_id AND name='Heidelberg University');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @heidelberg_id, 1, 'Student Prison Heidelberg','Fascinating former university jail whose walls are covered with student graffiti.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@heidelberg_id AND name='Student Prison Heidelberg');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @heidelberg_id, 2, 'KurpfÃ¤lzisches Museum','Art and historical collections covering the region from prehistory to modern times.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@heidelberg_id AND name='KurpfÃ¤lzisches Museum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @heidelberg_id, 2, 'Philosophers'' Walk','Historic hillside path associated with Heidelbergâ€™s intellectual and literary tradition, with beautiful views of the Old Town.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@heidelberg_id AND name='Philosophers'' Walk');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @heidelberg_id, 2, 'German Pharmacy Museum','Unique museum tracing the history of pharmacy through centuries of European culture.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@heidelberg_id AND name='German Pharmacy Museum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @heidelberg_id, 4, 'Philosophers'' Walk','Go early or around sunset for peaceful views over the city and castle.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@heidelberg_id AND name='Philosophers'' Walk');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @heidelberg_id, 4, 'Heiligenberg','Forested hill above the Neckar with ancient ruins, viewpoints, and walking paths.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@heidelberg_id AND name='Heiligenberg');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @heidelberg_id, 4, 'ThingstÃ¤tte','Atmospheric open-air amphitheater hidden in the forest on Heiligenberg.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@heidelberg_id AND name='ThingstÃ¤tte');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @heidelberg_id, 4, 'Kornmarkt','Small historic square beneath the castle with one of the city''s best castle views.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@heidelberg_id AND name='Kornmarkt');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @heidelberg_id, 4, 'Hortus Palatinus','Historic palace gardens associated with Heidelberg Castle and Renaissance garden design.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@heidelberg_id AND name='Hortus Palatinus');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @nuremberg_id, 1, 'Nuremberg Castle','Impressive medieval imperial castle overlooking the Old Town and once an important residence of the Holy Roman Emperors.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@nuremberg_id AND name='Nuremberg Castle');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @nuremberg_id, 1, 'Old Town Nuremberg','Historic center surrounded by medieval walls and filled with reconstructed Gothic and Renaissance buildings.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@nuremberg_id AND name='Old Town Nuremberg');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @nuremberg_id, 1, 'St Sebaldus Church','Magnificent medieval church named after the city''s patron saint.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@nuremberg_id AND name='St Sebaldus Church');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @nuremberg_id, 1, 'St Lorenz Church','One of Nuremberg''s great Gothic landmarks, with an impressive interior.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@nuremberg_id AND name='St Lorenz Church');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @nuremberg_id, 1, 'SchÃ¶ner Brunnen','Ornate 14th-century fountain on the Hauptmarkt.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@nuremberg_id AND name='SchÃ¶ner Brunnen');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @nuremberg_id, 1, 'Heilig-Geist-Spital','Historic medieval hospital complex extending over the Pegnitz River.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@nuremberg_id AND name='Heilig-Geist-Spital');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @nuremberg_id, 2, 'Germanisches Nationalmuseum','Germany''s largest museum of cultural history, with art and objects spanning prehistoric times to the present.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@nuremberg_id AND name='Germanisches Nationalmuseum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @nuremberg_id, 2, 'Albrecht DÃ¼rer''s House','Former home of Renaissance master Albrecht DÃ¼rer.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@nuremberg_id AND name='Albrecht DÃ¼rer''s House');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @nuremberg_id, 2, 'New Museum Nuremberg','Modern and contemporary art and design in a striking glass building.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@nuremberg_id AND name='New Museum Nuremberg');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @nuremberg_id, 2, 'Kunsthalle NÃ¼rnberg','Contemporary art exhibitions in the historic city center.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@nuremberg_id AND name='Kunsthalle NÃ¼rnberg');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @nuremberg_id, 2, 'DB Museum','Fascinating museum dedicated to the history of German railways.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@nuremberg_id AND name='DB Museum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @nuremberg_id, 4, 'Nuremberg City Walls','Walk along sections of the remarkably preserved medieval fortifications.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@nuremberg_id AND name='Nuremberg City Walls');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @nuremberg_id, 4, 'WeiÃŸgerbergasse','One of the prettiest streets in the Old Town, lined with colorful historic half-timbered houses.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@nuremberg_id AND name='WeiÃŸgerbergasse');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @nuremberg_id, 4, 'Nuremberg Rock-Cut Cellars','Underground medieval tunnels and cellars beneath the Old Town.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@nuremberg_id AND name='Nuremberg Rock-Cut Cellars');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @nuremberg_id, 4, 'Handwerkerhof Nuremberg','Small reconstructed medieval-style crafts quarter beside the main railway station.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@nuremberg_id AND name='Handwerkerhof Nuremberg');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @nuremberg_id, 4, 'TiergÃ¤rtnertorplatz','Atmospheric square beneath the castle, surrounded by historic buildings and cafÃ©s.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@nuremberg_id AND name='TiergÃ¤rtnertorplatz');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @rothenburgobdertauber_id, 1, 'Rothenburg Town Hall','Magnificent Gothic and Renaissance town hall overlooking the Marktplatz.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@rothenburgobdertauber_id AND name='Rothenburg Town Hall');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @rothenburgobdertauber_id, 1, 'Rothenburg Town Walls','Almost completely preserved medieval fortifications that you can walk along for views over the town and surrounding countryside.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@rothenburgobdertauber_id AND name='Rothenburg Town Walls');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @rothenburgobdertauber_id, 1, 'St James'' Church','Gothic church famous for the extraordinary Holy Blood Altarpiece carved by Tilman Riemenschneider.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@rothenburgobdertauber_id AND name='St James'' Church');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @rothenburgobdertauber_id, 1, 'PlÃ¶nlein','The town''s iconic forked medieval street, framed by a yellow half-timbered house and two towers.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@rothenburgobdertauber_id AND name='PlÃ¶nlein');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @rothenburgobdertauber_id, 1, 'Burgtor','Impressive medieval gateway marking the western entrance to the Old Town.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@rothenburgobdertauber_id AND name='Burgtor');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @rothenburgobdertauber_id, 1, 'Medieval Crime Museum','Museum exploring medieval law, punishment, and justice in Europe.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@rothenburgobdertauber_id AND name='Medieval Crime Museum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @rothenburgobdertauber_id, 2, 'Rothenburg Museum','Museum covering the town''s history, medieval life, and art.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@rothenburgobdertauber_id AND name='Rothenburg Museum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @rothenburgobdertauber_id, 2, 'St James'' Church','Particularly important for its masterpiece by Tilman Riemenschneider.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@rothenburgobdertauber_id AND name='St James'' Church');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @rothenburgobdertauber_id, 2, 'Christmas Museum','Museum exploring German Christmas traditions and decorations throughout the year.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@rothenburgobdertauber_id AND name='Christmas Museum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @rothenburgobdertauber_id, 2, 'Wander through the Old Town to see traditional Franconian half-timbered architecture','the town itself is arguably the main cultural attraction.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@rothenburgobdertauber_id AND name='Wander through the Old Town to see traditional Franconian half-timbered architecture');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @rothenburgobdertauber_id, 4, 'Burggarten','Peaceful castle garden with beautiful views across the Tauber Valley.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@rothenburgobdertauber_id AND name='Burggarten');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @rothenburgobdertauber_id, 4, 'Klingentor','Historic fortified gate and tower offering a quieter part of the town walls.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@rothenburgobdertauber_id AND name='Klingentor');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @rothenburgobdertauber_id, 4, 'Kobolzeller Tor','Dramatic medieval gate leading toward the Tauber Valley.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@rothenburgobdertauber_id AND name='Kobolzeller Tor');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @rothenburgobdertauber_id, 4, 'Tauber Valley','Scenic countryside beneath the town, especially beautiful from the Burggarten viewpoints.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@rothenburgobdertauber_id AND name='Tauber Valley');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @frankfurt_id, 1, 'RÃ¶mer','Frankfurtâ€™s iconic medieval town hall complex overlooking the RÃ¶merberg.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@frankfurt_id AND name='RÃ¶mer');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @frankfurt_id, 1, 'RÃ¶merberg','Historic central square surrounded by reconstructed traditional buildings.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@frankfurt_id AND name='RÃ¶merberg');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @frankfurt_id, 1, 'Frankfurt Cathedral','Impressive Gothic cathedral where several Holy Roman Emperors were crowned.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@frankfurt_id AND name='Frankfurt Cathedral');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @frankfurt_id, 1, 'St Paul''s Church Frankfurt','Symbolically important site of German democracy and the meeting place of the 1848 Frankfurt Parliament.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@frankfurt_id AND name='St Paul''s Church Frankfurt');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @frankfurt_id, 1, 'Neue Altstadt','Reconstructed historic quarter connecting RÃ¶merberg with the cathedral.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@frankfurt_id AND name='Neue Altstadt');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @frankfurt_id, 1, 'Goethe House','Birthplace of Johann Wolfgang von Goethe.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@frankfurt_id AND name='Goethe House');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @frankfurt_id, 2, 'StÃ¤del Museum','One of Germanyâ€™s finest art museums, covering more than 700 years of European art.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@frankfurt_id AND name='StÃ¤del Museum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @frankfurt_id, 2, 'Liebieghaus','Exceptional collection of European sculpture from antiquity through the 19th century.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@frankfurt_id AND name='Liebieghaus');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @frankfurt_id, 2, 'Museum Angewandte Kunst','Museum dedicated to design, decorative arts, and visual culture.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@frankfurt_id AND name='Museum Angewandte Kunst');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @frankfurt_id, 2, 'German Film Institute &amp; Film Museum','Explores the history and development of cinema.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@frankfurt_id AND name='German Film Institute &amp; Film Museum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @frankfurt_id, 2, 'Museumsufer','Museum district along the Main River containing numerous museums within walking distance of one another.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@frankfurt_id AND name='Museumsufer');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @frankfurt_id, 4, 'Kleinmarkthalle','Covered market filled with food stalls and local specialties.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@frankfurt_id AND name='Kleinmarkthalle');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @frankfurt_id, 4, 'Old Sachsenhausen','Historic neighborhood south of the Main with narrow streets and traditional pubs.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@frankfurt_id AND name='Old Sachsenhausen');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @frankfurt_id, 4, 'Eschenheimer Turm','Beautiful surviving medieval city gate tower surrounded by modern Frankfurt.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@frankfurt_id AND name='Eschenheimer Turm');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @frankfurt_id, 4, 'Palmengarten','Elegant botanical garden with tropical plants and landscaped grounds.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@frankfurt_id AND name='Palmengarten');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @frankfurt_id, 4, 'Hauptfriedhof Frankfurt','Historic cemetery with elaborate monuments and sculptures.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@frankfurt_id AND name='Hauptfriedhof Frankfurt');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @frankfurt_id, 4, 'Eiserner Steg','Pedestrian bridge across the Main offering one of the best skyline views.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@frankfurt_id AND name='Eiserner Steg');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @freiburg_id, 1, 'Freiburg Minster','Magnificent Gothic cathedral and the city''s most recognizable landmark, famous for its intricate tower.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@freiburg_id AND name='Freiburg Minster');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @freiburg_id, 1, 'MÃ¼nsterplatz','Historic square surrounding the cathedral, lined with colorful medieval and Baroque buildings.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@freiburg_id AND name='MÃ¼nsterplatz');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @freiburg_id, 1, 'Augustiner Museum','Historic former monastery housing an important collection of medieval and Baroque art.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@freiburg_id AND name='Augustiner Museum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @freiburg_id, 1, 'Schwabentor','One of Freiburg''s two remaining medieval city gates.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@freiburg_id AND name='Schwabentor');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @freiburg_id, 1, 'Martinstor','Another beautifully preserved medieval gate and symbol of the Old Town.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@freiburg_id AND name='Martinstor');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @freiburg_id, 1, 'Freiburg Old Town','Compact historic center filled with narrow streets, historic houses, and the famous BÃ¤chle water channels.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@freiburg_id AND name='Freiburg Old Town');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @freiburg_id, 2, 'Augustinermuseum','Excellent collection of medieval, Renaissance, and Baroque art from the Upper Rhine region.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@freiburg_id AND name='Augustinermuseum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @freiburg_id, 2, 'Museum Natur und Mensch','Museum combining natural history with ethnographic collections.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@freiburg_id AND name='Museum Natur und Mensch');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @freiburg_id, 2, 'University of Freiburg','Historic university founded in 1457, contributing to the city''s intellectual and cultural atmosphere.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@freiburg_id AND name='University of Freiburg');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @freiburg_id, 4, 'Freiburg BÃ¤chle','Tiny open water channels running through the Old Town streets, a distinctive medieval feature of Freiburg.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@freiburg_id AND name='Freiburg BÃ¤chle');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @freiburg_id, 4, 'KonviktstraÃŸe','One of the prettiest streets in the city, with colorful faÃ§ades and climbing flowers.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@freiburg_id AND name='KonviktstraÃŸe');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @freiburg_id, 4, 'Schlossberg','Forested hill directly above the Old Town with walking paths and panoramic views.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@freiburg_id AND name='Schlossberg');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @freiburg_id, 4, 'Kanonenplatz','Scenic viewpoint on Schlossberg overlooking the historic center.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@freiburg_id AND name='Kanonenplatz');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @freiburg_id, 4, 'Seepark','Peaceful lakeside park with gardens and walking paths.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@freiburg_id AND name='Seepark');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zurich_id, 1, 'GrossmÃ¼nster','Zurichâ€™s iconic twin-towered Romanesque church and one of the city''s most important landmarks.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zurich_id AND name='GrossmÃ¼nster');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zurich_id, 1, 'FraumÃ¼nster','Historic church famous for its stunning stained-glass windows designed by Marc Chagall.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zurich_id AND name='FraumÃ¼nster');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zurich_id, 1, 'St Peter''s Church','Historic church with one of the largest clock faces in Europe.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zurich_id AND name='St Peter''s Church');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zurich_id, 1, 'Old Town Zurich','Atmospheric medieval streets filled with guild houses, churches, cafÃ©s, and historic buildings.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zurich_id AND name='Old Town Zurich');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zurich_id, 1, 'Lindenhof','Historic hill and peaceful square offering views over the Old Town and the Limmat River.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zurich_id AND name='Lindenhof');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zurich_id, 1, 'Bahnhofstrasse','One of Europeâ€™s most famous shopping streets, running from the main station toward Lake Zurich.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zurich_id AND name='Bahnhofstrasse');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zurich_id, 2, 'Kunsthaus ZÃ¼rich','Switzerlandâ€™s largest art museum, with works ranging from the Middle Ages to modern and contemporary art.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zurich_id AND name='Kunsthaus ZÃ¼rich');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zurich_id, 2, 'Swiss National Museum','Excellent museum exploring Swiss cultural history, art, and traditions.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zurich_id AND name='Swiss National Museum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zurich_id, 2, 'Museum Rietberg','Major museum dedicated to non-European art, housed in a beautiful villa and park.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zurich_id AND name='Museum Rietberg');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zurich_id, 2, 'Pavillon Le Corbusier','Striking modernist pavilion designed by Le Corbusier.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zurich_id AND name='Pavillon Le Corbusier');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zurich_id, 2, 'ETH ZÃ¼rich','Historic university associated with Albert Einstein and offering spectacular views over the city.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zurich_id AND name='ETH ZÃ¼rich');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zurich_id, 4, 'Augustinergasse','One of the prettiest streets in the Old Town, lined with colorful historic houses.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zurich_id AND name='Augustinergasse');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zurich_id, 4, 'Schanzengraben','Quiet canal and walking path that follows part of the former city defenses.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zurich_id AND name='Schanzengraben');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zurich_id, 4, 'Rieterpark','Elegant park with views toward Lake Zurich and the Alps.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zurich_id AND name='Rieterpark');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zurich_id, 4, 'Felsenegg','Scenic viewpoint reached by cable car, offering panoramic views over Zurich and the lake.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zurich_id AND name='Felsenegg');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zurich_id, 4, 'Zurich West','Former industrial district transformed into a creative neighborhood with galleries, restaurants, and design spaces.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zurich_id AND name='Zurich West');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @geneva_id, 1, 'St Pierre Cathedral','Historic cathedral at the heart of the Old Town, closely connected to the Protestant Reformation and John Calvin.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@geneva_id AND name='St Pierre Cathedral');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @geneva_id, 1, 'Geneva Old Town','The city''s historic center, filled with narrow streets, hidden squares, cafÃ©s, and centuries-old buildings.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@geneva_id AND name='Geneva Old Town');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @geneva_id, 1, 'Maison Tavel','Geneva''s oldest private house, now a museum exploring the city''s history.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@geneva_id AND name='Maison Tavel');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @geneva_id, 1, 'Place du Bourg-de-Four','The oldest square in Geneva, surrounded by historic buildings and cafÃ©s.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@geneva_id AND name='Place du Bourg-de-Four');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @geneva_id, 1, 'Reformation Wall','Monumental memorial dedicated to the leaders and history of the Protestant Reformation.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@geneva_id AND name='Reformation Wall');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @geneva_id, 1, 'Parc des Bastions','Historic park containing the Reformation Wall and giant outdoor chess boards.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@geneva_id AND name='Parc des Bastions');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @geneva_id, 2, 'MusÃ©e d''Art et d''Histoire','Geneva''s largest art and history museum, with collections ranging from archaeology to fine art.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@geneva_id AND name='MusÃ©e d''Art et d''Histoire');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @geneva_id, 2, 'Patek Philippe Museum','Fascinating museum exploring the history of Swiss watchmaking and decorative arts.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@geneva_id AND name='Patek Philippe Museum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @geneva_id, 2, 'MAMCO','Museum of Modern and Contemporary Art.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@geneva_id AND name='MAMCO');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @geneva_id, 2, 'Fondation Martin Bodmer','Extraordinary library and museum containing rare manuscripts, books, and historical documents.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@geneva_id AND name='Fondation Martin Bodmer');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @geneva_id, 2, 'CERN Science Gateway','Modern science center exploring particle physics and the work of CERN.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@geneva_id AND name='CERN Science Gateway');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @geneva_id, 4, 'Carouge','Charming Mediterranean-feeling district with artisan workshops, colorful streets, and cafÃ©s.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@geneva_id AND name='Carouge');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @geneva_id, 4, 'Parc de La Grange','Beautiful lakeside park with rose gardens and views across Lake Geneva.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@geneva_id AND name='Parc de La Grange');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @geneva_id, 4, 'Bains des PÃ¢quis','Popular local swimming and social spot on the lake, with beautiful views of the city.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@geneva_id AND name='Bains des PÃ¢quis');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @geneva_id, 4, 'ÃŽle Rousseau','Small island in the RhÃ´ne River dedicated to philosopher Jean-Jacques Rousseau.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@geneva_id AND name='ÃŽle Rousseau');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @geneva_id, 4, 'Quai des Bergues','Elegant lakeside promenade with views toward the Jet d''Eau and Mont Blanc.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@geneva_id AND name='Quai des Bergues');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @lucerne_id, 1, 'Chapel Bridge','Lucerneâ€™s most famous landmark and one of Europeâ€™s oldest covered wooden bridges, decorated with historic paintings.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@lucerne_id AND name='Chapel Bridge');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @lucerne_id, 1, 'Water Tower Lucerne','Historic octagonal tower beside the Chapel Bridge, once used as a prison, treasury, and archive.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@lucerne_id AND name='Water Tower Lucerne');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @lucerne_id, 1, 'Old Town Lucerne','Beautiful medieval streets filled with colorful painted faÃ§ades, fountains, and historic guild houses.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@lucerne_id AND name='Old Town Lucerne');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @lucerne_id, 1, 'Musegg Wall','Remarkably preserved medieval city wall with several towers open to visitors.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@lucerne_id AND name='Musegg Wall');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @lucerne_id, 1, 'Hofkirche St Leodegar','Important Renaissance church with distinctive twin towers.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@lucerne_id AND name='Hofkirche St Leodegar');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @lucerne_id, 1, 'Jesuit Church Lucerne','One of Switzerlandâ€™s finest examples of early Baroque architecture.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@lucerne_id AND name='Jesuit Church Lucerne');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @lucerne_id, 2, 'Rosengart Collection','Excellent collection of modern art, particularly works by Pablo Picasso and Paul Klee.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@lucerne_id AND name='Rosengart Collection');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @lucerne_id, 2, 'Richard Wagner Museum','Former residence of the composer, located beside Lake Lucerne.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@lucerne_id AND name='Richard Wagner Museum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @lucerne_id, 2, 'KKL Luzern','Striking modern cultural and concert center designed by Jean Nouvel.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@lucerne_id AND name='KKL Luzern');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @lucerne_id, 2, 'Swiss Museum of Transport','Large interactive museum dedicated to Switzerland''s transport history.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@lucerne_id AND name='Swiss Museum of Transport');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @lucerne_id, 4, 'Spreuer Bridge','Beautiful covered wooden bridge decorated with 17th-century paintings depicting the Dance of Death.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@lucerne_id AND name='Spreuer Bridge');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @lucerne_id, 4, 'Hofquartier','Elegant historic neighborhood near the lake with beautiful villas and quieter streets.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@lucerne_id AND name='Hofquartier');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @lucerne_id, 4, 'Glacier Garden Lucerne','Fascinating geological site with glacial potholes dating back thousands of years.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@lucerne_id AND name='Glacier Garden Lucerne');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @lucerne_id, 4, 'Meggenhorn Castle','Picturesque lakeside castle surrounded by gardens, just outside Lucerne.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@lucerne_id AND name='Meggenhorn Castle');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @lucerne_id, 4, 'Reuss River','Walk along the quieter stretches of the river away from Chapel Bridge.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@lucerne_id AND name='Reuss River');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @bern_id, 1, 'Zytglogge','Bernâ€™s famous medieval clock tower, featuring an astronomical clock and mechanical figures.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@bern_id AND name='Zytglogge');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @bern_id, 1, 'Bern Minster','Switzerland''s largest church and an impressive example of late Gothic architecture.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@bern_id AND name='Bern Minster');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @bern_id, 1, 'Old Town of Bern','UNESCO-listed medieval center with beautifully preserved sandstone buildings, fountains, and arcades.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@bern_id AND name='Old Town of Bern');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @bern_id, 1, 'Federal Palace of Switzerland','The seat of the Swiss Federal Assembly and government.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@bern_id AND name='Federal Palace of Switzerland');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @bern_id, 1, 'Kramgasse','One of the Old Town''s most beautiful historic streets, lined with fountains and covered arcades.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@bern_id AND name='Kramgasse');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @bern_id, 1, 'KÃ¤figturm','Historic medieval tower that once formed part of the cityâ€™s defenses.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@bern_id AND name='KÃ¤figturm');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @bern_id, 2, 'Kunstmuseum Bern','Switzerlandâ€™s oldest art museum, with works ranging from the Middle Ages to contemporary art.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@bern_id AND name='Kunstmuseum Bern');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @bern_id, 2, 'Zentrum Paul Klee','Museum dedicated to Swiss artist Paul Klee, housed in a striking building designed by Renzo Piano.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@bern_id AND name='Zentrum Paul Klee');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @bern_id, 2, 'Einstein House','Former apartment of Albert Einstein, where he developed important ideas while living in Bern.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@bern_id AND name='Einstein House');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @bern_id, 2, 'Museum of Communication','Interactive museum exploring the history of communication and technology.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@bern_id AND name='Museum of Communication');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @bern_id, 2, 'Bern Historical Museum','One of Switzerlandâ€™s most important cultural history museums.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@bern_id AND name='Bern Historical Museum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @bern_id, 4, 'Rosengarten Bern','Beautiful rose garden on a hill overlooking the entire Old Town.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@bern_id AND name='Rosengarten Bern');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @bern_id, 4, 'Marzili','Popular riverside district where locals relax beside the Aare.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@bern_id AND name='Marzili');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @bern_id, 4, 'Nydegg Church','Historic church near the lower end of the Old Town.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@bern_id AND name='Nydegg Church');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @bern_id, 4, 'Matte District','Charming riverside neighborhood with narrow streets and a quieter atmosphere.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@bern_id AND name='Matte District');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @bern_id, 4, 'Gurten','Local mountain overlooking Bern, offering panoramic views and green spaces.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@bern_id AND name='Gurten');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @interlaken_id, 1, 'Interlaken Monastery','Historic former Augustinian monastery dating back to the 12th century, located near the center of town.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@interlaken_id AND name='Interlaken Monastery');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @interlaken_id, 1, 'Unterseen','Charming historic town beside Interlaken with traditional Swiss houses and a quieter atmosphere.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@interlaken_id AND name='Unterseen');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @interlaken_id, 1, 'HÃ¶heweg','The main promenade connecting Interlaken West and Interlaken Ost, offering beautiful views toward the Jungfrau.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@interlaken_id AND name='HÃ¶heweg');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @interlaken_id, 1, 'Unspunnen Castle','Medieval castle ruins just outside Interlaken, associated with traditional Swiss festivals.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@interlaken_id AND name='Unspunnen Castle');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @interlaken_id, 2, 'Tourismuseum Interlaken','Museum exploring the history of tourism in the Jungfrau region and the development of Alpine travel.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@interlaken_id AND name='Tourismuseum Interlaken');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @interlaken_id, 2, 'Interlaken Music Festival','Depending on the season, the town hosts classical music festivals and cultural events.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@interlaken_id AND name='Interlaken Music Festival');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @interlaken_id, 4, 'Giessbach Falls','Beautiful waterfall cascading beside the historic Grandhotel Giessbach and into Lake Brienz.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@interlaken_id AND name='Giessbach Falls');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @interlaken_id, 4, 'St Beatus Caves','Atmospheric limestone caves overlooking Lake Thun, with waterfalls and dramatic views.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@interlaken_id AND name='St Beatus Caves');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @interlaken_id, 4, 'Iseltwald','Tiny lakeside village on Lake Brienz with traditional houses and spectacular mountain scenery.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@interlaken_id AND name='Iseltwald');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @interlaken_id, 4, 'Saxeten','Quiet Alpine village hidden in a valley near Interlaken.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@interlaken_id AND name='Saxeten');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @interlaken_id, 4, 'Harder Kulm','Mountain viewpoint directly above Interlaken with panoramic views over both lakes.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@interlaken_id AND name='Harder Kulm');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zermatt_id, 1, 'Matterhorn Museum â€“ Zermatlantis','Museum telling the story of Zermatt, Alpine life, and the dramatic first ascent of the Matterhorn.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zermatt_id AND name='Matterhorn Museum â€“ Zermatlantis');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zermatt_id, 1, 'Hinterdorf','The oldest part of Zermatt, filled with beautifully preserved traditional wooden barns and chalets.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zermatt_id AND name='Hinterdorf');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zermatt_id, 1, 'Mountaineers'' Cemetery','Small, atmospheric cemetery dedicated to climbers who lost their lives in the surrounding mountains.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zermatt_id AND name='Mountaineers'' Cemetery');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zermatt_id, 1, 'St Mauritius Church','Historic church in the center of the village.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zermatt_id AND name='St Mauritius Church');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zermatt_id, 2, 'Matterhorn Museum â€“ Zermatlantis','Best place to understand the cultural history of the village and the development of mountaineering.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zermatt_id AND name='Matterhorn Museum â€“ Zermatlantis');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zermatt_id, 4, 'Hinterdorf','Wander away from the busy main streets into Zermatt''s oldest and most atmospheric quarter.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zermatt_id AND name='Hinterdorf');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zermatt_id, 4, 'Gorner Gorge','Dramatic gorge carved by glacial water, with wooden walkways through the rock formations.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zermatt_id AND name='Gorner Gorge');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zermatt_id, 4, 'Dossen Glacier Garden','Fascinating landscape of glacial formations and polished rock.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zermatt_id AND name='Dossen Glacier Garden');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zermatt_id, 4, 'Leisee','Small mountain lake famous for its reflections of the Matterhorn.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zermatt_id AND name='Leisee');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @zermatt_id, 4, 'Zermatt Forest','Quiet walking paths surrounded by Alpine scenery, away from the busiest viewpoints.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@zermatt_id AND name='Zermatt Forest');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @lauterbrunnen_id, 1, 'Lauterbrunnen Church','Historic village church surrounded by traditional Alpine architecture and mountain scenery.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@lauterbrunnen_id AND name='Lauterbrunnen Church');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @lauterbrunnen_id, 1, 'Lauterbrunnen Village','Traditional Swiss village with wooden chalets and a long history connected to Alpine farming and tourism.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@lauterbrunnen_id AND name='Lauterbrunnen Village');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @lauterbrunnen_id, 1, 'Wengen','Historic car-free mountain village above the Lauterbrunnen Valley.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@lauterbrunnen_id AND name='Wengen');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @lauterbrunnen_id, 1, 'MÃ¼rren','Traditional car-free Alpine village perched high above the valley.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@lauterbrunnen_id AND name='MÃ¼rren');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @lauterbrunnen_id, 2, 'Valley Museum Lauterbrunnen','Small museum exploring the history, traditions, and everyday life of the Lauterbrunnen Valley.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@lauterbrunnen_id AND name='Valley Museum Lauterbrunnen');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @lauterbrunnen_id, 4, 'TrÃ¼mmelbach Falls','Powerful waterfalls hidden inside a mountain, accessible through tunnels and walkways carved into the rock.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@lauterbrunnen_id AND name='TrÃ¼mmelbach Falls');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @lauterbrunnen_id, 4, 'Staubbach Falls','One of Switzerland''s highest free-falling waterfalls and the symbol of the valley.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@lauterbrunnen_id AND name='Staubbach Falls');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @lauterbrunnen_id, 4, 'Isenfluh','Tiny mountain village above Lauterbrunnen with spectacular views and a much quieter atmosphere.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@lauterbrunnen_id AND name='Isenfluh');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @lauterbrunnen_id, 4, 'Gimmelwald','Peaceful traditional mountain village below MÃ¼rren, largely untouched by large-scale tourism.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@lauterbrunnen_id AND name='Gimmelwald');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @lauterbrunnen_id, 4, 'Sefinen Valley','Remote and dramatic Alpine valley ideal for escaping the busiest areas.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@lauterbrunnen_id AND name='Sefinen Valley');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @stmoritz_id, 1, 'St Moritz Dorf','The historic center of St. Moritz, filled with elegant hotels, traditional buildings, boutiques, and mountain views.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@stmoritz_id AND name='St Moritz Dorf');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @stmoritz_id, 1, 'Leaning Tower of St Moritz','The surviving tower of a 12th-century church, noticeably leaning and one of the town''s oldest landmarks.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@stmoritz_id AND name='Leaning Tower of St Moritz');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @stmoritz_id, 1, 'Segantini Museum','Museum dedicated to the Alpine painter Giovanni Segantini, whose work was deeply inspired by the Engadin landscape.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@stmoritz_id AND name='Segantini Museum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @stmoritz_id, 1, 'Engadin Valley','Historic Alpine region with traditional villages and distinctive architecture.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@stmoritz_id AND name='Engadin Valley');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @stmoritz_id, 1, 'Chesa Futura','Striking contemporary building designed by architect Norman Foster, contrasting with traditional Engadin architecture.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@stmoritz_id AND name='Chesa Futura');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @stmoritz_id, 1, 'Segantini Museum','The city''s most important art museum, dedicated to one of the great painters of the Alpine landscape.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@stmoritz_id AND name='Segantini Museum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @stmoritz_id, 1, 'Engadiner Museum','Museum exploring the history, traditions, furniture, interiors, and culture of the Engadin region.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@stmoritz_id AND name='Engadiner Museum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @stmoritz_id, 1, 'Forum Paracelsus','Exhibition space connected to the history of the region''s famous mineral springs.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@stmoritz_id AND name='Forum Paracelsus');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @stmoritz_id, 4, 'Lake Staz','Peaceful mountain lake surrounded by forests, quieter than Lake St. Moritz.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@stmoritz_id AND name='Lake Staz');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @stmoritz_id, 4, 'Val Roseg','Beautiful Alpine valley surrounded by glaciers and dramatic peaks.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@stmoritz_id AND name='Val Roseg');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @stmoritz_id, 4, 'Muottas Muragl','Mountain viewpoint offering one of the best panoramas over the Upper Engadin lakes.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@stmoritz_id AND name='Muottas Muragl');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @stmoritz_id, 4, 'Pontresina','Elegant and quieter neighboring village with traditional architecture and mountain scenery.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@stmoritz_id AND name='Pontresina');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @stmoritz_id, 4, 'Lake Silvaplana','Beautiful lake surrounded by mountains, especially popular for water sports during summer.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@stmoritz_id AND name='Lake Silvaplana');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @basel_id, 1, 'Basel Minster','The city''s iconic Gothic and Romanesque cathedral, built from distinctive red sandstone and overlooking the Rhine.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@basel_id AND name='Basel Minster');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @basel_id, 1, 'Basel Old Town','One of Switzerland''s best-preserved historic centers, filled with medieval streets, fountains, and beautifully decorated buildings.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@basel_id AND name='Basel Old Town');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @basel_id, 1, 'Basel Town Hall','Striking bright-red Renaissance town hall with an elaborately decorated faÃ§ade.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@basel_id AND name='Basel Town Hall');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @basel_id, 1, 'Marktplatz Basel','Historic central square dominated by the Town Hall and surrounded by markets and historic buildings.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@basel_id AND name='Marktplatz Basel');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @basel_id, 1, 'Middle Bridge','Historic bridge crossing the Rhine and connecting the Old Town with Kleinbasel.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@basel_id AND name='Middle Bridge');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @basel_id, 1, 'Pfalz Basel','Terrace behind Basel Minster offering beautiful panoramic views over the Rhine.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@basel_id AND name='Pfalz Basel');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @basel_id, 2, 'Kunstmuseum Basel','Switzerland''s largest and oldest public art museum, with an exceptional collection from the Middle Ages to contemporary art.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@basel_id AND name='Kunstmuseum Basel');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @basel_id, 2, 'Fondation Beyeler','One of Europe''s most important modern art museums, featuring artists such as Monet, Picasso, Giacometti, and Rothko.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@basel_id AND name='Fondation Beyeler');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @basel_id, 2, 'Museum Tinguely','Dedicated to Swiss artist Jean Tinguely and his famous kinetic sculptures.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@basel_id AND name='Museum Tinguely');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @basel_id, 2, 'Basel Paper Mill Museum','Fascinating museum exploring the history of paper, printing, writing, and bookmaking.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@basel_id AND name='Basel Paper Mill Museum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @basel_id, 2, 'Museum of Cultures Basel','Major ethnographic museum with collections from cultures around the world.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@basel_id AND name='Museum of Cultures Basel');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @basel_id, 2, 'Vitra Design Museum','Internationally important design and architecture museum just across the German border.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@basel_id AND name='Vitra Design Museum');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @basel_id, 4, 'St Alban District','Quiet historic neighborhood with medieval walls, canals, and beautiful old houses.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@basel_id AND name='St Alban District');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @basel_id, 4, 'Kleinbasel','More relaxed and local-feeling district on the opposite side of the Rhine.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@basel_id AND name='Kleinbasel');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @basel_id, 4, 'Tinguely Fountain','Playful kinetic fountain designed by artist Jean Tinguely.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@basel_id AND name='Tinguely Fountain');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @basel_id, 4, 'Merian Gardens','Beautiful botanical gardens and historic landscapes just outside the center.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@basel_id AND name='Merian Gardens');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @basel_id, 4, 'Rhine Promenade','One of the best places to experience the city, particularly in summer when locals gather along the river.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@basel_id AND name='Rhine Promenade');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @montreux_id, 1, 'ChÃ¢teau de Chillon','One of Switzerland''s most famous castles, dramatically positioned on a small rocky island on Lake Geneva. Its history stretches back to the medieval period.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@montreux_id AND name='ChÃ¢teau de Chillon');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @montreux_id, 1, 'Montreux Old Town','Historic upper part of the city with narrow streets, traditional houses, and views over Lake Geneva.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@montreux_id AND name='Montreux Old Town');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @montreux_id, 1, 'Vieille Ville de Montreux','Atmospheric historic quarter climbing the hillside above the modern lakeside center.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@montreux_id AND name='Vieille Ville de Montreux');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @montreux_id, 1, 'Church of Saint-Vincent','Historic church dating largely from the medieval period, located in the Old Town.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@montreux_id AND name='Church of Saint-Vincent');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @montreux_id, 1, 'Caux','Beautiful mountain village above Montreux with historic Belle Ã‰poque hotels and spectacular views.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@montreux_id AND name='Caux');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @montreux_id, 2, 'Queen Studio Experience','Museum and exhibition inside the former Mountain Studios, where Queen recorded several albums.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@montreux_id AND name='Queen Studio Experience');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @montreux_id, 2, 'Freddie Mercury Statue','Iconic lakeside statue honoring Freddie Mercury, who had a strong connection to Montreux.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@montreux_id AND name='Freddie Mercury Statue');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @montreux_id, 2, 'Montreux Jazz Festival','One of the world''s most famous music festivals, attracting internationally renowned artists every summer.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@montreux_id AND name='Montreux Jazz Festival');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @montreux_id, 2, 'Chaplin''s World','Museum dedicated to the life and work of Charlie Chaplin, located near Montreux.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@montreux_id AND name='Chaplin''s World');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @montreux_id, 4, 'Lavaux Vineyards','UNESCO-listed terraced vineyards overlooking Lake Geneva, with spectacular walking routes and views.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@montreux_id AND name='Lavaux Vineyards');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @montreux_id, 4, 'Rochers-de-Naye','Mountain viewpoint high above Montreux, offering panoramic views over Lake Geneva and the Alps.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@montreux_id AND name='Rochers-de-Naye');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @montreux_id, 4, 'Les Avants','Quiet Alpine village surrounded by forests and mountains.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@montreux_id AND name='Les Avants');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @montreux_id, 4, 'Clarens','Peaceful lakeside neighborhood with gardens and a more local atmosphere.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@montreux_id AND name='Clarens');
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude)
SELECT @montreux_id, 4, 'Montreux Christmas Market','One of Switzerland''s most atmospheric Christmas markets, stretching along the lakefront during the winter season.', NULL, NULL FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM places WHERE city_id=@montreux_id AND name='Montreux Christmas Market');
