-- PinMap Places Data - Portugal (new cities)
-- Source: PinMap data updated.docx

-- ===== CASCAIS =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@cascais_id, 1, 'Cascais Citadel', 'Historic fortress complex that once protected the harbor and later became a royal residence.', 38.6938, -9.4180),
(@cascais_id, 1, 'Nossa Senhora da Assunção Church', 'Traditional parish church in the historic center.', 38.6965, -9.4215),
(@cascais_id, 1, 'Santa Marta Lighthouse', 'Striking lighthouse next to a small coastal museum.', 38.6910, -9.4130),
(@cascais_id, 1, 'Palace of the Counts of Castro Guimarães', 'Romantic seaside mansion surrounded by gardens.', 38.6960, -9.4155);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@cascais_id, 2, 'Casa das Histórias Paula Rego', 'Museum dedicated to Portuguese painter Paula Rego.', 38.6990, -9.4240),
(@cascais_id, 2, 'Cascais Cultural Center', 'Exhibitions, art events, and cultural programs.', 38.6980, -9.4210),
(@cascais_id, 2, 'Museu Condes de Castro Guimarães', 'Art and historic collections inside the palace.', 38.6960, -9.4155);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@cascais_id, 4, 'Boca do Inferno', 'Dramatic coastal rock arch where waves crash into a sea cave.', 38.6920, -9.4380),
(@cascais_id, 4, 'Cascais Marina', 'Colorful marina with restaurants and ocean views.', 38.6935, -9.4150),
(@cascais_id, 4, 'Parque Marechal Carmona', 'Peaceful park with ponds and peacocks.', 38.6975, -9.4200),
(@cascais_id, 4, 'Fishermen''s Quarter', 'Quiet streets of the historic fishermen''s quarter near the harbor.', 38.6950, -9.4165);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@cascais_id, 3, 'Seaside Promenade', 'Walk along the seaside promenade connecting Cascais to nearby Estoril.', 38.6955, -9.4080),
(@cascais_id, 3, 'Beaches of Cascais', 'Relax on beaches such as Praia da Rainha or Praia da Conceição.', 38.6945, -9.4140),
(@cascais_id, 3, 'Atlantic Sunsets', 'Sunset views over the Atlantic Ocean.', 38.6925, -9.4270),
(@cascais_id, 3, 'Seafood by the Harbor', 'Fresh seafood dining near the harbor.', 38.6930, -9.4155),
(@cascais_id, 3, 'Coastal Ride to Guincho', 'Cycling along the coastal road toward Guincho.', 38.7270, -9.4720);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@cascais_id, 5, 'Lisbon', 'Portugal''s capital on the Tagus. ~40 min from Cascais.', 38.7223, -9.1393),
(@cascais_id, 5, 'Sintra', 'Fairytale palaces and forested hills. ~35-40 min from Cascais.', 38.8029, -9.3817),
(@cascais_id, 5, 'Praia do Guincho', 'Wild Atlantic beach beloved by surfers. ~15 min from Cascais.', 38.7310, -9.4720),
(@cascais_id, 5, 'Cabo da Roca', 'The westernmost point of mainland Europe. ~40 min from Cascais.', 38.7806, -9.5000);

