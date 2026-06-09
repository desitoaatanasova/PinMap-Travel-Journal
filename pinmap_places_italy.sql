-- PinMap All Places Data
-- Using actual city IDs from the database

-- ============================================
-- ITALY (country_id=11)
-- ============================================

-- ===== ROME (city_id=32) =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(32, 1, 'Colosseum', 'The iconic ancient amphitheater where gladiators once fought.', 41.8902, 12.4922),
(32, 1, 'Roman Forum', 'The political and social heart of ancient Rome.', 41.8925, 12.4853),
(32, 1, 'Palatine Hill', 'The centermost hill of Rome, where Romulus founded the city.', 41.8898, 12.4874),
(32, 1, 'Pantheon', 'A remarkably preserved ancient Roman temple with the largest unreinforced concrete dome.', 41.8986, 12.4769),
(32, 1, 'Baths of Caracalla', 'Massive public bath complex from the 3rd century AD.', 41.8792, 12.4935),
(32, 1, 'Appian Way', 'One of the most important ancient Roman roads, lined with tombs and catacombs.', 41.8450, 12.5200);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(32, 2, 'Vatican Museums', 'An enormous collection of art and historical treasures amassed by the Catholic Church.', 41.9065, 12.4537),
(32, 2, 'Sistine Chapel', 'Michelangelo''s breathtaking frescoed ceiling and The Last Judgment.', 41.9029, 12.4545),
(32, 2, 'St. Peter''s Basilica', 'The largest church in the world and a masterpiece of Renaissance architecture.', 41.9022, 12.4533),
(32, 2, 'Borghese Gallery', 'An exquisite villa housing masterpieces by Bernini, Caravaggio, and Raphael.', 41.9142, 12.4921),
(32, 2, 'Capitoline Museums', 'The world''s oldest public museum, atop Capitoline Hill.', 41.8931, 12.4828),
(32, 2, 'San Luigi dei Francesi', 'A small church housing three stunning Caravaggio paintings of St. Matthew.', 41.8996, 12.4748);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(32, 4, 'Basilica di San Clemente', 'A fascinating layered church revealing Roman history from the 1st century AD.', 41.8892, 12.4975),
(32, 4, 'Quartiere Coppede', 'A whimsical hidden neighborhood of Art Nouveau fantasy architecture.', 41.9175, 12.5116),
(32, 4, 'Aventine Keyhole', 'A secret keyhole on the Aventine Hill offering a perfectly framed view of St. Peter''s dome.', 41.8837, 12.4780),
(32, 4, 'Domus Aurea', 'Nero''s enormous Golden House, a buried palace complex with stunning frescoes.', 41.8915, 12.4971),
(32, 4, 'Protestant Cemetery', 'A peaceful green cemetery where Keats and Shelley are buried, near the Pyramid of Cestius.', 41.8764, 12.4793);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(32, 3, 'Trastevere', 'A charming medieval neighborhood with ivy-covered buildings and lively evening piazzas.', 41.8856, 12.4711),
(32, 3, 'Piazza Navona', 'A magnificent Baroque square with Bernini''s Fountain of the Four Rivers.', 41.8989, 12.4730),
(32, 3, 'Trevi Fountain', 'The largest Baroque fountain in Rome, where visitors toss a coin to ensure their return.', 41.9009, 12.4833),
(32, 3, 'Spanish Steps', 'A monumental stairway of 135 steps connecting Piazza di Spagna with Trinita dei Monti.', 41.9060, 12.4824),
(32, 3, 'Villa Borghese Gardens', 'Rome''s largest public park, perfect for leisurely strolls and cultural visits.', 41.9140, 12.4856);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(32, 5, 'Tivoli', 'Ancient hilltop town with Hadrian''s Villa and Villa d''Este gardens. ~1 hour from Rome.', 41.9617, 12.8000),
(32, 5, 'Ostia Antica', 'Ancient Rome''s seaport, exceptionally well-preserved. ~30 min from Rome.', 41.7583, 12.3020),
(32, 5, 'Orvieto', 'A stunning hilltown in Umbria with a magnificent Gothic cathedral. ~1-1.5 h from Rome.', 42.7185, 12.1101),
(32, 5, 'Naples', 'Ancient city, birthplace of pizza. ~1 h by high-speed train from Rome.', 40.8518, 14.2681),
(32, 5, 'Florence', 'Cradle of the Renaissance. ~1.5 h by high-speed train from Rome.', 43.7696, 11.2558);

