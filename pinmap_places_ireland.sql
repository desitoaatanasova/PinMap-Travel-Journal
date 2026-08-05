-- PinMap Places Data - Ireland
-- Source: PinMap data updated.docx

-- ===== DUBLIN =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@dublin_id, 1, 'Dublin Castle', 'Historic seat of British administration in Ireland for centuries.', 53.3429, -6.2676),
(@dublin_id, 1, 'Christ Church Cathedral', 'Medieval cathedral founded by Viking king Sitric Silkenbeard in the 11th century.', 53.3430, -6.2715),
(@dublin_id, 1, 'St Patrick''s Cathedral', 'Ireland''s largest cathedral, once associated with writer Jonathan Swift.', 53.3394, -6.2715),
(@dublin_id, 1, 'Kilmainham Gaol', 'Historic prison connected to Irish independence movements.', 53.3417, -6.3090);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@dublin_id, 2, 'Trinity College Dublin', 'Ireland''s most famous university.', 53.3440, -6.2570),
(@dublin_id, 2, 'Book of Kells', 'Famous medieval manuscript preserved at Trinity College.', 53.3440, -6.2575),
(@dublin_id, 2, 'National Gallery of Ireland', 'Home to major European and Irish art collections.', 53.3410, -6.2530),
(@dublin_id, 2, 'Literary Dublin', 'Dublin is strongly linked to writers like James Joyce, Oscar Wilde, and W. B. Yeats.', 53.3430, -6.2600);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@dublin_id, 4, 'Marsh''s Library', 'One of Ireland''s oldest libraries with 18th-century reading cages.', 53.3400, -6.2700),
(@dublin_id, 4, 'Chester Beatty Library', 'Extraordinary collection of manuscripts and rare books.', 53.3425, -6.2670),
(@dublin_id, 4, 'St Stephen''s Green', 'Elegant Georgian park in the city center.', 53.3382, -6.2590),
(@dublin_id, 4, 'Merrion Square', 'Quiet Georgian streets around Merrion Square.', 53.3395, -6.2490);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@dublin_id, 3, 'Temple Bar', 'Walk through the lively streets of Temple Bar.', 53.3450, -6.2630),
(@dublin_id, 3, 'Trad Music Pubs', 'Enjoy traditional Irish music in historic pubs.', 53.3440, -6.2650),
(@dublin_id, 3, 'Georgian Doors', 'Explore Georgian architecture and colorful doors.', 53.3390, -6.2510),
(@dublin_id, 3, 'River Liffey Sunset', 'Stroll along the River Liffey at sunset.', 53.3470, -6.2600),
(@dublin_id, 3, 'Literary Landmarks', 'Visit literary landmarks connected to Dublin''s famous writers.', 53.3420, -6.2540);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@dublin_id, 5, 'Howth', 'Seaside fishing village with cliff walks. ~30 min from Dublin.', 53.3870, -6.0650),
(@dublin_id, 5, 'Malahide Castle', 'Medieval castle with beautiful gardens. ~30 min from Dublin.', 53.4440, -6.1640),
(@dublin_id, 5, 'Wicklow Mountains', 'Green mountains and valleys, the Garden of Ireland. ~1 hr from Dublin.', 53.1000, -6.3500),
(@dublin_id, 5, 'Bray', 'Seaside town beneath Bray Head. ~40 min from Dublin.', 53.2030, -6.0990);