-- ===== FARO =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@faro_id, 1, 'Arco da Vila', 'Elegant 19th-century gateway leading into Faro''s historic center.', 37.0150, -7.9355),
(@faro_id, 1, 'Faro Cathedral', 'Cathedral located in the old town square with a tower offering panoramic views.', 37.0130, -7.9340),
(@faro_id, 1, 'Faro Old Town', 'Walled medieval district with cobbled streets and historic houses.', 37.0140, -7.9350),
(@faro_id, 1, 'Carmo Church', 'Baroque church famous for its chapel made of human bones.', 37.0200, -7.9310);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@faro_id, 2, 'Faro Municipal Museum', 'Archaeological and artistic collections in a former convent.', 37.0145, -7.9350),
(@faro_id, 2, 'University of Algarve', 'Cultural and academic center that hosts exhibitions and events.', 37.0570, -7.9290),
(@faro_id, 2, 'Old Town Galleries', 'Small galleries and artisan shops inside the old town walls.', 37.0135, -7.9345);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@faro_id, 4, 'Capela dos Ossos', 'Small but striking chapel decorated with skulls and bones.', 37.0200, -7.9310),
(@faro_id, 4, 'Faro Marina', 'Colorful waterfront lined with cafés and boats.', 37.0155, -7.9260),
(@faro_id, 4, 'Cidade Velha Streets', 'Quiet streets inside the medieval walls of Cidade Velha.', 37.0140, -7.9330),
(@faro_id, 4, 'Ria Formosa Bird-watching', 'Bird-watching spots in the surrounding lagoons.', 37.0000, -7.9300);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@faro_id, 3, 'Marina Sunset Walk', 'Walk along the marina at sunset.', 37.0155, -7.9260),
(@faro_id, 3, 'Ria Formosa Boat Trip', 'Boat trips through the lagoons of Ria Formosa Natural Park.', 37.0000, -7.9400),
(@faro_id, 3, 'Island Beaches', 'Explore island beaches with white sand and clear water.', 36.9770, -7.9400),
(@faro_id, 3, 'Algarve Seafood', 'Try fresh seafood and traditional Algarve cuisine.', 37.0145, -7.9270),
(@faro_id, 3, 'Evenings in the Old Town', 'Enjoy relaxed evenings in the historic center.', 37.0140, -7.9340);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@faro_id, 5, 'Ilha Deserta', 'Wild deserted island at the mouth of Ria Formosa. ~45 min from Faro.', 36.9630, -7.8890),
(@faro_id, 5, 'Ilha da Culatra', 'Lively island village with a working fishing community. ~35-40 min from Faro.', 36.9940, -7.8400),
(@faro_id, 5, 'Ilha do Farol', 'Island of sand and dunes with a charming village. ~30 min from Faro.', 36.9820, -7.8550),
(@faro_id, 5, 'Lagos', 'Historic western Algarve town of cliffs and coves. ~1 hr 30 min from Faro.', 37.1020, -8.6720),
(@faro_id, 5, 'Albufeira', 'Busy resort town with a picture-postcard old centre. ~40 min from Faro.', 37.0890, -8.2460),
(@faro_id, 5, 'Tavira', 'Elegant Algarve town of Moorish charm and Roman bridges. ~40 min from Faro.', 37.1260, -7.6490);

-- ===== COIMBRA =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@coimbra_id, 1, 'University of Coimbra', 'One of Europe''s oldest universities, founded in 1290 and a UNESCO World Heritage site.', 40.2077, -8.4260),
(@coimbra_id, 1, 'Joanina Library', 'Spectacular Baroque library with gilded interiors and historic manuscripts.', 40.2070, -8.4265),
(@coimbra_id, 1, 'Coimbra Cathedral', 'A powerful Romanesque cathedral from the 12th century.', 40.2090, -8.4290),
(@coimbra_id, 1, 'New Cathedral of Coimbra', 'A former Jesuit church with grand Renaissance architecture.', 40.2095, -8.4260),
(@coimbra_id, 1, 'Monastery of Santa Cruz', 'Important royal monastery where early Portuguese kings are buried.', 40.2110, -8.4290);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@coimbra_id, 2, 'Machado de Castro National Museum', 'Major museum built above a Roman cryptoporticus.', 40.2085, -8.4275),
(@coimbra_id, 2, 'Science Museum of the University of Coimbra', 'Exhibits connected to the university''s scientific heritage.', 40.2070, -8.4280),
(@coimbra_id, 2, 'Fado de Coimbra', 'Traditional academic music sung by university students.', 40.2070, -8.4250);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@coimbra_id, 4, 'Quinta das Lágrimas', 'Romantic gardens tied to the tragic love story of Pedro I of Portugal and Inês de Castro.', 40.1950, -8.4230),
(@coimbra_id, 4, 'Portugal dos Pequenitos', 'Miniature architectural park featuring Portuguese monuments.', 40.1980, -8.4340),
(@coimbra_id, 4, 'Mondego Riverside Walks', 'Riverside walks along the Mondego River.', 40.2035, -8.4140),
(@coimbra_id, 4, 'Upper Town Viewpoints', 'Quiet stairways and viewpoints in the medieval upper town.', 40.2060, -8.4270);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@coimbra_id, 3, 'University Hill', 'Explore the historic university hill and its panoramic terraces.', 40.2075, -8.4255),
(@coimbra_id, 3, 'Evening Fado', 'Listen to evening performances of Coimbra-style fado.', 40.2080, -8.4290),
(@coimbra_id, 3, 'Medieval Quarter Walk', 'Walk through medieval streets connecting the university to the riverfront.', 40.2050, -8.4200),
(@coimbra_id, 3, 'Praça 8 de Maio', 'Enjoy cafés and traditional pastry shops around Praça 8 de Maio.', 40.2125, -8.4290),
(@coimbra_id, 3, 'Mondego Sunset', 'Watch sunset views over the Mondego River.', 40.2030, -8.4120);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@coimbra_id, 5, 'Aveiro', 'Canal town of moliceiro boats and Art Nouveau. ~1 hr from Coimbra.', 40.6405, -8.6538),
(@coimbra_id, 5, 'Tomar', 'Historic home of the Knights Templar. ~1 hr 15 min from Coimbra.', 39.6040, -8.4090),
(@coimbra_id, 5, 'Serra da Lousã', 'Green mountain range of schist villages and waterfalls. ~40 min from Coimbra.', 40.1000, -8.2500),
(@coimbra_id, 5, 'Porto', 'Riverside city of port wine and azulejos. ~1 hr 15 min from Coimbra.', 41.1579, -8.6291);

