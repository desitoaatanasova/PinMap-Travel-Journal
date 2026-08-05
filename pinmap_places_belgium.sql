-- PinMap Places Data - Belgium
-- Source: PinMap data updated.docx

-- ===== BRUSSELS =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@brussels_id, 1, 'Grand Place', 'Magnificent central square surrounded by ornate guildhalls and the Gothic town hall.', 50.8467, 4.3525),
(@brussels_id, 1, 'Brussels Town Hall', 'Stunning Gothic building dominating the Grand Place.', 50.8465, 4.3520),
(@brussels_id, 1, 'Royal Palace of Brussels', 'Official palace of the Belgian monarchy.', 50.8420, 4.3610),
(@brussels_id, 1, 'Manneken Pis', 'Famous small fountain statue that has become a symbol of the city.', 50.8450, 4.3500);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@brussels_id, 2, 'Royal Museums of Fine Arts of Belgium', 'Major museum complex with works from Flemish masters to modern art.', 50.8420, 4.3580),
(@brussels_id, 2, 'Magritte Museum', 'Dedicated to surrealist painter René Magritte.', 50.8420, 4.3580),
(@brussels_id, 2, 'Horta Museum', 'Former home of Art Nouveau architect Victor Horta.', 50.8270, 4.3550);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@brussels_id, 4, 'Galeries Royales Saint-Hubert', 'Elegant 19th-century glass-roofed shopping arcade.', 50.8480, 4.3540),
(@brussels_id, 4, 'Mont des Arts', 'Cultural complex with beautiful gardens and views of the city.', 50.8430, 4.3550),
(@brussels_id, 4, 'Notre-Dame du Sablon', 'Beautiful Gothic church in an elegant district.', 50.8400, 4.3560),
(@brussels_id, 4, 'Comic Book Murals', 'Comic book murals scattered throughout the city.', 50.8460, 4.3520);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@brussels_id, 3, 'Grand Place by Night', 'Wander around the illuminated Grand Place at night.', 50.8467, 4.3525),
(@brussels_id, 3, 'Chocolate & Waffles', 'Taste famous Belgian chocolate and waffles.', 50.8470, 4.3530),
(@brussels_id, 3, 'Belgian Cafés', 'Explore cafés serving traditional Belgian waffle and Belgian fries.', 50.8455, 4.3505),
(@brussels_id, 3, 'Art Nouveau Walk', 'Discover Art Nouveau buildings across the city.', 50.8300, 4.3600),
(@brussels_id, 3, 'Café Culture', 'Enjoy the lively café culture in historic squares.', 50.8460, 4.3510);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@brussels_id, 5, 'Bruges', 'Fairytale canal city of medieval gables. ~1 hr from Brussels.', 51.2093, 3.2247),
(@brussels_id, 5, 'Ghent', 'Vibrant canal city of medieval splendour. ~40 min from Brussels.', 51.0543, 3.7174),
(@brussels_id, 5, 'Antwerp', 'Port city of Rubens and fashion. ~45 min from Brussels.', 51.2194, 4.4025),
(@brussels_id, 5, 'Leuven', 'Lively university town with a famous town hall. ~25 min from Brussels.', 50.8798, 4.7005);