-- ===== CORK =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@cork_id, 1, 'St Fin Barre''s Cathedral', 'A magnificent 19th-century Gothic Revival cathedral and one of Cork''s most iconic landmarks.', 51.8944, -8.4805),
(@cork_id, 1, 'Elizabeth Fort', '17th-century star-shaped fort with views over the city.', 51.8970, -8.4820),
(@cork_id, 1, 'Cork City Gaol', 'Former prison turned museum exploring Cork''s social history.', 51.9000, -8.4970),
(@cork_id, 1, 'Red Abbey Tower', 'One of the few surviving medieval structures in the city.', 51.8995, -8.4650);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@cork_id, 2, 'Crawford Art Gallery', 'Important Irish art collection with works from the 18th century to today.', 51.8990, -8.4730),
(@cork_id, 2, 'University College Cork', 'Historic university with beautiful Gothic buildings and gardens.', 51.8930, -8.4900),
(@cork_id, 2, 'Cork Opera House', 'Major cultural venue for concerts, theatre, and performances.', 51.8975, -8.4680);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@cork_id, 4, 'The English Market', 'Historic indoor market dating back to 1788, famous for artisan food.', 51.8970, -8.4730),
(@cork_id, 4, 'Nano Nagle Place', 'Cultural center dedicated to the life of Nano Nagle.', 51.8940, -8.4780),
(@cork_id, 4, 'City Lanes', 'Small lanes filled with independent cafés and bookstores.', 51.8980, -8.4710),
(@cork_id, 4, 'Riverside Walks', 'Riverside walks along the River Lee.', 51.8960, -8.4760);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@cork_id, 3, 'English Market Food', 'Explore the lively food culture at the English Market.', 51.8970, -8.4730),
(@cork_id, 3, 'Colorful Streets', 'Walk through colorful streets and historic bridges across the River Lee.', 51.8975, -8.4750),
(@cork_id, 3, 'Trad Music Pubs', 'Visit local pubs known for traditional Irish music.', 51.8990, -8.4720),
(@cork_id, 3, 'University District', 'Enjoy the creative atmosphere around the university district.', 51.8940, -8.4890),
(@cork_id, 3, 'Local Pride', 'Discover Cork''s strong identity and local pride.', 51.8970, -8.4700);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@cork_id, 5, 'Kinsale', 'Colourful harbour town famed for food. ~30 min from Cork.', 51.7070, -8.5300),
(@cork_id, 5, 'Blarney Castle', 'Famous for the Blarney Stone and lovely gardens. ~20 min from Cork.', 51.9290, -8.5700),
(@cork_id, 5, 'Killarney National Park', 'Lakes, mountains, and the Muckross estate. ~1 hr 30 min from Cork.', 52.0100, -9.6000),
(@cork_id, 5, 'Cobh', 'Quaint port town of colourful houses. ~25 min from Cork.', 51.8500, -8.2900);

-- ===== GALWAY =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@galway_id, 1, 'Spanish Arch', 'Remnant of the old medieval city walls near the River Corrib.', 53.2690, -9.0590),
(@galway_id, 1, 'Galway Cathedral', 'Impressive 20th-century cathedral combining Renaissance and Romanesque styles.', 53.2740, -9.0570),
(@galway_id, 1, 'Lynch''s Castle', 'One of the best-preserved medieval townhouses in Ireland.', 53.2725, -9.0520),
(@galway_id, 1, 'St Nicholas'' Collegiate Church', 'Medieval church dating from the 14th century and the largest medieval parish church still in use in Ireland.', 53.2720, -9.0570);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@galway_id, 2, 'University of Galway', 'Historic university with a scenic riverside campus.', 53.2770, -9.0570),
(@galway_id, 2, 'Galway City Museum', 'Museum exploring the city''s maritime and cultural history.', 53.2690, -9.0600),
(@galway_id, 2, 'Galway International Arts Festival', 'One of the country''s major cultural festivals.', 53.2700, -9.0530),
(@galway_id, 2, 'Galway International Oyster Festival', 'Famous food festival celebrating the region''s oysters.', 53.2710, -9.0550);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@galway_id, 4, 'Salthill Promenade', 'Seaside promenade with views over Galway Bay.', 53.2590, -9.0830),
(@galway_id, 4, 'Shop Street', 'Pedestrian street filled with street musicians and colorful shops.', 53.2730, -9.0520),
(@galway_id, 4, 'Galway Bay', 'Scenic coastal bay stretching toward the Atlantic.', 53.2600, -9.1000),
(@galway_id, 4, 'Trad Music Pubs', 'Quiet traditional pubs known for authentic Irish music sessions.', 53.2700, -9.0540);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@galway_id, 3, 'Irish Music Sessions', 'Listen to traditional Irish music in historic pubs.', 53.2700, -9.0550),
(@galway_id, 3, 'Latin Quarter', 'Walk the colorful streets of the Latin Quarter.', 53.2690, -9.0560),
(@galway_id, 3, 'Galway Bay Sunset', 'Enjoy sunset views over Galway Bay.', 53.2640, -9.0950),
(@galway_id, 3, 'Craft Shops', 'Visit small craft shops and independent bookstores.', 53.2720, -9.0530),
(@galway_id, 3, 'Festival Culture', 'Experience the vibrant festival culture of the city.', 53.2710, -9.0540);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@galway_id, 5, 'Cliffs of Moher', 'Dramatic sea cliffs on the Atlantic coast. ~1 hr 30 min from Galway.', 52.9710, -9.4300),
(@galway_id, 5, 'Connemara', 'Wild bogs, mountains, and coastal scenery. ~1 hr from Galway.', 53.4500, -9.8500),
(@galway_id, 5, 'Kylemore Abbey', 'Romantic abbey set in a mountain valley. ~1 hr 30 min from Galway.', 53.5600, -9.8900),
(@galway_id, 5, 'Aran Islands', 'Remote islands of ancient stone forts. ~1 hr 30-2 hr from Galway.', 53.1100, -9.6900);

