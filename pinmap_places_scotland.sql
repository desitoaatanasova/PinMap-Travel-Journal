-- PinMap Places Data - Scotland
-- Source: PinMap data updated.docx

-- ===== EDINBURGH =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@edinburgh_id, 1, 'Edinburgh Castle', 'Iconic fortress perched on a volcanic rock overlooking the city.', 55.9486, -3.1999),
(@edinburgh_id, 1, 'Royal Mile', 'Historic street connecting the castle with Palace of Holyroodhouse.', 55.9504, -3.1860),
(@edinburgh_id, 1, 'St Giles'' Cathedral', 'Historic cathedral known for its distinctive crown-shaped steeple.', 55.9495, -3.1910),
(@edinburgh_id, 1, 'Palace of Holyroodhouse', 'Official Scottish residence of the British monarch.', 55.9526, -3.1720);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@edinburgh_id, 2, 'Scottish National Gallery', 'Major collection of European and Scottish art.', 55.9510, -3.1960),
(@edinburgh_id, 2, 'National Museum of Scotland', 'Museum covering science, history, and culture.', 55.9470, -3.1890),
(@edinburgh_id, 2, 'Edinburgh Festival Fringe', 'The world''s largest arts festival.', 55.9500, -3.1980);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@edinburgh_id, 4, 'Dean Village', 'Quiet historic village area beside the Water of Leith.', 55.9530, -3.2160),
(@edinburgh_id, 4, 'Greyfriars Kirkyard', 'Atmospheric historic cemetery connected with many local legends.', 55.9467, -3.1920),
(@edinburgh_id, 4, 'Scott Monument', 'Gothic monument dedicated to Walter Scott.', 55.9520, -3.1930),
(@edinburgh_id, 4, 'Royal Mile Closes', 'Small winding alleys (called closes) branching off the Royal Mile.', 55.9500, -3.1890);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@edinburgh_id, 3, 'Royal Mile Walk', 'Walk along the Royal Mile through medieval streets.', 55.9504, -3.1860),
(@edinburgh_id, 3, 'Arthur''s Seat', 'Climb Arthur''s Seat for panoramic views of the city.', 55.9444, -3.1610),
(@edinburgh_id, 3, 'New Town Architecture', 'Explore the elegant Georgian architecture of New Town.', 55.9540, -3.2010),
(@edinburgh_id, 3, 'Whisky Bars', 'Visit traditional Scottish pubs and whisky bars.', 55.9500, -3.1900),
(@edinburgh_id, 3, 'Skyline Sunset', 'Enjoy Edinburgh''s dramatic skyline at sunset.', 55.9500, -3.2050);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@edinburgh_id, 5, 'Stirling Castle', 'Majestic fortress of Scottish kings. ~1 hr from Edinburgh.', 56.1195, -3.9470),
(@edinburgh_id, 5, 'St Andrews', 'Home of golf on the Fife coast. ~1 hr 30 min from Edinburgh.', 56.3398, -2.7968),
(@edinburgh_id, 5, 'Loch Lomond', 'Scotland''s largest loch of mountain scenery. ~2 hr from Edinburgh.', 56.1300, -4.6400),
(@edinburgh_id, 5, 'Glasgow', 'Scotland''s largest city of art and architecture. ~50 min from Edinburgh.', 55.8642, -4.2518);

-- ===== GLASGOW =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@glasgow_id, 1, 'Glasgow Cathedral', 'One of the finest medieval buildings in Scotland.', 55.8622, -4.2350),
(@glasgow_id, 1, 'Provand''s Lordship', 'The oldest surviving house in the city, dating from the 15th century.', 55.8625, -4.2370),
(@glasgow_id, 1, 'George Square', 'Central civic square surrounded by historic buildings.', 55.8610, -4.2500),
(@glasgow_id, 1, 'The Necropolis', 'Dramatic Victorian cemetery on a hill overlooking the cathedral.', 55.8630, -4.2320);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@glasgow_id, 2, 'Kelvingrove Art Gallery and Museum', 'One of the most visited museums in the UK with art and historical collections.', 55.8680, -4.2910),
(@glasgow_id, 2, 'The Glasgow School of Art', 'Iconic building designed by Charles Rennie Mackintosh.', 55.8660, -4.2640),
(@glasgow_id, 2, 'Riverside Museum', 'Modern museum exploring the city''s transport and maritime history.', 55.8640, -4.3070);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@glasgow_id, 4, 'House for an Art Lover', 'Building based on a design by Charles Rennie Mackintosh.', 55.8420, -4.3040),
(@glasgow_id, 4, 'Ashton Lane', 'Charming narrow street with cafés, restaurants, and lights.', 55.8740, -4.2900),
(@glasgow_id, 4, 'Pollok Country Park', 'Large green park with woodland walks and historic houses.', 55.8260, -4.3230),
(@glasgow_id, 4, 'West End Galleries', 'Independent galleries and creative studios across the West End.', 55.8730, -4.2870);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@glasgow_id, 3, 'West End Vibe', 'Explore Glasgow''s vibrant West End with cafés, music venues, and galleries.', 55.8730, -4.2890),
(@glasgow_id, 3, 'Victorian Streets', 'Walk through grand Victorian streets and merchant buildings.', 55.8600, -4.2600),
(@glasgow_id, 3, 'Live Music', 'Visit lively music venues that shaped the city''s cultural scene.', 55.8620, -4.2580),
(@glasgow_id, 3, 'Kelvingrove Park', 'Relax in Kelvingrove Park along the River Kelvin.', 55.8690, -4.2860),
(@glasgow_id, 3, 'Nightlife & Culture', 'Experience Glasgow''s energetic nightlife and creative culture.', 55.8580, -4.2600);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@glasgow_id, 5, 'Edinburgh', 'Scotland''s castle-crowned capital. ~50 min from Glasgow.', 55.9533, -3.1883),
(@glasgow_id, 5, 'Loch Lomond', 'Scotland''s largest loch of mountain scenery. ~45 min from Glasgow.', 56.1300, -4.6400),
(@glasgow_id, 5, 'Stirling Castle', 'Majestic fortress of Scottish kings. ~40 min from Glasgow.', 56.1195, -3.9470),
(@glasgow_id, 5, 'Glencoe', 'Dramatic Highland glen of rugged peaks. ~2 hr 30 min from Glasgow.', 56.6800, -5.0300);