-- ===== MILAN (city_id=33) =====
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(33, 1, 'Duomo di Milano', 'The magnificent Gothic cathedral, one of the largest churches in the world.', 45.4641, 9.1914),
(33, 1, 'Castello Sforzesco', 'A grand 15th-century castle that once ruled Milan, now housing several museums.', 45.4705, 9.1790),
(33, 1, 'Basilica di Sant Ambrogio', 'One of Milan''s oldest and most significant churches, founded in 379 AD.', 45.4625, 9.1753),
(33, 1, 'Columns of San Lorenzo', 'A row of 16 ancient Roman columns standing in front of Basilica San Lorenzo.', 45.4589, 9.1811),
(33, 1, 'Royal Palace of Milan', 'Former royal residence, now a major exhibition space.', 45.4634, 9.1909);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(33, 2, 'Santa Maria delle Grazie', 'A Renaissance church housing Leonardo''s The Last Supper.', 45.4651, 9.1706),
(33, 2, 'The Last Supper', 'Leonardo da Vinci''s world-famous mural.', 45.4651, 9.1706),
(33, 2, 'Pinacoteca di Brera', 'Milan''s premier art gallery, featuring Italian Renaissance masterpieces.', 45.4719, 9.1883),
(33, 2, 'Ambrosian Library', 'One of Europe''s oldest public libraries, with Leonardo''s Codex Atlanticus.', 45.4638, 9.1852),
(33, 2, 'Museo del Novecento', 'A museum dedicated to 20th-century Italian art.', 45.4629, 9.1907);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(33, 4, 'San Bernardino alle Ossa', 'A small church with an ossuary decorated with human skulls and bones.', 45.4627, 9.1997),
(33, 4, 'Villa Necchi Campiglio', 'A stunning 1930s bourgeois villa with original furnishings.', 45.4730, 9.2050),
(33, 4, 'Cimitero Monumentale di Milano', 'An open-air museum of funerary art with ornate tombs.', 45.4850, 9.1796),
(33, 4, 'San Maurizio al Monastero Maggiore', 'The Sistine Chapel of Milan, entirely frescoed inside.', 45.4643, 9.1772),
(33, 4, 'Porta Nuova District', 'Milan''s futuristic modern skyline with cutting-edge architecture.', 45.4808, 9.1948);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(33, 3, 'Galleria Vittorio Emanuele II', 'Italy''s oldest active shopping gallery, stunning 19th-century arcade.', 45.4655, 9.1902),
(33, 3, 'Navigli District', 'A lively canal district with aperitivo bars and vintage shops.', 45.4498, 9.1769),
(33, 3, 'Brera District', 'A bohemian neighborhood with art galleries, boutiques, and cafes.', 45.4720, 9.1825),
(33, 3, 'Parco Sempione', 'Milan''s central park behind the Sforza Castle.', 45.4735, 9.1730);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(33, 5, 'Lake Como', 'Stunning alpine lake with picturesque villages. ~40-60 min from Milan.', 45.9990, 9.2578),
(33, 5, 'Stresa', 'Elegant town on Lake Maggiore with Borromean Islands. ~1 h from Milan.', 45.8844, 8.5334),
(33, 5, 'Bergamo', 'A beautifully preserved hilltop city with two distinct levels. ~50 min from Milan.', 45.6950, 9.6700),
(33, 5, 'Verona', 'City of Romeo and Juliet with a magnificent Roman arena. ~1-1.5 h from Milan.', 45.4384, 10.9916),
(33, 5, 'Turin', 'Elegant Baroque city beneath the Alps. ~1 h from Milan.', 45.0703, 7.6869),
(33, 5, 'Cremona', 'The hometown of Stradivari violin-making tradition. ~1 h from Milan.', 45.1333, 10.0333);

