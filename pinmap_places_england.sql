-- PinMap Places Data - England
-- Source: PinMap data updated.docx

-- ===== LONDON =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@london_id, 1, 'Tower of London', 'Historic royal fortress and home of the Crown Jewels.', 51.5081, -0.0759),
(@london_id, 1, 'Westminster Abbey', 'Coronation church of British monarchs for nearly a thousand years.', 51.4993, -0.1273),
(@london_id, 1, 'Buckingham Palace', 'Official residence of the British monarch.', 51.5014, -0.1419),
(@london_id, 1, 'Houses of Parliament', 'Iconic seat of the UK government beside the Thames.', 51.4994, -0.1248),
(@london_id, 1, 'Tower Bridge', 'Famous Victorian bascule bridge over the river.', 51.5055, -0.0754);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@london_id, 2, 'British Museum', 'One of the world''s greatest museums with global historical collections.', 51.5194, -0.1270),
(@london_id, 2, 'National Gallery', 'Masterpieces of European painting from the Renaissance to the 19th century.', 51.5089, -0.1283),
(@london_id, 2, 'Victoria and Albert Museum', 'Major museum dedicated to art, design, and decorative arts.', 51.4966, -0.1724),
(@london_id, 2, 'Shakespeare''s Globe', 'Reconstruction of the theatre associated with William Shakespeare.', 51.5081, -0.0972);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@london_id, 4, 'Leighton House', 'Exotic Victorian artist''s house filled with decorative art.', 51.4950, -0.2040),
(@london_id, 4, 'Sir John Soane''s Museum', 'Unique house museum filled with antiquities and artworks.', 51.5170, -0.1170),
(@london_id, 4, 'Little Venice', 'Quiet canals and waterside cafés near Paddington.', 51.5250, -0.1850),
(@london_id, 4, 'Bloomsbury Bookshops', 'Bookshops and antique shops around Bloomsbury.', 51.5190, -0.1260);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@london_id, 3, 'South Bank', 'Walk along the South Bank of the River Thames.', 51.5040, -0.1150),
(@london_id, 3, 'Covent Garden', 'Explore historic markets like Covent Garden.', 51.5116, -0.1240),
(@london_id, 3, 'West End Theatre', 'Watch theatre productions in the West End.', 51.5130, -0.1280),
(@london_id, 3, 'Historic Pubs', 'Visit historic pubs and literary cafés.', 51.5160, -0.1200),
(@london_id, 3, 'Royal Parks', 'Discover elegant parks such as Hyde Park and Regent''s Park.', 51.5070, -0.1650);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@london_id, 5, 'Windsor Castle', 'The oldest occupied royal residence. ~40-50 min from London.', 51.4839, -0.6044),
(@london_id, 5, 'Oxford', 'City of Dreaming Spires. ~1 hr from London.', 51.7520, -1.2577),
(@london_id, 5, 'Cambridge', 'Historic riverside university city. ~1 hr 15 min from London.', 52.2053, 0.1218),
(@london_id, 5, 'Brighton', 'Seaside city with the iconic pier. ~1 hr from London.', 50.8225, -0.1372);