-- ===== ÓBIDOS =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@obidos_id, 1, 'Óbidos Castle', 'Impressive medieval castle dominating the town, now a historic hotel.', 39.3625, -9.1570),
(@obidos_id, 1, 'Town Walls of Óbidos', 'Walkable medieval walls offering panoramic views over the town and countryside.', 39.3615, -9.1585),
(@obidos_id, 1, 'Church of Santa Maria', 'Main church of the town with Renaissance paintings.', 39.3630, -9.1570),
(@obidos_id, 1, 'Sanctuary of Senhor Jesus da Pedra', 'Unique hexagonal Baroque sanctuary just outside the walls.', 39.3560, -9.1510);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@obidos_id, 2, 'Óbidos International Chocolate Festival', 'Annual festival celebrating chocolate with sculptures and tastings.', 39.3625, -9.1575),
(@obidos_id, 2, 'FOLIO Literary Festival', 'International Literary Festival of Óbidos - one of Portugal''s most important literary festivals.', 39.3630, -9.1570),
(@obidos_id, 2, 'Livraria de Santiago', 'A bookstore located inside a former church.', 39.3635, -9.1580),
(@obidos_id, 2, 'Artisan Shops', 'Many small artisan shops selling ceramics, embroidery, and local crafts.', 39.3620, -9.1565);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@obidos_id, 4, 'Ginjinha', 'Traditional cherry liqueur served in small chocolate cups in Óbidos.', 39.3620, -9.1570),
(@obidos_id, 4, 'Medieval Alleys', 'Narrow medieval alleys filled with bougainvillea and colorful houses.', 39.3628, -9.1568),
(@obidos_id, 4, 'Town Wall Viewpoints', 'Quiet viewpoints along the town walls.', 39.3610, -9.1580),
(@obidos_id, 4, 'Hidden Courtyards', 'Small gardens and hidden courtyards inside the old town.', 39.3630, -9.1560);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@obidos_id, 3, 'Medieval Wall Circuit', 'Walk along the entire medieval wall circuit around the town.', 39.3615, -9.1585),
(@obidos_id, 3, 'Cobbled Streets', 'Explore cobbled streets filled with flowers and artisan shops.', 39.3625, -9.1570),
(@obidos_id, 3, 'Ginjinha Tasting', 'Taste ginjinha in traditional taverns.', 39.3622, -9.1565),
(@obidos_id, 3, 'Festival Visits', 'Visit during festivals when the town becomes a medieval or literary stage.', 39.3625, -9.1575),
(@obidos_id, 3, 'Countryside Sunset', 'Enjoy sunset views over the surrounding countryside.', 39.3600, -9.1600);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@obidos_id, 5, 'Nazaré', 'Coastal town famous for giant waves. ~40 min from Óbidos.', 39.6010, -9.0700),
(@obidos_id, 5, 'Peniche', 'Surfing stronghold on a rocky peninsula. ~30 min from Óbidos.', 39.3530, -9.3800),
(@obidos_id, 5, 'Lisbon', 'Portugal''s capital on the Tagus. ~1 hr from Óbidos.', 38.7223, -9.1393),
(@obidos_id, 5, 'Óbidos Lagoon', 'Calm lagoon of sandbanks and birdlife. ~20 min from Óbidos.', 39.4000, -9.2500);