-- ===== TURIN (city_id=34) =====
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(34, 1, 'Palazzo Reale di Torino', 'The royal palace of the House of Savoy, richly decorated.', 45.0710, 7.6862),
(34, 1, 'Palazzo Madama', 'A UNESCO World Heritage site blending medieval and Baroque architecture.', 45.0709, 7.6850),
(34, 1, 'Mole Antonelliana', 'The iconic landmark of Turin, housing the National Cinema Museum.', 45.0692, 7.6940),
(34, 1, 'Cathedral of Saint John the Baptist', 'Home of the famous Shroud of Turin.', 45.0733, 7.6852),
(34, 1, 'Porta Palatina', 'An ancient Roman city gate from the 1st century BC.', 45.0743, 7.6808);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(34, 2, 'Galleria Sabauda', 'The Savoy Gallery with masterpieces from Italian and Flemish artists.', 45.0713, 7.6865),
(34, 2, 'Palazzo Carignano', 'A historic palace housing the Museum of the Risorgimento.', 45.0694, 7.6876),
(34, 2, 'Museo Egizio', 'The world''s second-largest Egyptian museum after Cairo.', 45.0686, 7.6840),
(34, 2, 'Church of San Lorenzo', 'A Baroque masterpiece with Guarini''s stunning dome.', 45.0720, 7.6846),
(34, 2, 'Venaria Reale', 'A magnificent royal palace and gardens on the outskirts of Turin.', 45.1350, 7.6260);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(34, 4, 'Villa della Regina', 'A delightful Savoy residence with terraced Italian gardens.', 45.0590, 7.7010),
(34, 4, 'Lingotto Building', 'The former Fiat factory with a rooftop test track, now a cultural venue.', 45.0322, 7.6625),
(34, 4, 'Santuario della Consolata', 'A unique sanctuary blending Baroque and Romanesque styles.', 45.0777, 7.6760),
(34, 4, 'Borgo Medievale', 'A faithful replica of a medieval village in Valentino Park.', 45.0526, 7.6870);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(34, 3, 'Arcades of Via Roma', 'Walk beneath endless arcades along the elegant Via Roma.', 45.0680, 7.6794),
(34, 3, 'Caffe San Carlo', 'Coffee in historic cafes like this elegant 19th-century institution.', 45.0682, 7.6807),
(34, 3, 'Monte dei Cappuccini', 'Sunset view from this hill overlooking the city and Alps.', 45.0590, 7.6950),
(34, 3, 'Piazza Castello', 'Evening stroll at the heart of the city surrounded by royal palaces.', 45.0705, 7.6861);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(34, 5, 'Asti', 'A town known for its sparkling wine and medieval towers. ~35-45 min from Turin.', 44.9008, 8.2068),
(34, 5, 'Alba', 'The white truffle capital of the Piedmont region. ~1 h 30 min from Turin.', 44.6995, 8.0358),
(34, 5, 'Sacra di San Michele', 'A stunning mountaintop abbey inspiring The Name of the Rose. ~1-1.5 h from Turin.', 45.0857, 7.3430),
(34, 5, 'Milan', 'Italy''s fashion capital. ~50-60 min from Turin.', 45.4642, 9.1900);