-- ===== LIMERICK =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@limerick_id, 1, 'King John''s Castle', 'Impressive 13th-century Norman castle overlooking the River Shannon.', 52.6690, -8.6260),
(@limerick_id, 1, 'St Mary''s Cathedral', 'The oldest building in Limerick still in continuous use, founded in 1168.', 52.6680, -8.6240),
(@limerick_id, 1, 'St John''s Cathedral', 'Striking Gothic cathedral with one of Ireland''s tallest church spires.', 52.6630, -8.6120),
(@limerick_id, 1, 'Treaty Stone', 'Historic landmark associated with the Treaty of Limerick ending the Williamite War in Ireland.', 52.6685, -8.6270);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@limerick_id, 2, 'Hunt Museum', 'Museum with an impressive collection of art and antiquities.', 52.6650, -8.6260),
(@limerick_id, 2, 'University of Limerick', 'Major cultural and academic institution with modern architecture and riverside grounds.', 52.6740, -8.5680),
(@limerick_id, 2, 'Limerick City Gallery of Art', 'Important gallery showcasing Irish art.', 52.6620, -8.6290);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@limerick_id, 4, 'People''s Park', 'Elegant 19th-century park in the Georgian quarter.', 52.6570, -8.6300),
(@limerick_id, 4, 'Milk Market', 'Historic market known for local food and artisan products.', 52.6640, -8.6190),
(@limerick_id, 4, 'Georgian Newtown Pery', 'Georgian streets filled with classical townhouses in the Newtown Pery district.', 52.6600, -8.6270),
(@limerick_id, 4, 'Shannon Riverside', 'Riverside walks along the River Shannon.', 52.6660, -8.6280);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@limerick_id, 3, 'Medieval Quarter', 'Explore the medieval quarter around King John''s Castle.', 52.6690, -8.6250),
(@limerick_id, 3, 'Shannon Sunset', 'Walk along the River Shannon at sunset.', 52.6660, -8.6300),
(@limerick_id, 3, 'Food Markets', 'Visit lively food markets and traditional pubs.', 52.6640, -8.6190),
(@limerick_id, 3, 'Georgian Walk', 'Discover the Georgian architecture of Newtown Pery.', 52.6600, -8.6270),
(@limerick_id, 3, 'Storytelling Tradition', 'Experience Limerick''s strong literary and storytelling tradition.', 52.6630, -8.6260);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@limerick_id, 5, 'Cliffs of Moher', 'Dramatic sea cliffs on the Atlantic coast. ~1 hr 30 min from Limerick.', 52.9710, -9.4300),
(@limerick_id, 5, 'Bunratty Castle', '15th-century castle with a folk park. ~20 min from Limerick.', 52.6970, -8.8120),
(@limerick_id, 5, 'The Burren', 'Strange limestone landscape of wildflowers. ~1 hr 15 min from Limerick.', 53.1000, -9.1000),
(@limerick_id, 5, 'Galway', 'Bohemian harbour city of festivals and music. ~1 hr 45 min from Limerick.', 53.2707, -9.0568);

