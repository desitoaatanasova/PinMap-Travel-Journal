-- PinMap Data Update Script
-- Adds 5 Portugal cities + 5 new countries and their cities.
-- Source: PinMap data updated.docx
-- Load before pinmap_places_portugal_more.sql and the new pinmap_places_*.sql files
-- (all must run in the same MySQL session so the @city_id variables stay in scope).
-- NOTE: intended filename is pinmap_data_update.sql, but Windows left a filesystem
-- tombstone for that name; rename this file once the tombstone clears (e.g. after reboot).

-- ===== COUNTRIES (new) =====
INSERT INTO countries (name, continent, description, flag_image, primary_color, secondary_color) VALUES
('Ireland', 'Europe', 'Emerald Isle of green landscapes, ancient castles, warm hospitality, and a rich literary and musical heritage.',
 'https://flagcdn.com/ie.svg', '#169B62', '#FF883E'),
('England', 'Europe', 'Historic cities, royal palaces, world-class museums, and rolling countryside across a country that shaped the modern world.',
 'https://flagcdn.com/gb-eng.svg', '#CE1124', '#FFFFFF'),
('Scotland', 'Europe', 'Dramatic highlands, lochs, whisky distilleries, and medieval castles steeped in centuries of clan history.',
 'https://flagcdn.com/gb-sct.svg', '#005EB8', '#FFFFFF'),
('Belgium', 'Europe', 'Chocolate, waffles, beer, and a remarkable heritage of medieval squares and Art Nouveau architecture.',
 'https://flagcdn.com/be.svg', '#000000', '#EF3340'),
('The Netherlands', 'Europe', 'Canal-ringed cities, windmills, world-famous museums, and bicycles everywhere across flat, flower-filled landscapes.',
 'https://flagcdn.com/nl.svg', '#AE1C28', '#21468B');

SET @ireland_id = LAST_INSERT_ID();
SET @england_id = @ireland_id + 1;
SET @scotland_id = @ireland_id + 2;
SET @belgium_id = @ireland_id + 3;
SET @netherlands_id = @ireland_id + 4;

-- ===== PORTUGAL EXTRA CITIES =====
INSERT INTO cities (country_id, name, description, latitude, longitude) VALUES
((SELECT country_id FROM countries WHERE name='Portugal'), 'Cascais', 'A glamorous seaside town of royal palaces, beaches, and Atlantic sunsets near Lisbon.', 38.6979, -9.4215),
((SELECT country_id FROM countries WHERE name='Portugal'), 'Faro', 'The gateway to the Algarve, a walled old town and marina on the edge of the Ria Formosa.', 37.0194, -7.9304),
((SELECT country_id FROM countries WHERE name='Portugal'), 'Coimbra', 'A medieval university city perched on a hill above the Mondego River, home to one of Europe''s oldest universities.', 40.2033, -8.4103),
((SELECT country_id FROM countries WHERE name='Portugal'), 'Óbidos', 'A picture-perfect walled medieval town of whitewashed houses, flowers, and cherry liqueur.', 39.3606, -9.1570),
((SELECT country_id FROM countries WHERE name='Portugal'), 'Aveiro', 'Portugal''s Venice, a canal-crossed town of Art Nouveau buildings and colourful moliceiro boats.', 40.6405, -8.6538);

SET @cascais_id = LAST_INSERT_ID();
SET @faro_id = @cascais_id + 1;
SET @coimbra_id = @cascais_id + 2;
SET @obidos_id = @cascais_id + 3;
SET @aveiro_id = @cascais_id + 4;

-- ===== IRELAND =====
INSERT INTO cities (country_id, name, description, latitude, longitude) VALUES
(@ireland_id, 'Dublin', 'Ireland''s vibrant capital of Georgian squares, lively pubs, and literary legends.', 53.3498, -6.2603),
(@ireland_id, 'Cork', 'Ireland''s second city, a food-loving riverside hub known for the English Market and warm locals.', 51.8985, -8.4756),
(@ireland_id, 'Galway', 'A bohemian harbour city famous for festivals, trad music, and the wild Atlantic.', 53.2707, -9.0568),
(@ireland_id, 'Limerick', 'A riverside city of medieval castles, Georgian elegance, and a strong storytelling tradition.', 52.6638, -8.6267),
(@ireland_id, 'Kilkenny', 'A charming medieval city of castles, craft workshops, and historic pubs.', 52.6541, -7.2448);

SET @dublin_id = LAST_INSERT_ID();
SET @cork_id = @dublin_id + 1;
SET @galway_id = @dublin_id + 2;
SET @limerick_id = @dublin_id + 3;
SET @kilkenny_id = @dublin_id + 4;