-- ===== BRUGES =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@bruges_id, 1, 'Market Square Bruges', 'The heart of the city, surrounded by colorful medieval guild houses.', 51.2085, 3.2240),
(@bruges_id, 1, 'Belfry of Bruges', 'Iconic medieval tower with panoramic views of the city.', 51.2080, 3.2245),
(@bruges_id, 1, 'Basilica of the Holy Blood', 'Historic chapel believed to house a relic of Christ''s blood.', 51.2075, 3.2260),
(@bruges_id, 1, 'Church of Our Lady Bruges', 'Gothic church housing a sculpture by Michelangelo.', 51.2040, 3.2240);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@bruges_id, 2, 'Groeningemuseum', 'Museum dedicated to Flemish art including works by Jan van Eyck.', 51.2055, 3.2270),
(@bruges_id, 2, 'Historium Bruges', 'Interactive museum about the city''s medieval history.', 51.2080, 3.2270),
(@bruges_id, 2, 'Sint-Janshospitaal', 'One of Europe''s oldest hospitals, now a museum.', 51.2030, 3.2220);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@bruges_id, 4, 'Beguinage Bruges', 'Peaceful historic complex once home to religious women.', 51.2010, 3.2230),
(@bruges_id, 4, 'Minnewater', 'Lake of Love, a romantic park and canal area.', 51.2000, 3.2260),
(@bruges_id, 4, 'Bonifacius Bridge', 'One of the most picturesque bridges in the city.', 51.2065, 3.2260),
(@bruges_id, 4, 'Quiet Canals', 'Quiet canals away from the main tourist areas.', 51.2070, 3.2200);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@bruges_id, 3, 'Canal Boat Ride', 'Take a boat ride along Bruges'' historic canals.', 51.2060, 3.2250),
(@bruges_id, 3, 'Cobbled Streets Sunset', 'Wander through medieval cobbled streets at sunset.', 51.2080, 3.2230),
(@bruges_id, 3, 'Chocolate & Beer', 'Taste famous Belgian chocolate and beer.', 51.2070, 3.2250),
(@bruges_id, 3, 'Lace Shops', 'Visit traditional lace shops and artisan boutiques.', 51.2065, 3.2220),
(@bruges_id, 3, 'Illuminated Canals', 'Enjoy the magical atmosphere of the illuminated canals at night.', 51.2060, 3.2260);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@bruges_id, 5, 'Ghent', 'Vibrant canal city of medieval splendour. ~30 min from Bruges.', 51.0543, 3.7174),
(@bruges_id, 5, 'Brussels', 'Capital of Europe, from squares to Art Nouveau. ~1 hr from Bruges.', 50.8503, 4.3517),
(@bruges_id, 5, 'Ostend', 'Seaside resort of the Belgian coast. ~15 min from Bruges.', 51.2154, 2.9280),
(@bruges_id, 5, 'Antwerp', 'Port city of Rubens and fashion. ~1 hr 30 min from Bruges.', 51.2194, 4.4025);

-- ===== GHENT =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@ghent_id, 1, 'Gravensteen', 'Impressive medieval castle in the city center built by the Counts of Flanders.', 51.0570, 3.7200),
(@ghent_id, 1, 'Saint Bavo''s Cathedral', 'Gothic cathedral famous for housing the masterpiece Ghent Altarpiece by Jan van Eyck.', 51.0530, 3.7270),
(@ghent_id, 1, 'Belfry of Ghent', 'Medieval bell tower symbolizing the city''s independence.', 51.0535, 3.7250),
(@ghent_id, 1, 'Saint Nicholas'' Church', 'One of the oldest and most prominent churches in the city.', 51.0540, 3.7230);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@ghent_id, 2, 'Museum of Fine Arts Ghent', 'Major museum with Flemish, Dutch, and European art.', 51.0380, 3.7250),
(@ghent_id, 2, 'Design Museum Gent', 'Museum dedicated to design history and contemporary design.', 51.0520, 3.7180),
(@ghent_id, 2, 'Ghent Festival', 'One of Europe''s largest cultural festivals with music, theatre, and street performances.', 51.0530, 3.7260);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@ghent_id, 4, 'Graslei', 'Historic quay lined with beautiful medieval guild houses.', 51.0550, 3.7210),
(@ghent_id, 4, 'Korenlei', 'Scenic canal-side street opposite Graslei.', 51.0550, 3.7200),
(@ghent_id, 4, 'Patershol', 'Charming medieval neighborhood with narrow streets and restaurants.', 51.0580, 3.7180),
(@ghent_id, 4, 'STAM Ghent City Museum', 'Museum exploring the city''s history.', 51.0430, 3.7300);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@ghent_id, 3, 'Canal Walk', 'Walk along the canals between Graslei and Korenlei.', 51.0550, 3.7210),
(@ghent_id, 3, 'Medieval Nights', 'Explore the atmospheric medieval streets at night.', 51.0560, 3.7220),
(@ghent_id, 3, 'Patershol Dining', 'Visit cafés and restaurants in the Patershol district.', 51.0580, 3.7180),
(@ghent_id, 3, 'Canal Boat Ride', 'Enjoy boat rides along the canals.', 51.0545, 3.7220),
(@ghent_id, 3, 'Student Culture', 'Experience the lively student culture around the university.', 51.0470, 3.7260);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@ghent_id, 5, 'Bruges', 'Fairytale canal city of medieval gables. ~30 min from Ghent.', 51.2093, 3.2247),
(@ghent_id, 5, 'Brussels', 'Capital of Europe, from squares to Art Nouveau. ~40 min from Ghent.', 50.8503, 4.3517),
(@ghent_id, 5, 'Antwerp', 'Port city of Rubens and fashion. ~1 hr from Ghent.', 51.2194, 4.4025),
(@ghent_id, 5, 'Ostend', 'Seaside resort of the Belgian coast. ~50 min from Ghent.', 51.2154, 2.9280);