-- ===== GENOA (city_id=35) =====
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(35, 1, 'Palazzo Ducale', 'The historic Doge''s Palace in the heart of Genoa.', 44.4074, 8.9319),
(35, 1, 'Genoa Cathedral', 'A striking black-and-white striped cathedral dedicated to San Lorenzo.', 44.4076, 8.9310),
(35, 1, 'Porto Antico', 'The revitalized old port area designed by Renzo Piano.', 44.4100, 8.9260),
(35, 1, 'Lanterna di Genova', 'Genoa''s iconic lighthouse, one of the oldest standing lighthouses in the world.', 44.4005, 8.9060),
(35, 1, 'Via Garibaldi', 'A UNESCO-listed street of magnificent Renaissance palaces.', 44.4110, 8.9343);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(35, 2, 'Palazzi dei Rolli', 'A system of Renaissance palaces, UNESCO World Heritage.', 44.4112, 8.9337),
(35, 2, 'Palazzo Rosso', 'A museum housed in a 17th-century red palace with Genoese masterpieces.', 44.4110, 8.9332),
(35, 2, 'Palazzo Bianco', 'An art museum in a white palace featuring Flemish and Italian works.', 44.4110, 8.9337),
(35, 2, 'Palazzo Doria Tursi', 'The largest Rolli palace, now serving as the town hall.', 44.4112, 8.9330),
(35, 2, 'Church of the Gesu', 'A Baroque church with stunning frescoes and artwork.', 44.4079, 8.9306);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(35, 4, 'Boccadasse', 'A picturesque colorful fishing village within the city.', 44.3925, 8.9665),
(35, 4, 'Spianata Castelletto', 'A panoramic terrace offering spectacular views over Genoa.', 44.4066, 8.9390),
(35, 4, 'Galata Maritime Museum', 'The largest maritime museum in the Mediterranean.', 44.4120, 8.9230),
(35, 4, 'Christopher Columbus House', 'The reconstructed birthplace of the famous explorer.', 44.3991, 8.9281);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(35, 3, 'Piazza de Ferrari', 'Genoa''s main square with the monumental fountain.', 44.4078, 8.9345),
(35, 3, 'Caruggi (Narrow Alleys)', 'Lose yourself in the medieval labyrinth of narrow alleys.', 44.4056, 8.9330),
(35, 3, 'Porto Antico Harbor', 'Evening walk along the historic harbor.', 44.4095, 8.9280),
(35, 3, 'Historic Elevators', 'Ride historic elevators linking upper and lower city.', 44.4050, 8.9360);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(35, 5, 'Cinque Terre', 'Five colorful fishing villages on the rugged Italian Riviera. ~1-1.5 h from Genoa.', 44.1360, 9.7160),
(35, 5, 'Portofino', 'A glamorous fishing village with pastel-colored houses. ~1 h from Genoa.', 44.3043, 9.2089),
(35, 5, 'Camogli', 'A colorful seaside town with a historic harbor. ~30-40 min from Genoa.', 44.3486, 9.1550),
(35, 5, 'Santa Margherita Ligure', 'An elegant seaside resort on the Riviera. ~35-45 min from Genoa.', 44.3352, 9.2120);