-- ===== OXFORD =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@oxford_id, 1, 'University of Oxford', 'One of the oldest and most prestigious universities in the world.', 51.7548, -1.2544),
(@oxford_id, 1, 'Christ Church College', 'One of the most famous colleges, known for its grand hall and cathedral.', 51.7502, -1.2557),
(@oxford_id, 1, 'Radcliffe Camera', 'Iconic circular library building and symbol of the city.', 51.7540, -1.2540),
(@oxford_id, 1, 'Bodleian Library', 'Historic research library and one of the oldest libraries in Europe.', 51.7542, -1.2547),
(@oxford_id, 1, 'Oxford Cathedral', 'One of the smallest cathedrals in England, located within Christ Church College.', 51.7500, -1.2560);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@oxford_id, 2, 'Ashmolean Museum', 'The world''s first university museum, with collections from ancient to modern art.', 51.7556, -1.2600),
(@oxford_id, 2, 'Oxford University Museum of Natural History', 'Beautiful Victorian museum with scientific collections.', 51.7586, -1.2559),
(@oxford_id, 2, 'Pitt Rivers Museum', 'Fascinating anthropological museum with global artifacts.', 51.7589, -1.2555);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@oxford_id, 4, 'Bridge of Sighs', 'Elegant bridge connecting two parts of Hertford College.', 51.7544, -1.2530),
(@oxford_id, 4, 'Magdalen College', 'Famous for its deer park and gardens.', 51.7522, -1.2468),
(@oxford_id, 4, 'Port Meadow', 'Ancient meadow along the Thames used for grazing for centuries.', 51.7760, -1.2770),
(@oxford_id, 4, 'Eagle and Child', 'Historic pubs such as The Eagle and Child, once frequented by Tolkien and Lewis.', 51.7552, -1.2625);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@oxford_id, 3, 'College Quadrangles', 'Walk through the historic university colleges and quadrangles.', 51.7540, -1.2570),
(@oxford_id, 3, 'Punting on the Cherwell', 'Go punting on the River Cherwell.', 51.7580, -1.2490),
(@oxford_id, 3, 'Academic Cafés', 'Visit traditional bookshops and academic cafés.', 51.7530, -1.2590),
(@oxford_id, 3, 'Radcliffe Cobbles', 'Explore cobbled streets around the Radcliffe Camera.', 51.7538, -1.2540),
(@oxford_id, 3, 'University Parks', 'Enjoy quiet gardens and university parks.', 51.7610, -1.2520);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@oxford_id, 5, 'London', 'The UK capital, two millennia of history. ~1 hr from Oxford.', 51.5074, -0.1278),
(@oxford_id, 5, 'Bath', 'Georgian spa city with Roman baths. ~1 hr 30 min from Oxford.', 51.3811, -2.3590),
(@oxford_id, 5, 'Windsor', 'Home of the royal Windsor Castle. ~1 hr 20 min from Oxford.', 51.4839, -0.6044),
(@oxford_id, 5, 'Cotswolds', 'Rolling hills of honey-stone villages. ~1 hr from Oxford.', 51.9300, -1.8300);

-- ===== CAMBRIDGE =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@cambridge_id, 1, 'University of Cambridge', 'One of the world''s oldest and most renowned universities, founded in 1209.', 52.2053, 0.1218),
(@cambridge_id, 1, 'King''s College Chapel', 'Masterpiece of late Gothic architecture, famous for its magnificent fan vaulting.', 52.2045, 0.1165),
(@cambridge_id, 1, 'Trinity College', 'One of the largest and most prestigious colleges, associated with Isaac Newton.', 52.2060, 0.1170),
(@cambridge_id, 1, 'St John''s College', 'Historic college with beautiful courtyards and gardens.', 52.2070, 0.1150);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@cambridge_id, 2, 'Fitzwilliam Museum', 'Major museum with art and antiquities from around the world.', 52.2030, 0.1190),
(@cambridge_id, 2, 'Kettle''s Yard', 'Unique house museum and gallery dedicated to modern art.', 52.2110, 0.1100),
(@cambridge_id, 2, 'Sedgwick Museum of Earth Sciences', 'Museum exploring geology and natural history.', 52.2035, 0.1220);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@cambridge_id, 4, 'Mathematical Bridge', 'Famous wooden bridge at Queens'' College.', 52.2010, 0.1150),
(@cambridge_id, 4, 'Bridge of Sighs', 'Romantic covered bridge across the River Cam.', 52.2070, 0.1155),
(@cambridge_id, 4, 'The Backs', 'Scenic green spaces behind the colleges along the river.', 52.2080, 0.1130),
(@cambridge_id, 4, 'Independent Bookshops', 'Independent bookshops and cafés around the historic center.', 52.2050, 0.1180);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@cambridge_id, 3, 'Punting on the Cam', 'Go punting on the River Cam.', 52.2030, 0.1140),
(@cambridge_id, 3, 'College Courtyards', 'Walk through centuries-old college courtyards and gardens.', 52.2055, 0.1170),
(@cambridge_id, 3, 'Academic Chapels', 'Explore historic academic libraries and chapels.', 52.2045, 0.1165),
(@cambridge_id, 3, 'Riverside Meadows', 'Relax in riverside parks and meadows.', 52.2070, 0.1100),
(@cambridge_id, 3, 'Scholarly Atmosphere', 'Experience the quiet scholarly atmosphere of the city.', 52.2040, 0.1200);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@cambridge_id, 5, 'London', 'The UK capital, two millennia of history. ~1 hr from Cambridge.', 51.5074, -0.1278),
(@cambridge_id, 5, 'Oxford', 'City of Dreaming Spires. ~2 hr from Cambridge.', 51.7520, -1.2577),
(@cambridge_id, 5, 'Ely', 'Cathedral town on the fenland edge. ~20 min from Cambridge.', 52.3990, 0.2620),
(@cambridge_id, 5, 'Grantchester', 'Village of meadows and literary cafés. ~15-30 min from Cambridge.', 52.1800, 0.0930);

