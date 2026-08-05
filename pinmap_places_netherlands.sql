-- PinMap Places Data - The Netherlands
-- Source: PinMap data updated.docx

-- ===== AMSTERDAM =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@amsterdam_id, 1, 'Dam Square', 'Historic central square and traditional heart of the city.', 52.3730, 4.8930),
(@amsterdam_id, 1, 'Royal Palace of Amsterdam', 'Grand 17th-century palace originally built as the city hall.', 52.3730, 4.8910),
(@amsterdam_id, 1, 'Westerkerk', 'Beautiful Protestant church near the canal district.', 52.3740, 4.8840),
(@amsterdam_id, 1, 'Anne Frank House', 'Historic house where Anne Frank hid during World War II.', 52.3752, 4.8840);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@amsterdam_id, 2, 'Rijksmuseum', 'The Netherlands'' national museum with masterpieces by Rembrandt and Johannes Vermeer.', 52.3600, 4.8850),
(@amsterdam_id, 2, 'Van Gogh Museum', 'Dedicated to the works of Vincent van Gogh.', 52.3584, 4.8810),
(@amsterdam_id, 2, 'Stedelijk Museum Amsterdam', 'Museum of modern and contemporary art.', 52.3580, 4.8800),
(@amsterdam_id, 2, 'Rembrandt House Museum', 'Former home of Rembrandt.', 52.3690, 4.9010);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@amsterdam_id, 4, 'Begijnhof', 'Quiet historic courtyard hidden behind the busy streets.', 52.3680, 4.8900),
(@amsterdam_id, 4, 'Negen Straatjes', 'Charming district of nine narrow streets with boutiques and cafés.', 52.3690, 4.8870),
(@amsterdam_id, 4, 'Our Lord in the Attic Museum', 'Secret Catholic church hidden inside a canal house.', 52.3730, 4.8990),
(@amsterdam_id, 4, 'Jordaan', 'Atmospheric historic neighborhood with canals and galleries.', 52.3720, 4.8840);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@amsterdam_id, 3, 'Canal Cruise', 'Take a boat cruise through the historic canals.', 52.3670, 4.9000),
(@amsterdam_id, 3, 'Cycling the Streets', 'Cycle along Amsterdam''s scenic streets and bridges.', 52.3690, 4.8900),
(@amsterdam_id, 3, 'Canal Ring', 'Explore the famous Canal Ring.', 52.3660, 4.8860),
(@amsterdam_id, 3, 'Markets & Cafés', 'Visit lively markets and cafés throughout the city.', 52.3700, 4.8950),
(@amsterdam_id, 3, 'Historic Charm', 'Experience the unique blend of historic charm and modern creativity.', 52.3710, 4.8920);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@amsterdam_id, 5, 'Keukenhof', 'World-famous spring flower garden. ~40-50 min from Amsterdam.', 52.2690, 4.5460),
(@amsterdam_id, 5, 'Utrecht', 'Medieval canal city of the Dom Tower. ~25 min from Amsterdam.', 52.0907, 5.1214),
(@amsterdam_id, 5, 'Rotterdam', 'Daring modern port city. ~40 min from Amsterdam.', 51.9244, 4.4777),
(@amsterdam_id, 5, 'The Hague', 'Seat of the Dutch government and courts. ~50 min from Amsterdam.', 52.0705, 4.3007);