-- ===== VENICE (city_id=36) =====
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(36, 1, 'St. Mark''s Basilica', 'The cathedral of Venice with breathtaking Byzantine mosaics.', 45.4342, 12.3397),
(36, 1, 'Doge''s Palace', 'The Gothic masterpiece and former seat of Venetian government.', 45.4339, 12.3406),
(36, 1, 'St. Mark''s Square', 'Napoleon called it the drawing room of Europe.', 45.4340, 12.3380),
(36, 1, 'Rialto Bridge', 'The oldest and most famous bridge crossing the Grand Canal.', 45.4380, 12.3360),
(36, 1, 'Arsenale di Venezia', 'The historic shipyard that built Venice''s maritime empire.', 45.4326, 12.3550);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(36, 2, 'Gallerie dell Accademia', 'Venice''s premier art museum with Venetian masterpieces.', 45.4313, 12.3288),
(36, 2, 'Peggy Guggenheim Collection', 'A modern art museum in Peggy Guggenheim''s former home.', 45.4307, 12.3327),
(36, 2, 'Scuola Grande di San Rocco', 'An ornate building lavishly decorated with Tintoretto paintings.', 45.4371, 12.3250),
(36, 2, 'Santa Maria della Salute', 'A majestic Baroque church at the entrance of the Grand Canal.', 45.4305, 12.3344),
(36, 2, 'Ca Rezzonico', 'A grand palazzo dedicated to 18th-century Venetian art.', 45.4331, 12.3272);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(36, 4, 'San Giorgio Maggiore', 'An island church with a bell tower offering stunning views.', 45.4288, 12.3430),
(36, 4, 'Scala Contarini del Bovolo', 'A hidden spiral staircase with exquisite Renaissance details.', 45.4348, 12.3346),
(36, 4, 'Cannaregio District', 'A quiet residential area with authentic Venetian atmosphere.', 45.4450, 12.3200),
(36, 4, 'Jewish Ghetto', 'The historic Jewish quarter, the first ghetto in the world.', 45.4460, 12.3260),
(36, 4, 'Church of Madonna dell Orto', 'A beautiful Gothic church with works by Tintoretto.', 45.4477, 12.3308);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(36, 3, 'Grand Canal', 'Gondola or vaporetto ride along the main waterway of Venice.', 45.4370, 12.3270),
(36, 3, 'Venice Evening Wandering', 'Evening wandering without map through quiet alleyways.', 45.4380, 12.3300),
(36, 3, 'St. Marks Square at Night', 'Sunrise or late-night walk in the square when nearly empty.', 45.4342, 12.3380),
(36, 3, 'Dorsoduro Bridges', 'Crossing small bridges in the peaceful Dorsoduro district.', 45.4320, 12.3250),
(36, 3, 'Canal Aperitivo', 'Aperitivo beside canals as the sun sets.', 45.4330, 12.3280);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(36, 5, 'Verona', 'City of Romeo and Juliet with a Roman arena. ~1-1.5 h from Venice.', 45.4384, 10.9916),
(36, 5, 'Padua', 'Home to Giotto''s Scrovegni Chapel and a historic university. ~25-30 min from Venice.', 45.4064, 11.8768),
(36, 5, 'Murano', 'The famous glass-blowing island. ~20 min from Venice.', 45.4576, 12.3523),
(36, 5, 'Burano', 'A brightly colored fishing island. ~45-50 min from Venice.', 45.4850, 12.4170),
(36, 5, 'Torcello', 'The quiet, ancient island with a Byzantine cathedral. ~50-60 min from Venice.', 45.4979, 12.4180);