-- ===== INVERNESS =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@inverness_id, 1, 'Inverness Castle', 'Landmark castle overlooking the River Ness and the city center.', 57.4760, -4.2260),
(@inverness_id, 1, 'Inverness Cathedral', 'Beautiful Victorian cathedral dedicated to St Andrew.', 57.4710, -4.2330),
(@inverness_id, 1, 'Old High Church', 'Historic church associated with the Jacobite Rising of 1745.', 57.4680, -4.2280),
(@inverness_id, 1, 'Fort George', 'Massive 18th-century fortress built after the Jacobite rebellion.', 57.5840, -4.0750);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@inverness_id, 2, 'Inverness Museum and Art Gallery', 'Museum exploring Highland history, culture, and art.', 57.4770, -4.2240),
(@inverness_id, 2, 'Eden Court Theatre', 'Major cultural venue for theatre, music, and film.', 57.4750, -4.2350),
(@inverness_id, 2, 'Inverness Highland Games', 'Traditional Highland sporting and cultural event.', 57.4780, -4.2220);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@inverness_id, 4, 'Ness Islands', 'Small wooded islands in the River Ness connected by charming footbridges.', 57.4610, -4.2350),
(@inverness_id, 4, 'Victorian Market', 'Historic indoor market with small independent shops.', 57.4780, -4.2260),
(@inverness_id, 4, 'River Ness', 'Scenic riverside walks through the city.', 57.4710, -4.2310),
(@inverness_id, 4, 'Riverside Cafés', 'Quiet cafés and pubs along the riverbanks.', 57.4720, -4.2330);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@inverness_id, 3, 'Ness Islands Walk', 'Walk along the River Ness and explore the Ness Islands.', 57.4610, -4.2350),
(@inverness_id, 3, 'Highland City Vibe', 'Experience the relaxed atmosphere of a Highland city.', 57.4770, -4.2250),
(@inverness_id, 3, 'Whisky & Music Pubs', 'Visit traditional pubs with local whisky and music.', 57.4790, -4.2270),
(@inverness_id, 3, 'Highland Countryside', 'Enjoy views of the surrounding Highland countryside.', 57.4800, -4.2500),
(@inverness_id, 3, 'Castles & Lochs', 'Explore nearby castles and lochs.', 57.4700, -4.2400);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@inverness_id, 5, 'Loch Ness', 'Famous loch of monster myths. ~25-30 min from Inverness.', 57.3200, -4.4500),
(@inverness_id, 5, 'Urquhart Castle', 'Dramatic ruined castle on Loch Ness. ~30 min from Inverness.', 57.3240, -4.4400),
(@inverness_id, 5, 'Culloden Battlefield', 'Site of the 1746 battle and a moving memorial. ~15 min from Inverness.', 57.4780, -4.0880),
(@inverness_id, 5, 'Cairngorms National Park', 'Britain''s largest national park. ~1 hr from Inverness.', 57.1000, -3.8000);