-- ===== ROTTERDAM =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@rotterdam_id, 1, 'Delfshaven', 'One of the few historic districts that survived WWII, with canals and old houses.', 51.9060, 4.4520),
(@rotterdam_id, 1, 'St Lawrence Church Rotterdam', 'The only remaining medieval building in the city center.', 51.9200, 4.4850),
(@rotterdam_id, 1, 'Hotel New York', 'Former headquarters of the Holland America Line shipping company.', 51.9030, 4.4840);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@rotterdam_id, 2, 'Museum Boijmans Van Beuningen', 'Major museum with works from medieval art to modern masters.', 51.9140, 4.4730),
(@rotterdam_id, 2, 'Depot Boijmans Van Beuningen', 'The world''s first publicly accessible art storage facility.', 51.9140, 4.4730),
(@rotterdam_id, 2, 'Kunsthal Rotterdam', 'Museum hosting diverse temporary exhibitions.', 51.9100, 4.4730),
(@rotterdam_id, 2, 'Witte de With Center for Contemporary Art', 'Influential contemporary art center.', 51.9150, 4.4780);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@rotterdam_id, 4, 'Markthal', 'Striking indoor food market with a colorful ceiling mural.', 51.9200, 4.4870),
(@rotterdam_id, 4, 'Cube Houses', 'Iconic tilted cube-shaped residential buildings.', 51.9200, 4.4900),
(@rotterdam_id, 4, 'Het Park', 'Peaceful park near the river with views of the skyline.', 51.9100, 4.4650),
(@rotterdam_id, 4, 'Euromast', 'Observation tower offering panoramic city views.', 51.9050, 4.4660);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@rotterdam_id, 3, 'Maas Waterfront', 'Walk along the Maas River waterfront.', 51.9170, 4.4800),
(@rotterdam_id, 3, 'Modern Architecture', 'Explore innovative modern architecture throughout the city.', 51.9230, 4.4810),
(@rotterdam_id, 3, 'Food Halls', 'Visit lively food halls and international restaurants.', 51.9200, 4.4870),
(@rotterdam_id, 3, 'Harbor Boat Tour', 'Take a harbor boat tour of Europe''s largest port.', 51.9050, 4.4600),
(@rotterdam_id, 3, 'Creative Atmosphere', 'Enjoy Rotterdam''s creative and multicultural atmosphere.', 51.9150, 4.4790);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@rotterdam_id, 5, 'The Hague', 'Seat of the Dutch government and courts. ~25 min from Rotterdam.', 52.0705, 4.3007),
(@rotterdam_id, 5, 'Delft', 'Canal town of Delft Blue pottery. ~15 min from Rotterdam.', 52.0116, 4.3571),
(@rotterdam_id, 5, 'Amsterdam', 'The canal-ringed Dutch capital. ~40 min from Rotterdam.', 52.3676, 4.9041),
(@rotterdam_id, 5, 'Utrecht', 'Medieval canal city of the Dom Tower. ~40 min from Rotterdam.', 52.0907, 5.1214);