-- ===== BOLOGNA (city_id=37) =====
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(37, 1, 'Piazza Maggiore', 'The main square of Bologna, surrounded by medieval buildings.', 44.4938, 11.3428),
(37, 1, 'Basilica di San Petronio', 'One of the largest churches in the world, dominating Piazza Maggiore.', 44.4929, 11.3428),
(37, 1, 'Two Towers of Bologna', 'The iconic leaning towers Asinelli and Garisenda.', 44.4942, 11.3465),
(37, 1, 'Archiginnasio of Bologna', 'The historic seat of the university with a stunning anatomical theater.', 44.4919, 11.34211),
(37, 1, 'Basilica di Santo Stefano', 'A complex of seven churches dating from the 4th to 13th centuries.', 44.4921, 11.3478);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(37, 2, 'Pinacoteca Nazionale di Bologna', 'The national art gallery with masterpieces from the Emilian school.', 44.4982, 11.3535),
(37, 2, 'Sanctuary of the Madonna di San Luca', 'A hilltop sanctuary reached by a 3.8 km portico.', 44.4793, 11.2975),
(37, 2, 'Palazzo Poggi', 'A university museum with fascinating scientific collections.', 44.4968, 11.3542),
(37, 2, 'Teatro Anatomico', 'A remarkable wooden anatomical theater in the Archiginnasio.', 44.4919, 11.3421);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(37, 4, 'Finestrella di Via Piella', 'A small window revealing a hidden canal view of old Bologna.', 44.4965, 11.3418),
(37, 4, 'Quadrilatero Market', 'A medieval market area now filled with food shops and stalls.', 44.4935, 11.3455),
(37, 4, 'Certosa di Bologna', 'A monumental cemetery with impressive sculptures.', 44.4960, 11.3130),
(37, 4, 'Palazzo dell Archiginnasio', 'The historic library with a vast collection of rare books.', 44.4919, 11.3421);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(37, 3, 'Porticoes of Bologna', 'Walk under the porticoes, over 40 km of covered walkways.', 44.4950, 11.3430),
(37, 3, 'Asinelli Tower', 'Climb the tower for terracotta rooftops view.', 44.4942, 11.3465),
(37, 3, 'Via Zamboni Evening', 'Evening stroll with students around the university area.', 44.4970, 11.3510),
(37, 3, 'San Luca Hill Sunset', 'Sunset from the Sanctuary hill overlooking the city.', 44.4793, 11.2975);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(37, 5, 'Florence', 'Cradle of the Renaissance. ~35-40 min from Bologna.', 43.7696, 11.2558),
(37, 5, 'Ravenna', 'Home to stunning Byzantine mosaics. ~1-1.5 h from Bologna.', 44.4161, 12.2012),
(37, 5, 'Parma', 'The capital of food, with parmesan and prosciutto. ~50-60 min from Bologna.', 44.8015, 10.3280),
(37, 5, 'Modena', 'Home of balsamic vinegar and Ferrari. ~20-30 min from Bologna.', 44.6471, 10.9252),
(37, 5, 'Ferrara', 'A Renaissance city with massive city walls. ~30 min from Bologna.', 44.8381, 11.6199);

-- ===== FLORENCE (city_id=38) =====
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(38, 1, 'Florence Cathedral', 'Santa Maria del Fiore, with Brunelleschi''s iconic dome.', 43.7731, 11.2560),
(38, 1, 'Piazza del Duomo', 'The cathedral square surrounded by historic buildings.', 43.7730, 11.2550),
(38, 1, 'Palazzo Vecchio', 'Florence''s medieval town hall with a towering campanile.', 43.7694, 11.2565),
(38, 1, 'Ponte Vecchio', 'The iconic medieval bridge lined with jewelry shops.', 43.7679, 11.2537),
(38, 1, 'Basilica of Santa Croce', 'The burial place of Michelangelo, Galileo, and Machiavelli.', 43.7687, 11.2624);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(38, 2, 'Uffizi Gallery', 'One of the world''s greatest art museums with Botticelli, Leonardo, and Raphael.', 43.7686, 11.2558),
(38, 2, 'Accademia Gallery', 'Home to Michelangelo''s magnificent statue of David.', 43.7769, 11.2586),
(38, 2, 'Palazzo Pitti', 'The vast former residence of the Medici, housing multiple museums.', 43.7650, 11.2496),
(38, 2, 'Boboli Gardens', 'The magnificent Renaissance gardens behind Palazzo Pitti.', 43.7625, 11.2486),
(38, 2, 'Basilica of Santa Maria Novella', 'A Dominican church with Masaccio''s frescoes.', 43.7746, 11.2491);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(38, 4, 'San Miniato al Monte', 'A beautiful Romanesque church with panoramic city views.', 43.7597, 11.2649),
(38, 4, 'Brancacci Chapel', 'Masaccio''s frescoes that changed the course of Western art.', 43.7701, 11.2446),
(38, 4, 'Bargello Museum', 'A sculpture museum in a medieval palace.', 43.7705, 11.2582),
(38, 4, 'Medici Chapels', 'Michelangelo''s New Sacristy and the Medici mausoleum.', 43.7750, 11.2537),
(38, 4, 'Oltrarno District', 'The artisan quarter across the river, full of workshops.', 43.7670, 11.2490);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(38, 3, 'Piazzale Michelangelo', 'Sunset viewpoint overlooking the entire city.', 43.7628, 11.2655),
(38, 3, 'Arno River Evening', 'Evening walk along the Arno River with illuminated bridges.', 43.7680, 11.2550),
(38, 3, 'Medieval Streets', 'Wander medieval streets after museums close.', 43.7700, 11.2570),
(38, 3, 'Oltrarno Piazzas', 'Coffee or wine in the small piazzas across the Arno.', 43.7660, 11.2500);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(38, 5, 'Siena', 'A medieval hilltop city with a stunning shell-shaped square. ~1.5 h from Florence.', 43.3186, 11.3314),
(38, 5, 'Pisa', 'Home to the legendary Leaning Tower. ~50-60 min from Florence.', 43.7228, 10.4017),
(38, 5, 'Chianti', 'The famous wine region with rolling hills and vineyards. ~1-1.5 h from Florence.', 43.5700, 11.3200),
(38, 5, 'Lucca', 'A walled Renaissance city with tree-lined ramparts. ~1.5 h from Florence.', 43.8428, 10.5029),
(38, 5, 'Bologna', 'Italy''s culinary capital. ~35-40 min from Florence.', 44.4949, 11.3426);