-- ===== ANTWERP =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@antwerp_id, 1, 'Cathedral of Our Lady Antwerp', 'The largest Gothic church in Belgium, housing several masterpieces by Peter Paul Rubens.', 51.2205, 4.4010),
(@antwerp_id, 1, 'Grote Markt Antwerp', 'Beautiful central square surrounded by ornate guild houses.', 51.2210, 4.3990),
(@antwerp_id, 1, 'Antwerp City Hall', 'Elegant Renaissance building overlooking the Grote Markt.', 51.2215, 4.3990),
(@antwerp_id, 1, 'Het Steen', 'Medieval fortress on the banks of the Scheldt River.', 51.2220, 4.3970);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@antwerp_id, 2, 'Rubenshuis', 'Former home and studio of Peter Paul Rubens.', 51.2180, 4.4100),
(@antwerp_id, 2, 'Royal Museum of Fine Arts Antwerp', 'Major art museum with Flemish and European masterpieces.', 51.2080, 4.3960),
(@antwerp_id, 2, 'Museum aan de Stroom', 'Modern museum exploring the city''s maritime and global history.', 51.2280, 4.4040),
(@antwerp_id, 2, 'Antwerp Fashion', 'Antwerp is also internationally known for its fashion scene and the famous Antwerp Six designers.', 51.2160, 4.4060);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@antwerp_id, 4, 'Plantin-Moretus Museum', 'UNESCO-listed printing house preserving early printing history.', 51.2190, 4.3980),
(@antwerp_id, 4, 'Vlaeykensgang', 'Hidden medieval alleyway in the city center.', 51.2190, 4.4020),
(@antwerp_id, 4, 'St Charles Borromeo Church', 'Beautiful Baroque church once decorated by Rubens.', 51.2170, 4.4050),
(@antwerp_id, 4, 'Old Town Streets', 'Quiet streets in the historic old town near the cathedral.', 51.2210, 4.4020);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@antwerp_id, 3, 'Scheldt Waterfront', 'Walk along the Scheldt River waterfront.', 51.2230, 4.3940),
(@antwerp_id, 3, 'Fashion Boutiques', 'Explore Antwerp''s fashion boutiques and design stores.', 51.2160, 4.4060),
(@antwerp_id, 3, 'Belgian Cafés', 'Visit traditional Belgian cafés and chocolate shops.', 51.2200, 4.4000),
(@antwerp_id, 3, 'MAS Rooftop', 'Enjoy panoramic views from the rooftop of the MAS museum.', 51.2280, 4.4040),
(@antwerp_id, 3, 'Historic Squares', 'Wander through lively squares filled with historic buildings.', 51.2210, 4.3990);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@antwerp_id, 5, 'Brussels', 'Capital of Europe, from squares to Art Nouveau. ~45 min from Antwerp.', 50.8503, 4.3517),
(@antwerp_id, 5, 'Ghent', 'Vibrant canal city of medieval splendour. ~1 hr from Antwerp.', 51.0543, 3.7174),
(@antwerp_id, 5, 'Bruges', 'Fairytale canal city of medieval gables. ~1 hr 30 min from Antwerp.', 51.2093, 3.2247),
(@antwerp_id, 5, 'Rotterdam', 'Daring modern port city of the Netherlands. ~1 hr from Antwerp.', 51.9244, 4.4777);