-- ===== THE HAGUE =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@hague_id, 1, 'Binnenhof', 'Historic parliamentary complex and one of the oldest government centers in Europe still in use.', 52.0790, 4.3130),
(@hague_id, 1, 'Ridderzaal', 'Medieval Great Hall inside the Binnenhof, used for royal ceremonies.', 52.0790, 4.3130),
(@hague_id, 1, 'Noordeinde Palace', 'Working palace of the Dutch king.', 52.0830, 4.3060),
(@hague_id, 1, 'Peace Palace', 'Iconic building housing the International Court of Justice.', 52.0870, 4.2950);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@hague_id, 2, 'Mauritshuis', 'One of Europe''s finest art museums, featuring masterpieces by Johannes Vermeer and Rembrandt.', 52.0800, 4.3140),
(@hague_id, 2, 'Kunstmuseum Den Haag', 'Museum known for its collection of modern art, including works by Piet Mondrian.', 52.0900, 4.2790),
(@hague_id, 2, 'Escher in The Palace', 'Museum dedicated to M. C. Escher in a former royal palace.', 52.0820, 4.3100);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@hague_id, 4, 'Paleistuin', 'Quiet palace garden behind Noordeinde Palace.', 52.0830, 4.3040),
(@hague_id, 4, 'Hofvijver', 'Beautiful lake beside the Binnenhof, especially atmospheric in the evening.', 52.0790, 4.3130),
(@hague_id, 4, 'Lange Voorhout', 'Elegant tree-lined avenue with galleries and seasonal markets.', 52.0830, 4.3110),
(@hague_id, 4, 'Haagse Passage', 'Historic shopping arcade with a classic European atmosphere.', 52.0780, 4.3100);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@hague_id, 3, 'Diplomatic Quarter', 'Walk through the elegant diplomatic quarter around the Binnenhof.', 52.0790, 4.3130),
(@hague_id, 3, 'Cafés & Galleries', 'Enjoy refined cafés and art galleries in the city center.', 52.0810, 4.3090),
(@hague_id, 3, 'Scheveningen Beach', 'Visit the beach district of Scheveningen for sea views and sunsets.', 52.1110, 4.2820),
(@hague_id, 3, 'Royal Streets', 'Explore royal streets and parks with a calm, sophisticated atmosphere.', 52.0830, 4.3050),
(@hague_id, 3, 'Museums & Sea', 'Combine museums with seaside relaxation - something unique to The Hague.', 52.0840, 4.2970);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@hague_id, 5, 'Scheveningen', 'The Hague''s lively seaside resort. ~15 min away.', 52.1110, 4.2820),
(@hague_id, 5, 'Delft', 'Canal town of Delft Blue pottery. ~15 min from The Hague.', 52.0116, 4.3571),
(@hague_id, 5, 'Leiden', 'Historic university town of canals. ~15 min from The Hague.', 52.1614, 4.4900),
(@hague_id, 5, 'Amsterdam', 'The canal-ringed Dutch capital. ~50 min from The Hague.', 52.3676, 4.9041);

-- ===== UTRECHT =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@utrecht_id, 1, 'Dom Tower', 'The tallest church tower in the Netherlands and the symbol of the city.', 52.0900, 5.1210),
(@utrecht_id, 1, 'Dom Church Utrecht', 'Gothic cathedral with a dramatic open courtyard after its nave collapsed in the 17th century.', 52.0900, 5.1210),
(@utrecht_id, 1, 'Oudegracht', 'Utrecht''s most famous canal, lined with historic houses and wharf cellars.', 52.0930, 5.1170),
(@utrecht_id, 1, 'St Martin''s Cathedral Utrecht', 'One of the most important religious buildings in Dutch history.', 52.0900, 5.1210);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@utrecht_id, 2, 'Centraal Museum', 'Museum featuring Dutch art, modern design, and the Utrecht Caravaggists.', 52.0830, 5.1260),
(@utrecht_id, 2, 'Museum Speelklok', 'Unique museum of musical clocks and self-playing instruments.', 52.0910, 5.1220),
(@utrecht_id, 2, 'Utrecht University', 'One of Europe''s leading universities, giving the city its intellectual atmosphere.', 52.0890, 5.1140),
(@utrecht_id, 2, 'Rietveld Schröder House', 'UNESCO-listed modernist house designed by Gerrit Rietveld.', 52.0860, 5.1470);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@utrecht_id, 4, 'De Haar Castle', 'Fairytale castle near Utrecht, surrounded by gardens.', 52.1210, 4.9870),
(@utrecht_id, 4, 'Pandhof van de Dom', 'Peaceful cloister garden hidden beside the cathedral.', 52.0900, 5.1210),
(@utrecht_id, 4, 'Twijnstraat', 'One of the oldest streets in the city, full of small shops and cafés.', 52.0890, 5.1240),
(@utrecht_id, 4, 'Wharf Terraces', 'Wharf-level terraces along the Oudegracht canal.', 52.0930, 5.1170);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@utrecht_id, 3, 'Canal Cafés', 'Sit at canal cafés on the wharf level (unique to Utrecht).', 52.0930, 5.1170),
(@utrecht_id, 3, 'Dom Tower Climb', 'Climb the Dom Tower for panoramic city views.', 52.0900, 5.1210),
(@utrecht_id, 3, 'Cathedral Quarter', 'Wander medieval streets around the cathedral quarter.', 52.0905, 5.1210),
(@utrecht_id, 3, 'Bookstores & Cafés', 'Explore bookstores and cafés in the student districts.', 52.0910, 5.1250),
(@utrecht_id, 3, 'Evening Canal Walk', 'Take an evening canal walk when the bridges and buildings are softly lit.', 52.0920, 5.1180);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@utrecht_id, 5, 'De Haar Castle', 'Fairytale moated castle with gardens. ~30-40 min from Utrecht.', 52.1210, 4.9870),
(@utrecht_id, 5, 'Amsterdam', 'The canal-ringed Dutch capital. ~25 min from Utrecht.', 52.3676, 4.9041),
(@utrecht_id, 5, 'The Hague', 'Seat of the Dutch government and courts. ~40 min from Utrecht.', 52.0705, 4.3007),
(@utrecht_id, 5, 'Rotterdam', 'Daring modern port city. ~40 min from Utrecht.', 51.9244, 4.4777);