-- ===== NAPLES (city_id=39) =====
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(39, 1, 'Naples Historic Centre', 'A UNESCO World Heritage site, one of Europe''s largest historic centers.', 40.8520, 14.2580),
(39, 1, 'Naples Cathedral', 'Duomo di San Gennaro, dedicated to the city''s patron saint.', 40.8526, 14.2594),
(39, 1, 'Castel Nuovo', 'The massive medieval castle overlooking the harbor.', 40.8383, 14.2520),
(39, 1, 'Castel dell Ovo', 'The oldest castle in Naples, on the seafront.', 40.8280, 14.2480),
(39, 1, 'Royal Palace of Naples', 'The former residence of Spanish and Bourbon rulers.', 40.8358, 14.2494);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(39, 2, 'Naples National Archaeological Museum', 'One of the world''s most important collections of Greco-Roman antiquities.', 40.8538, 14.2505),
(39, 2, 'Capodimonte Museum', 'A vast art collection in a former Bourbon palace.', 40.8670, 14.2480),
(39, 2, 'Certosa di San Martino', 'A former monastery with stunning views over the city.', 40.8430, 14.2330),
(39, 2, 'Church of Gesu Nuovo', 'A Baroque church with an extraordinary facade.', 40.8475, 14.2545),
(39, 2, 'Sansevero Chapel', 'Housing the incredible Veiled Christ sculpture.', 40.8492, 14.2559);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(39, 4, 'Naples Underground', 'Explore ancient tunnels and cisterns beneath the city.', 40.8510, 14.2550),
(39, 4, 'Catacombs of San Gennaro', 'Ancient underground burial chambers with early Christian frescoes.', 40.8635, 14.2462),
(39, 4, 'Quartieri Spagnoli', 'The Spanish Quarter, a vibrant maze of narrow streets.', 40.8390, 14.2440),
(39, 4, 'Via San Gregorio Armeno', 'The famous street of nativity scene artisans.', 40.8500, 14.2575);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(39, 3, 'Lungomare di Napoli', 'Walk along the beautiful seafront promenade.', 40.8285, 14.2445),
(39, 3, 'Historic Center Street Life', 'Soak in the vibrant street life of the historic center.', 40.8510, 14.2560),
(39, 3, 'Vesuvius Sunset', 'Sunset views toward the iconic volcano.', 40.8270, 14.2490),
(39, 3, 'Pizza Experience', 'Espresso culture and traditional pizzerias.', 40.8500, 14.2550);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(39, 5, 'Pompeii', 'The ancient Roman city preserved by Vesuvius eruption. ~35-40 min from Naples.', 40.7489, 14.4850),
(39, 5, 'Herculaneum', 'A smaller but better-preserved Roman town. ~20-25 min from Naples.', 40.8060, 14.3476),
(39, 5, 'Mount Vesuvius', 'Hike the volcano that destroyed Pompeii. ~1-1.5 h from Naples.', 40.8214, 14.4260),
(39, 5, 'Sorrento', 'A picturesque coastal town overlooking the Bay of Naples. ~1 h from Naples.', 40.6263, 14.3753),
(39, 5, 'Positano', 'The iconic vertical village on the Amalfi Coast. ~1.5-2 h from Naples.', 40.6275, 14.4854),
(39, 5, 'Amalfi', 'The heart of the Amalfi Coast. ~2 h from Naples.', 40.6336, 14.6027),
(39, 5, 'Caserta', 'The Italian Versailles with spectacular gardens. ~30-40 min from Naples.', 41.0712, 14.3327);

