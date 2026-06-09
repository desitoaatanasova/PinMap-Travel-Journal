-- PinMap Real Data Insert Script
-- Source: PinMap Data.docx

-- ===== COUNTRIES =====
INSERT INTO countries (name, continent, description, flag_image, primary_color, secondary_color) VALUES
('Italy', 'Europe', 'Ancient ruins, Renaissance art, coastal beauty, and incredible cuisine across the boot-shaped peninsula.',
 'https://flagcdn.com/it.svg', '#009246', '#CE2B37'),
('France', 'Europe', 'World-renowned art, architecture, gastronomy, and diverse landscapes from alpine peaks to Mediterranean shores.',
 'https://flagcdn.com/fr.svg', '#002395', '#ED2939'),
('Spain', 'Europe', 'Passionate flamenco, vibrant festivals, sun-drenched beaches, and a rich tapestry of regional cultures.',
 'https://flagcdn.com/es.svg', '#C60B1E', '#FFC400'),
('Portugal', 'Europe', 'Atlantic coastline, charming azulejo-tiled cities, melancholic Fado, and Europe''s sunniest capital.',
 'https://flagcdn.com/pt.svg', '#006600', '#FF0000');

SET @italy_id = LAST_INSERT_ID();
SET @france_id = @italy_id + 1;
SET @spain_id = @italy_id + 2;
SET @portugal_id = @italy_id + 3;

-- ===== CITIES =====
-- Italy
INSERT INTO cities (country_id, name, description, latitude, longitude) VALUES
(@italy_id, 'Rome', 'The Eternal City, where 2,500 years of history unfold around every corner.', 41.9028, 12.4964),
(@italy_id, 'Milan', 'Italy''s fashion and design capital, home to the world''s most famous opera house.', 45.4642, 9.1900),
(@italy_id, 'Turin', 'Elegant Baroque city beneath the Alps, birthplace of Italian cinema and espresso.', 45.0703, 7.6869),
(@italy_id, 'Genoa', 'A maritime republic with Europe''s largest medieval old town.', 44.4056, 8.9463),
(@italy_id, 'Venice', 'The floating city of canals, bridges, and timeless romance.', 45.4408, 12.3155),
(@italy_id, 'Bologna', 'Home to the world''s oldest university and Italy''s best food scene.', 44.4949, 11.3426),
(@italy_id, 'Florence', 'Cradle of the Renaissance, where art and architecture shaped the modern world.', 43.7696, 11.2558),
(@italy_id, 'Naples', 'Ancient city at the foot of Vesuvius, birthplace of pizza.', 40.8518, 14.2681),
(@italy_id, 'Palermo', 'The heart of Sicily, layered with Phoenician, Roman, Arab, and Norman influences.', 38.1157, 13.3613);

SET @rome_id = LAST_INSERT_ID();
SET @milan_id = @rome_id + 1;
SET @turin_id = @rome_id + 2;
SET @genoa_id = @rome_id + 3;
SET @venice_id = @rome_id + 4;
SET @bologna_id = @rome_id + 5;
SET @florence_id = @rome_id + 6;
SET @naples_id = @rome_id + 7;
SET @palermo_id = @rome_id + 8;

-- France
INSERT INTO cities (country_id, name, description, latitude, longitude) VALUES
(@france_id, 'Paris', 'The City of Light, a global capital of art, fashion, gastronomy, and culture.', 48.8566, 2.3522),
(@france_id, 'Lyon', 'France''s gastronomic capital at the confluence of the Rhône and Saône rivers.', 45.7640, 4.8357),
(@france_id, 'Strasbourg', 'A enchanting Franco-German city at the heart of Europe.', 48.5734, 7.7521),
(@france_id, 'Bordeaux', 'The world''s wine capital, framed by elegant 18th-century architecture.', 44.8378, -0.5792),
(@france_id, 'Nice', 'The jewel of the French Riviera with azure waters and Mediterranean charm.', 43.7102, 7.2620),
(@france_id, 'Montpellier', 'A vibrant student city blending medieval roots with modern innovation.', 43.6108, 3.8767),
(@france_id, 'Avignon', 'The city of popes, surrounded by medieval ramparts on the Rhône.', 43.9493, 4.8055),
(@france_id, 'Marseille', 'France''s oldest city, a multicultural Mediterranean melting pot.', 43.2965, 5.3698),
(@france_id, 'Dijon', 'The capital of Burgundy, known for mustard, wine, and ducal history.', 47.3220, 5.0415);

SET @paris_id = LAST_INSERT_ID();
SET @lyon_id = @paris_id + 1;
SET @strasbourg_id = @paris_id + 2;
SET @bordeaux_id = @paris_id + 3;
SET @nice_id = @paris_id + 4;
SET @montpellier_id = @paris_id + 5;
SET @avignon_id = @paris_id + 6;
SET @marseille_id = @paris_id + 7;
SET @dijon_id = @paris_id + 8;

-- Spain
INSERT INTO cities (country_id, name, description, latitude, longitude) VALUES
(@spain_id, 'Madrid', 'Spain''s vibrant capital, where art, nightlife, and royal heritage converge.', 40.4168, -3.7038),
(@spain_id, 'Barcelona', 'A Mediterranean masterpiece of modernist architecture and Catalan culture.', 41.3874, 2.1686),
(@spain_id, 'Seville', 'The soul of Andalusia, birthplace of flamenco and adorned with Moorish palaces.', 37.3891, -5.9845),
(@spain_id, 'Valencia', 'The birthplace of paella, blending futuristic architecture with historic charm.', 39.4699, -0.3763),
(@spain_id, 'Málaga', 'Picasso''s birthplace on the Costa del Sol with a thousand years of history.', 36.7213, -4.4214),
(@spain_id, 'San Sebastián', 'A Basque culinary paradise framed by golden beaches and green hills.', 43.3183, -1.9812),
(@spain_id, 'Palma de Mallorca', 'The Balearic capital with a stunning Gothic cathedral and Mediterranean lifestyle.', 39.5696, 2.6502);

SET @madrid_id = LAST_INSERT_ID();
SET @barcelona_id = @madrid_id + 1;
SET @seville_id = @madrid_id + 2;
SET @valencia_id = @madrid_id + 3;
SET @malaga_id = @madrid_id + 4;
SET @sansebastian_id = @madrid_id + 5;
SET @palma_id = @madrid_id + 6;

-- Portugal
INSERT INTO cities (country_id, name, description, latitude, longitude) VALUES
(@portugal_id, 'Lisbon', 'Europe''s sunniest capital, built on seven hills overlooking the Tagus River.', 38.7223, -9.1393),
(@portugal_id, 'Porto', 'A riverside gem of port wine, azulejo tiles, and the Douro Valley.', 41.1579, -8.6291),
(@portugal_id, 'Sintra', 'A fairytale town of Romantic palaces and lush forested hills.', 38.8029, -9.3817);

SET @lisbon_id = LAST_INSERT_ID();
SET @porto_id = @lisbon_id + 1;
SET @sintra_id = @lisbon_id + 2;

-- Verify city IDs by selecting them
SELECT 'Cities inserted. Rome ID:', @rome_id, 'Paris ID:', @paris_id, 'Madrid ID:', @madrid_id, 'Lisbon ID:', @lisbon_id;