-- ===== ENGLAND =====
INSERT INTO cities (country_id, name, description, latitude, longitude) VALUES
(@england_id, 'London', 'A global capital of history, culture, and innovation spanning two millennia.', 51.5074, -0.1278),
(@england_id, 'Oxford', 'The City of Dreaming Spires, home to one of the world''s oldest and most prestigious universities.', 51.7520, -1.2577),
(@england_id, 'Cambridge', 'A historic university city of cobbled courts, riverside punts, and scientific breakthroughs.', 52.2053, 0.1218),
(@england_id, 'York', 'A walled city where Roman, Viking, and medieval layers of history come alive.', 53.9590, -1.0815),
(@england_id, 'Liverpool', 'The Beatles'' hometown and a UNESCO-listed maritime city of music, football, and culture.', 53.4084, -2.9916),
(@england_id, 'Manchester', 'An industrial powerhouse turned creative hub of music, sport, and science.', 53.4808, -2.2426);

SET @london_id = LAST_INSERT_ID();
SET @oxford_id = @london_id + 1;
SET @cambridge_id = @london_id + 2;
SET @york_id = @london_id + 3;
SET @liverpool_id = @london_id + 4;
SET @manchester_id = @london_id + 5;

-- ===== SCOTLAND =====
INSERT INTO cities (country_id, name, description, latitude, longitude) VALUES
(@scotland_id, 'Edinburgh', 'Scotland''s dramatic capital of castles, cobbled closes, and world-famous festivals.', 55.9533, -3.1883),
(@scotland_id, 'Glasgow', 'Scotland''s largest city, famed for Victorian architecture, art, and a warm welcome.', 55.8642, -4.2518),
(@scotland_id, 'Inverness', 'The capital of the Scottish Highlands, gateway to Loch Ness and the Cairngorms.', 57.4778, -4.2247),
(@scotland_id, 'St Andrews', 'The home of golf, an ancient university town on a dramatic stretch of Fife coast.', 56.3398, -2.7968),
(@scotland_id, 'Aberdeen', 'The Granite City of Scotland, where historic university buildings meet the North Sea.', 57.1497, -2.0943);

SET @edinburgh_id = LAST_INSERT_ID();
SET @glasgow_id = @edinburgh_id + 1;
SET @inverness_id = @edinburgh_id + 2;
SET @standrews_id = @edinburgh_id + 3;
SET @aberdeen_id = @edinburgh_id + 4;

-- ===== BELGIUM =====
INSERT INTO cities (country_id, name, description, latitude, longitude) VALUES
(@belgium_id, 'Brussels', 'Belgium''s capital and the heart of Europe, from Gothic squares to Art Nouveau and chocolate.', 50.8503, 4.3517),
(@belgium_id, 'Bruges', 'A fairytale canal city of medieval gables, cobbled squares, and world-famous chocolate.', 51.2093, 3.2247),
(@belgium_id, 'Ghent', 'A vibrant canal city blending medieval splendour with a lively student culture.', 51.0543, 3.7174),
(@belgium_id, 'Antwerp', 'A port city of Rubens, diamonds, and cutting-edge fashion on the River Scheldt.', 51.2194, 4.4025),
(@belgium_id, 'Leuven', 'A lively university town with one of Europe''s most beautiful Gothic town halls.', 50.8798, 4.7005);

SET @brussels_id = LAST_INSERT_ID();
SET @bruges_id = @brussels_id + 1;
SET @ghent_id = @brussels_id + 2;
SET @antwerp_id = @brussels_id + 3;
SET @leuven_id = @brussels_id + 4;

-- ===== THE NETHERLANDS =====
INSERT INTO cities (country_id, name, description, latitude, longitude) VALUES
(@netherlands_id, 'Amsterdam', 'The canal-ringed Dutch capital of bicycles, museums, and gabled houses.', 52.3676, 4.9041),
(@netherlands_id, 'Rotterdam', 'A bold, modern port city rebuilt after WWII, famous for its daring architecture.', 51.9244, 4.4777),
(@netherlands_id, 'The Hague', 'The Netherlands'' elegant seat of government, royal palaces, and international courts.', 52.0705, 4.3007),
(@netherlands_id, 'Utrecht', 'A medieval canal city of wharf cellars, the Dom Tower, and a lively student heart.', 52.0907, 5.1214),
(@netherlands_id, 'Delft', 'A pretty canal town famed for blue-and-white pottery and its painter Johannes Vermeer.', 52.0116, 4.3571);

SET @amsterdam_id = LAST_INSERT_ID();
SET @rotterdam_id = @amsterdam_id + 1;
SET @hague_id = @amsterdam_id + 2;
SET @utrecht_id = @amsterdam_id + 3;
SET @delft_id = @amsterdam_id + 4;

-- Verify by selecting the IDs
SELECT 'Cascais ID:', @cascais_id, 'Dublin ID:', @dublin_id, 'London ID:', @london_id,
       'Edinburgh ID:', @edinburgh_id, 'Brussels ID:', @brussels_id, 'Amsterdam ID:', @amsterdam_id;