-- ===== AVEIRO =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@aveiro_id, 1, 'Aveiro Cathedral', 'Historic cathedral originally part of a Dominican convent.', 40.6400, -8.6540),
(@aveiro_id, 1, 'Aveiro Train Station', 'Famous for its beautiful blue-and-white azulejo tile panels depicting Portuguese life.', 40.6440, -8.6450),
(@aveiro_id, 1, 'Convento de Jesus', 'Historic convent housing the city museum and the tomb of Joana, Princess of Portugal.', 40.6410, -8.6550),
(@aveiro_id, 1, 'Canals of Aveiro', 'Network of canals running through the city center.', 40.6425, -8.6510);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@aveiro_id, 2, 'Aveiro Museum', 'Museum showcasing religious art and local history.', 40.6410, -8.6550),
(@aveiro_id, 2, 'Casa de Santa Zita', 'Example of the city''s elegant Art Nouveau architecture.', 40.6380, -8.6500),
(@aveiro_id, 2, 'Aveiro Art Nouveau Museum', 'Dedicated to the city''s distinctive architectural style.', 40.6395, -8.6530);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@aveiro_id, 4, 'Moliceiro', 'Colorful boats traditionally used for harvesting seaweed, now offering canal tours.', 40.6420, -8.6490),
(@aveiro_id, 4, 'Ovos Moles', 'Famous Aveiro dessert made of egg yolks and sugar in delicate wafer shells.', 40.6415, -8.6520),
(@aveiro_id, 4, 'Pedestrian Streets', 'Small pedestrian streets filled with cafés and bakeries.', 40.6400, -8.6510),
(@aveiro_id, 4, 'Canal Bridges', 'Bridges crossing the canals with picturesque views.', 40.6420, -8.6500);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@aveiro_id, 3, 'Moliceiro Boat Ride', 'Take a moliceiro boat ride along the canals.', 40.6420, -8.6490),
(@aveiro_id, 3, 'Art Nouveau Walk', 'Walk through neighborhoods filled with Art Nouveau buildings.', 40.6390, -8.6520),
(@aveiro_id, 3, 'Cafés by the Water', 'Enjoy cafés and pastry shops by the water.', 40.6410, -8.6500),
(@aveiro_id, 3, 'Fish Market', 'Visit the fish market and local seafood restaurants.', 40.6430, -8.6470),
(@aveiro_id, 3, 'Waterfront Sunset', 'Explore the relaxed waterfront at sunset.', 40.6425, -8.6480);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@aveiro_id, 5, 'Costa Nova', 'Beach town of striped fisherman houses. ~20 min from Aveiro.', 40.6140, -8.7510),
(@aveiro_id, 5, 'Barra Beach', 'Wide Atlantic beach with a red lighthouse. ~15 min from Aveiro.', 40.6400, -8.7460),
(@aveiro_id, 5, 'Porto', 'Riverside city of port wine and azulejos. ~1 hr from Aveiro.', 41.1579, -8.6291),
(@aveiro_id, 5, 'Coimbra', 'Historic university city on the Mondego. ~1 hr from Aveiro.', 40.2033, -8.4103),
(@aveiro_id, 5, 'Ria de Aveiro', 'Coastal lagoon of salt pans and birdlife. ~10-20 min from Aveiro.', 40.6500, -8.7000);