-- ===== DELFT =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@delft_id, 1, 'Nieuwe Kerk', 'Impressive Gothic church where members of the Dutch royal family are buried.', 52.0120, 4.3610),
(@delft_id, 1, 'Oude Kerk', 'The city''s famous leaning church and the burial place of Johannes Vermeer.', 52.0110, 4.3560),
(@delft_id, 1, 'Stadhuis Delft', 'Beautiful Renaissance city hall overlooking the central square.', 52.0110, 4.3580),
(@delft_id, 1, 'Prinsenhof Museum', 'Historic residence of William the Silent.', 52.0120, 4.3580);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@delft_id, 2, 'Royal Delft', 'The last remaining factory producing the world-famous Delft Blue pottery.', 52.0060, 4.3470),
(@delft_id, 2, 'Vermeer Centrum Delft', 'Museum dedicated to the life and work of Johannes Vermeer.', 52.0110, 4.3570),
(@delft_id, 2, 'Delft University of Technology', 'One of Europe''s leading technical universities.', 52.0040, 4.3710);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@delft_id, 4, 'Oude Delft', 'The oldest canal in the city and one of the most beautiful places for an evening walk.', 52.0120, 4.3550),
(@delft_id, 4, 'De Roos Windmill', 'Historic windmill dating back to the eighteenth century.', 52.0090, 4.3670),
(@delft_id, 4, 'Beestenmarkt', 'Charming square lined with cafés and trees.', 52.0110, 4.3620),
(@delft_id, 4, 'Old Town Courtyards', 'The quiet courtyards and narrow streets surrounding the old town center.', 52.0120, 4.3600);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@delft_id, 3, 'Canal Sunset', 'Take a walk along the canals at sunset.', 52.0110, 4.3550),
(@delft_id, 3, 'Dutch Sweets', 'Taste traditional Dutch sweets such as stroopwafels and poffertjes.', 52.0115, 4.3580),
(@delft_id, 3, 'Markets & Boutiques', 'Explore the city''s markets, boutiques, and cafés.', 52.0110, 4.3590),
(@delft_id, 3, 'Medieval & Modern', 'Discover the beautiful contrast between medieval architecture and modern innovation.', 52.0070, 4.3680),
(@delft_id, 3, 'Cycle Like a Local', 'Rent a bicycle and experience the city like a local.', 52.0115, 4.3600);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@delft_id, 5, 'The Hague', 'Seat of the Dutch government and courts. ~15 min from Delft.', 52.0705, 4.3007),
(@delft_id, 5, 'Rotterdam', 'Daring modern port city. ~15 min from Delft.', 51.9244, 4.4777),
(@delft_id, 5, 'Leiden', 'Historic university town of canals. ~20 min from Delft.', 52.1614, 4.4900),
(@delft_id, 5, 'Amsterdam', 'The canal-ringed Dutch capital. ~1 h from Delft.', 52.3676, 4.9041);