-- ===== LEUVEN =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@leuven_id, 1, 'Leuven Town Hall', 'One of the most beautiful Gothic town halls in Europe, covered with intricate sculptures.', 50.8790, 4.7010),
(@leuven_id, 1, 'St Peter''s Church Leuven', 'Historic church on the Grote Markt with important Flemish artworks.', 50.8780, 4.7000),
(@leuven_id, 1, 'KU Leuven', 'Founded in 1425, one of Europe''s oldest and most prestigious universities.', 50.8780, 4.7050),
(@leuven_id, 1, 'Great Beguinage Leuven', 'UNESCO-listed historic quarter once inhabited by beguines.', 50.8710, 4.6980);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@leuven_id, 2, 'M Leuven', 'Modern museum with collections of Flemish and contemporary art.', 50.8770, 4.7000),
(@leuven_id, 2, 'University Library and Tower Leuven', 'Monumental library rebuilt after both world wars.', 50.8770, 4.7060),
(@leuven_id, 2, 'Park Abbey', 'Beautiful Norbertine abbey complex with historic buildings and art.', 50.8590, 4.7170);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@leuven_id, 4, 'Oude Markt', 'Famous square known as the longest bar in the world due to its many cafés.', 50.8795, 4.6980),
(@leuven_id, 4, 'Kruidtuin', 'Belgium''s oldest botanical garden.', 50.8750, 4.7070),
(@leuven_id, 4, 'Arenberg Castle', 'Elegant castle surrounded by parkland.', 50.8640, 4.6820),
(@leuven_id, 4, 'Beguinage Streets', 'Quiet streets in the Beguinage district with medieval houses and canals.', 50.8710, 4.6980);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@leuven_id, 3, 'Student Vibe', 'Explore the lively student atmosphere around the university.', 50.8780, 4.7050),
(@leuven_id, 3, 'Belgian Breweries', 'Visit traditional Belgian breweries and taste local beers.', 50.8790, 4.6990),
(@leuven_id, 3, 'Beguinage Gardens', 'Walk through the peaceful gardens of the Great Beguinage.', 50.8710, 4.6980),
(@leuven_id, 3, 'Oude Markt Cafés', 'Enjoy cafés and restaurants around the Oude Markt.', 50.8795, 4.6980),
(@leuven_id, 3, 'Gothic Detail', 'Admire the detailed sculpture of Leuven''s Gothic architecture.', 50.8790, 4.7010);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@leuven_id, 5, 'Brussels', 'Capital of Europe, from squares to Art Nouveau. ~25 min from Leuven.', 50.8503, 4.3517),
(@leuven_id, 5, 'Antwerp', 'Port city of Rubens and fashion. ~50 min from Leuven.', 51.2194, 4.4025),
(@leuven_id, 5, 'Mechelen', 'Historic city of carillons and towers. ~25 min from Leuven.', 51.0259, 4.4770),
(@leuven_id, 5, 'Ghent', 'Vibrant canal city of medieval splendour. ~1 hr from Leuven.', 51.0543, 3.7174);