-- ===== ST ANDREWS =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@standrews_id, 1, 'St Andrews Cathedral', 'Ruins of what was once the largest cathedral in Scotland.', 56.3400, -2.7870),
(@standrews_id, 1, 'St Andrews Castle', 'Dramatic castle ruins overlooking the North Sea.', 56.3420, -2.7920),
(@standrews_id, 1, 'University of St Andrews', 'Founded in 1413, the oldest university in Scotland.', 56.3410, -2.7950),
(@standrews_id, 1, 'St Salvator''s Chapel', 'Historic university chapel with beautiful Gothic architecture.', 56.3415, -2.7940);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@standrews_id, 2, 'Wardlaw Museum', 'Museum exploring the university''s history and collections.', 56.3390, -2.7960),
(@standrews_id, 2, 'St Andrews Museum', 'Local museum covering the town''s cultural and social history.', 56.3395, -2.7900),
(@standrews_id, 2, 'Byre Theatre', 'Cultural center for theatre, film, and performances.', 56.3380, -2.7940);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@standrews_id, 4, 'West Sands Beach', 'Long sandy beach with views across the North Sea.', 56.3440, -2.7900),
(@standrews_id, 4, 'St Andrews Harbour', 'Small historic harbor beneath the cathedral ruins.', 56.3420, -2.7850),
(@standrews_id, 4, 'Swilcan Bridge', 'Iconic bridge on the famous golf course.', 56.3430, -2.7990),
(@standrews_id, 4, 'Medieval Streets', 'Quiet medieval streets around the cathedral and university.', 56.3400, -2.7930);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@standrews_id, 3, 'Coastal Cliffs', 'Walk along the dramatic coastal cliffs and beaches.', 56.3430, -2.7860),
(@standrews_id, 3, 'University Quadrangles', 'Explore the historic university quadrangles.', 56.3410, -2.7950),
(@standrews_id, 3, 'Old Course', 'Visit the legendary Old Course.', 56.3430, -2.8040),
(@standrews_id, 3, 'Bookshops & Cafés', 'Enjoy cafés and bookshops around the university district.', 56.3390, -2.7940),
(@standrews_id, 3, 'Scholarly Atmosphere', 'Experience the relaxed yet scholarly atmosphere of the town.', 56.3405, -2.7950);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@standrews_id, 5, 'Edinburgh', 'Scotland''s castle-crowned capital. ~1 hr 30 min from St Andrews.', 55.9533, -3.1883),
(@standrews_id, 5, 'Dundee', 'Waterfront city of design and the V&A. ~25 min from St Andrews.', 56.4620, -2.9707),
(@standrews_id, 5, 'Glamis Castle', 'Fairytale castle of royal legend. ~50 min from St Andrews.', 56.6210, -3.0020),
(@standrews_id, 5, 'Fife Coastal Path', 'Long-distance trail along the Fife coastline. Accessible directly from St Andrews.', 56.3500, -2.7800);

-- ===== ABERDEEN =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@aberdeen_id, 1, 'St Machar''s Cathedral', 'Historic cathedral dating back to the 12th century, known for its impressive twin towers.', 57.1700, -2.1020),
(@aberdeen_id, 1, 'University of Aberdeen', 'One of the oldest universities in the UK, founded in 1495.', 57.1640, -2.1010),
(@aberdeen_id, 1, 'Marischal College', 'One of the largest granite buildings in the world and a landmark of the city center.', 57.1490, -2.0960),
(@aberdeen_id, 1, 'Provost Skene''s House', 'Well-preserved 16th-century townhouse exploring Aberdeen''s history.', 57.1480, -2.0980);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@aberdeen_id, 2, 'Aberdeen Art Gallery', 'Major gallery featuring Scottish and European art.', 57.1470, -2.1000),
(@aberdeen_id, 2, 'The Tolbooth Museum', 'Historic jail museum with exhibits on the city''s past.', 57.1475, -2.0930),
(@aberdeen_id, 2, 'His Majesty''s Theatre', 'Important venue for theatre, opera, and ballet.', 57.1460, -2.1040);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@aberdeen_id, 4, 'Footdee', 'Charming historic fishing village at the end of Aberdeen Harbour.', 57.1410, -2.0720),
(@aberdeen_id, 4, 'Seaton Park', 'Peaceful park beside the River Don with cathedral views.', 57.1730, -2.0950),
(@aberdeen_id, 4, 'Duthie Park', 'Large Victorian park with gardens and the famous winter gardens greenhouse.', 57.1320, -2.1040),
(@aberdeen_id, 4, 'Old Aberdeen', 'Quiet cobbled streets in the historic Old Aberdeen district.', 57.1660, -2.1000);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@aberdeen_id, 3, 'Old Aberdeen Walk', 'Walk through the historic university quarter of Old Aberdeen.', 57.1660, -2.1010),
(@aberdeen_id, 3, 'Granite Architecture', 'Explore granite architecture in the city center.', 57.1470, -2.0980),
(@aberdeen_id, 3, 'North Sea Beaches', 'Enjoy long sandy beaches along the North Sea coast.', 57.1450, -2.0550),
(@aberdeen_id, 3, 'Pubs & Seafood', 'Visit traditional pubs and seafood restaurants.', 57.1475, -2.0950),
(@aberdeen_id, 3, 'Maritime Character', 'Discover the maritime character of Scotland''s northeast.', 57.1450, -2.0900);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@aberdeen_id, 5, 'Dunnottar Castle', 'Spectacular cliff-top fortress. ~30 min from Aberdeen.', 56.9460, -2.1970),
(@aberdeen_id, 5, 'Cairngorms National Park', 'Britain''s largest national park. ~1 hr 30 min from Aberdeen.', 57.1000, -3.8000),
(@aberdeen_id, 5, 'Balmoral Castle', 'The royal family''s Scottish retreat. ~1 hr 30 min from Aberdeen.', 56.9990, -3.2410),
(@aberdeen_id, 5, 'Stonehaven', 'Seaside town near Dunnottar Castle. ~20 min from Aberdeen.', 56.9640, -2.2080);
