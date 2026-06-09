-- PinMap Places Data - Italy

-- ===== ROME =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@rome_id, 1, 'Colosseum', 'The iconic ancient amphitheater where gladiators once fought.', 41.8902, 12.4922),
(@rome_id, 1, 'Roman Forum', 'The political and social heart of ancient Rome.', 41.8925, 12.4853),
(@rome_id, 1, 'Palatine Hill', 'The centermost hill of Rome, where Romulus founded the city.', 41.8898, 12.4874),
(@rome_id, 1, 'Pantheon', 'A remarkably preserved ancient Roman temple with the largest unreinforced concrete dome.', 41.8986, 12.4769),
(@rome_id, 1, 'Baths of Caracalla', 'Massive public bath complex from the 3rd century AD.', 41.8792, 12.4935),
(@rome_id, 1, 'Appian Way', 'One of the most important ancient Roman roads, lined with tombs and catacombs.', 41.8450, 12.5200);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@rome_id, 2, 'Vatican Museums', 'An enormous collection of art and historical treasures amassed by the Catholic Church.', 41.9065, 12.4537),
(@rome_id, 2, 'Sistine Chapel', 'Michelangelo''s breathtaking frescoed ceiling and The Last Judgment.', 41.9029, 12.4545),
(@rome_id, 2, 'St. Peter''s Basilica', 'The largest church in the world and a masterpiece of Renaissance architecture.', 41.9022, 12.4533),
(@rome_id, 2, 'Borghese Gallery', 'An exquisite villa housing masterpieces by Bernini, Caravaggio, and Raphael.', 41.9142, 12.4921),
(@rome_id, 2, 'Capitoline Museums', 'The world''s oldest public museum, atop Capitoline Hill.', 41.8931, 12.4828),
(@rome_id, 2, 'San Luigi dei Francesi', 'A small church housing three stunning Caravaggio paintings of St. Matthew.', 41.8996, 12.4748);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@rome_id, 4, 'Basilica di San Clemente', 'A fascinating layered church revealing Roman history from the 1st century AD.', 41.8892, 12.4975),
(@rome_id, 4, 'Quartiere Coppedè', 'A whimsical hidden neighborhood of Art Nouveau fantasy architecture.', 41.9175, 12.5116),
(@rome_id, 4, 'Aventine Keyhole', 'A secret keyhole on the Aventine Hill offering a perfectly framed view of St. Peter''s dome.', 41.8837, 12.4780),
(@rome_id, 4, 'Domus Aurea', 'Nero''s enormous Golden House, a buried palace complex with stunning frescoes.', 41.8915, 12.4971),
(@rome_id, 4, 'Protestant Cemetery', 'A peaceful green cemetery where Keats and Shelley are buried, near the Pyramid of Cestius.', 41.8764, 12.4793);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@rome_id, 3, 'Trastevere', 'A charming medieval neighborhood with ivy-covered buildings and lively evening piazzas.', 41.8856, 12.4711),
(@rome_id, 3, 'Piazza Navona', 'A magnificent Baroque square with Bernini''s Fountain of the Four Rivers.', 41.8989, 12.4730),
(@rome_id, 3, 'Trevi Fountain', 'The largest Baroque fountain in Rome, where visitors toss a coin to ensure their return.', 41.9009, 12.4833),
(@rome_id, 3, 'Spanish Steps', 'A monumental stairway of 135 steps connecting Piazza di Spagna with Trinità dei Monti.', 41.9060, 12.4824),
(@rome_id, 3, 'Villa Borghese Gardens', 'Rome''s largest public park, perfect for leisurely strolls and cultural visits.', 41.9140, 12.4856);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@rome_id, 5, 'Tivoli', 'Ancient hilltop town with Hadrian''s Villa and Villa d''Este''s magnificent Renaissance gardens. ~1 hour from Rome.', 41.9617, 12.8000),
(@rome_id, 5, 'Ostia Antica', 'Ancient Rome''s seaport, exceptionally well-preserved and less crowded than Pompeii. ~30 min from Rome.', 41.7583, 12.3020),
(@rome_id, 5, 'Orvieto', 'A stunning hilltown in Umbria with a magnificent Gothic cathedral. ~1-1.5 h from Rome.', 42.7185, 12.1101),
(@rome_id, 5, 'Naples', 'Ancient city at the foot of Vesuvius, birthplace of pizza. ~1 h by high-speed train from Rome.', 40.8518, 14.2681),
(@rome_id, 5, 'Florence', 'Cradle of the Renaissance. ~1.5 h by high-speed train from Rome.', 43.7696, 11.2558);

-- ===== MILAN =====
-- Historical Sights
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@milan_id, 1, 'Duomo di Milano', 'The magnificent Gothic cathedral, one of the largest churches in the world.', 45.4641, 9.1914),
(@milan_id, 1, 'Castello Sforzesco', 'A grand 15th-century castle that once ruled Milan, now housing several museums.', 45.4705, 9.1790),
(@milan_id, 1, 'Basilica di Sant''Ambrogio', 'One of Milan''s oldest and most significant churches, founded in 379 AD.', 45.4625, 9.1753),
(@milan_id, 1, 'Columns of San Lorenzo', 'A row of 16 ancient Roman columns standing in front of Basilica San Lorenzo.', 45.4589, 9.1811),
(@milan_id, 1, 'Royal Palace of Milan', 'Former royal residence of Milan, now a major exhibition space.', 45.4634, 9.1909);

-- For the Art Lovers
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@milan_id, 2, 'Santa Maria delle Grazie', 'A Renaissance church and Dominican convent housing Leonardo''s The Last Supper.', 45.4651, 9.1706),
(@milan_id, 2, 'The Last Supper', 'Leonardo da Vinci''s world-famous mural of the Last Supper.', 45.4651, 9.1706),
(@milan_id, 2, 'Pinacoteca di Brera', 'Milan''s premier art gallery, featuring Italian Renaissance masterpieces.', 45.4719, 9.1883),
(@milan_id, 2, 'Ambrosian Library', 'One of the oldest public libraries in Europe, with Leonardo da Vinci''s Codex Atlanticus.', 45.4638, 9.1852),
(@milan_id, 2, 'Museo del Novecento', 'A museum dedicated to 20th-century Italian art, near the Duomo.', 45.4629, 9.1907);

-- Hidden Gems
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@milan_id, 4, 'San Bernardino alle Ossa', 'A small church with an ossuary chapel decorated entirely with human skulls and bones.', 45.4627, 9.1997),
(@milan_id, 4, 'Villa Necchi Campiglio', 'A stunning 1930s bourgeois villa with original furnishings and a beautiful garden.', 45.4730, 9.2050),
(@milan_id, 4, 'Cimitero Monumentale di Milano', 'An open-air museum of funerary art with ornate tombs and sculptures.', 45.4850, 9.1796),
(@milan_id, 4, 'Chiesa di San Maurizio al Monastero Maggiore', 'The Sistine Chapel of Milan, entirely frescoed inside.', 45.4643, 9.1772),
(@milan_id, 4, 'Porta Nuova District', 'Milan''s futuristic modern skyline with cutting-edge architecture and green spaces.', 45.4808, 9.1948);