-- ===== PALERMO (city_id=40) =====
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(40, 1, 'Palermo Cathedral', 'A magnificent cathedral reflecting centuries of different rulers.', 38.1142, 13.3564),
(40, 1, 'Palace of the Normans', 'One of the oldest royal residences in Europe.', 38.1112, 13.3532),
(40, 1, 'Palatine Chapel', 'A breathtaking chapel covered in golden Byzantine mosaics.', 38.1113, 13.3534),
(40, 1, 'Quattro Canti', 'An octagonal square at the intersection of the two main streets.', 38.1159, 13.3613),
(40, 1, 'Teatro Massimo', 'The largest opera house in Italy.', 38.1199, 13.3578);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(40, 2, 'Church of the Gesu', 'A richly decorated Baroque church in the heart of Palermo.', 38.1138, 13.3593),
(40, 2, 'Palazzo Abatellis', 'The Regional Gallery with superb Sicilian medieval art.', 38.1181, 13.3664),
(40, 2, 'Oratory of San Lorenzo', 'An ornate oratory with stunning stucco work.', 38.1164, 13.3623),
(40, 2, 'Oratory of Santa Cita', 'Another magnificent oratory with intricate stucco decorations.', 38.1195, 13.3648),
(40, 2, 'Teatro Politeama Garibaldi', 'A grand 19th-century theater in the city center.', 38.1227, 13.3579);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(40, 4, 'Catacombe dei Cappuccini', 'Famous mummified catacombs with thousands of preserved bodies.', 38.1130, 13.3420),
(40, 4, 'Ballaro Market', 'A vibrant street market with a distinctly North African atmosphere.', 38.1138, 13.3655),
(40, 4, 'Mondello Beach', 'A beautiful sandy beach just outside the city.', 38.2016, 13.3220),
(40, 4, 'Villa Giulia', 'A beautiful public garden near the sea.', 38.1199, 13.3696),
(40, 4, 'Santa Caterina Church', 'A Baroque church with a stunning cloister.', 38.1167, 13.3630);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(40, 3, 'Via Maqueda Evening', 'Evening walk between Via Maqueda and historic squares.', 38.1150, 13.3620),
(40, 3, 'Street Food Markets', 'Street food tasting in the bustling markets.', 38.1140, 13.3650),
(40, 3, 'Teatro Massimo Performance', 'Opera or concert at the magnificent Teatro Massimo.', 38.1199, 13.3578),
(40, 3, 'Palermo Waterfront Sunset', 'Sunset near the historic waterfront.', 38.1220, 13.3680);

INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(40, 5, 'Monreale', 'Home to a stunning Norman cathedral with golden mosaics. ~30-40 min from Palermo.', 38.0823, 13.2887),
(40, 5, 'Cefalu', 'A picturesque coastal town with a beautiful Norman cathedral. ~50-60 min from Palermo.', 38.0390, 14.0220),
(40, 5, 'Segesta', 'An ancient Greek temple in a stunning rural setting. ~1.5 h from Palermo.', 37.9698, 12.8347),
(40, 5, 'Trapani', 'A historic port city with salt pans and windmills. ~2 h from Palermo.', 38.0177, 12.5362),
(40, 5, 'Mount Etna', 'Europe''s tallest active volcano. ~3 h from Palermo.', 37.7506, 14.9937);