-- ===== YORK =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@york_id, 1, 'York Minster', 'One of the largest Gothic cathedrals in Northern Europe, famous for its stained glass windows.', 53.9623, -1.0819),
(@york_id, 1, 'York City Walls', 'Best-preserved medieval city walls in England, stretching around the historic center.', 53.9600, -1.0800),
(@york_id, 1, 'Clifford''s Tower', 'Remains of York Castle with panoramic views of the city.', 53.9559, -1.0793),
(@york_id, 1, 'York Castle Museum', 'Museum recreating everyday life from the Victorian era.', 53.9560, -1.0770);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@york_id, 2, 'Jorvik Viking Centre', 'Interactive museum exploring the city''s Viking past.', 53.9560, -1.0800),
(@york_id, 2, 'York Art Gallery', 'Collection of British paintings, ceramics, and decorative arts.', 53.9630, -1.0870),
(@york_id, 2, 'National Railway Museum', 'One of the world''s largest railway museums.', 53.9600, -1.0970);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@york_id, 4, 'The Shambles', 'Famous medieval street lined with overhanging timber-framed houses.', 53.9595, -1.0800),
(@york_id, 4, 'Barley Hall', 'Reconstructed medieval townhouse once home to a wealthy merchant.', 53.9598, -1.0810),
(@york_id, 4, 'Museum Gardens', 'Beautiful riverside gardens with Roman and medieval ruins.', 53.9620, -1.0890),
(@york_id, 4, 'Historic Tea Rooms', 'Historic tea rooms and small antique shops scattered through the old city.', 53.9590, -1.0820);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@york_id, 3, 'City Walls Sunset', 'Walk along the medieval city walls at sunset.', 53.9610, -1.0820),
(@york_id, 3, 'Historic Centre', 'Explore the narrow streets of the historic center.', 53.9590, -1.0800),
(@york_id, 3, 'Tea Rooms & Pubs', 'Visit traditional English tea rooms and historic pubs.', 53.9600, -1.0830),
(@york_id, 3, 'River Ouse Walk', 'Take a river walk along the River Ouse.', 53.9580, -1.0840),
(@york_id, 3, 'Layered History', 'Discover York''s mix of Roman, Viking, and medieval heritage.', 53.9600, -1.0850);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@york_id, 5, 'Yorkshire Dales', 'Craggy valleys and stone villages. ~1 hr 30 min from York.', 54.2500, -2.2000),
(@york_id, 5, 'North York Moors', 'Purple heather moors and dales. ~1 hr from York.', 54.4000, -0.9000),
(@york_id, 5, 'Leeds', 'Vibrant northern city of culture. ~25 min from York.', 53.8008, -1.5491),
(@york_id, 5, 'Durham', 'Hilltop cathedral city. ~1 hr from York.', 54.7753, -1.5849);