-- ===== KILKENNY =====
-- Historical Sights (cat 1)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@kilkenny_id, 1, 'Kilkenny Castle', 'Majestic Norman castle overlooking the River Nore and the city''s main symbol.', 52.6505, -7.2490),
(@kilkenny_id, 1, 'St Canice''s Cathedral', 'Impressive medieval cathedral with a round tower visitors can climb.', 52.6560, -7.2580),
(@kilkenny_id, 1, 'Rothe House', 'A beautifully preserved Tudor merchant''s house with gardens.', 52.6530, -7.2520),
(@kilkenny_id, 1, 'Black Abbey', 'Dominican abbey known for its striking stained-glass window.', 52.6535, -7.2500);

-- For the Art Lovers (cat 2)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@kilkenny_id, 2, 'Butler Gallery', 'Contemporary art gallery located near Kilkenny Castle.', 52.6510, -7.2490),
(@kilkenny_id, 2, 'National Craft Gallery', 'Center for Irish design and craftsmanship.', 52.6515, -7.2495),
(@kilkenny_id, 2, 'Kilkenny Arts Festival', 'Major annual festival featuring music, theatre, and visual arts.', 52.6540, -7.2510);

-- Hidden Gems (cat 4)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@kilkenny_id, 4, 'Smithwick''s Experience', 'Brewery museum dedicated to the historic Smithwick''s.', 52.6520, -7.2530),
(@kilkenny_id, 4, 'Medieval Mile', 'Historic route connecting Kilkenny Castle and St Canice''s Cathedral.', 52.6530, -7.2530),
(@kilkenny_id, 4, 'Medieval Lanes', 'Quiet medieval lanes filled with small craft shops and cafés.', 52.6540, -7.2540),
(@kilkenny_id, 4, 'River Nore Walks', 'Scenic riverside walks along the River Nore.', 52.6490, -7.2480);

-- Atmosphere & Experiences (cat 3)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@kilkenny_id, 3, 'Medieval Mile Walk', 'Walk through the Medieval Mile and explore historic landmarks.', 52.6530, -7.2530),
(@kilkenny_id, 3, 'Craft Studios', 'Visit craft studios and artisan shops around the city.', 52.6520, -7.2520),
(@kilkenny_id, 3, 'Trad Music Pubs', 'Enjoy traditional Irish music in historic pubs.', 52.6545, -7.2550),
(@kilkenny_id, 3, 'Castle Gardens', 'Explore Kilkenny Castle gardens and parkland.', 52.6490, -7.2490),
(@kilkenny_id, 3, 'Medieval Atmosphere', 'Experience the relaxed, small-town medieval atmosphere.', 52.6535, -7.2530);

-- Close By (cat 5)
INSERT INTO places (city_id, category_id, name, short_description, latitude, longitude) VALUES
(@kilkenny_id, 5, 'Waterford', 'Ireland''s oldest city, famed for crystal. ~1 hr from Kilkenny.', 52.2593, -7.1101),
(@kilkenny_id, 5, 'Rock of Cashel', 'Iconic limestone stronghold of kings. ~1 hr 15 min from Kilkenny.', 52.5200, -7.8900),
(@kilkenny_id, 5, 'Dublin', 'Ireland''s vibrant capital. ~1 hr 30 min from Kilkenny.', 53.3498, -6.2603),
(@kilkenny_id, 5, 'Mount Juliet Estate', 'Luxury estate of parkland and golf. ~25 min from Kilkenny.', 52.5890, -7.2520);