-- ===== LIVERPOOL =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@liverpool_id, 1, 'Liverpool Cathedral', 'One of the largest cathedrals in the world, built in Gothic Revival style.', 53.3974, -2.9728),
(@liverpool_id, 1, 'Metropolitan Cathedral of Christ the King', 'Striking modernist Catholic cathedral with a circular design.', 53.4040, -2.9710),
(@liverpool_id, 1, 'Royal Albert Dock', 'Historic waterfront complex with museums, galleries, and restaurants.', 53.3998, -2.9915),
(@liverpool_id, 1, 'St George''s Hall', 'Grand neoclassical building used for concerts and civic events.', 53.4080, -2.9790);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@liverpool_id, 2, 'Tate Liverpool', 'Major contemporary art gallery on the waterfront.', 53.3995, -2.9935),
(@liverpool_id, 2, 'Walker Art Gallery', 'One of England''s finest collections of paintings and sculptures.', 53.4080, -2.9795),
(@liverpool_id, 2, 'Museum of Liverpool', 'Museum dedicated to the city''s history and culture.', 53.4005, -2.9945);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@liverpool_id, 4, 'The Cavern Club', 'Legendary music venue where the Beatles performed early in their career.', 53.4050, -2.9890),
(@liverpool_id, 4, 'Baltic Triangle', 'Creative district filled with independent cafés, galleries, and street art.', 53.3930, -2.9760),
(@liverpool_id, 4, 'Sefton Park', 'Large Victorian park with lakes and gardens.', 53.3870, -2.9320),
(@liverpool_id, 4, 'Rodney Street', 'Quiet Georgian streets around Rodney Street.', 53.4030, -2.9720);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@liverpool_id, 3, 'Waterfront Sunset', 'Walk along the historic waterfront at sunset.', 53.4000, -2.9920),
(@liverpool_id, 3, 'Beatles Landmarks', 'Visit Beatles landmarks around the city.', 53.4050, -2.9890),
(@liverpool_id, 3, 'Albert Dock Museums', 'Explore museums and galleries around Albert Dock.', 53.3998, -2.9915),
(@liverpool_id, 3, 'Music & Pub Culture', 'Experience Liverpool''s lively music and pub culture.', 53.4030, -2.9850),
(@liverpool_id, 3, 'Maritime Heritage', 'Discover historic neighborhoods and maritime heritage.', 53.3980, -2.9900);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@liverpool_id, 5, 'Manchester', 'Industrial powerhouse turned creative hub. ~40-50 min from Liverpool.', 53.4808, -2.2426),
(@liverpool_id, 5, 'Chester', 'Walled city with Roman heritage. ~45 min from Liverpool.', 53.1900, -2.8900),
(@liverpool_id, 5, 'Crosby Beach', 'Home to Antony Gormley''s Another Place statues. ~30 min from Liverpool.', 53.4740, -3.0340),
(@liverpool_id, 5, 'Lake District', 'England''s most beautiful national park. ~1 hr 45 min from Liverpool.', 54.4600, -3.0880);

-- ===== MANCHESTER =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@manchester_id, 1, 'Manchester Cathedral', 'Medieval cathedral with impressive Gothic architecture.', 53.4850, -2.2440),
(@manchester_id, 1, 'John Rylands Library', 'Spectacular neo-Gothic library housing rare books and manuscripts.', 53.4800, -2.2500),
(@manchester_id, 1, 'Manchester Town Hall', 'Iconic Victorian Gothic civic building on Albert Square.', 53.4790, -2.2450),
(@manchester_id, 1, 'Castlefield', 'Historic district with Roman ruins and canals from the industrial era.', 53.4760, -2.2540);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@manchester_id, 2, 'Manchester Art Gallery', 'Major collection of British art and Pre-Raphaelite paintings.', 53.4780, -2.2420),
(@manchester_id, 2, 'Science and Industry Museum', 'Museum dedicated to Manchester''s role in the Industrial Revolution.', 53.4770, -2.2560),
(@manchester_id, 2, 'University of Manchester', 'One of the UK''s leading universities and research centers.', 53.4670, -2.2340);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@manchester_id, 4, 'Afflecks', 'Alternative indoor market full of independent shops.', 53.4820, -2.2370),
(@manchester_id, 4, 'Northern Quarter', 'Creative area with street art, cafés, and music venues.', 53.4825, -2.2330),
(@manchester_id, 4, 'Heaton Park', 'One of the largest municipal parks in Europe.', 53.5340, -2.2520),
(@manchester_id, 4, 'Castlefield Canals', 'Quiet canals and industrial warehouses around Castlefield.', 53.4760, -2.2540);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@manchester_id, 3, 'Castlefield Canals Walk', 'Walk along historic canals in the Castlefield district.', 53.4760, -2.2550),
(@manchester_id, 3, 'Northern Quarter Art', 'Explore street art and independent shops in the Northern Quarter.', 53.4825, -2.2330),
(@manchester_id, 3, 'Industrial Museums', 'Visit museums connected to science and industrial history.', 53.4770, -2.2560),
(@manchester_id, 3, 'Live Music', 'Experience Manchester''s legendary live music scene.', 53.4800, -2.2440),
(@manchester_id, 3, 'Victorian Architecture', 'Discover Victorian architecture mixed with modern skyscrapers.', 53.4795, -2.2450);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@manchester_id, 5, 'Liverpool', 'The Beatles'' hometown on the Mersey. ~40-50 min from Manchester.', 53.4084, -2.9916),
(@manchester_id, 5, 'Peak District', 'England''s first national park. ~1 hr from Manchester.', 53.3500, -1.8300),
(@manchester_id, 5, 'Chester', 'Walled city with Roman heritage. ~1 hr from Manchester.', 53.1900, -2.8900),
(@manchester_id, 5, 'Lake District', 'England''s most beautiful national park. ~2 hr from Manchester.', 54.4600, -3.0880);
