import 'package:flutter/material.dart';
import 'package:travel_journal_app/models/place.dart';

class PlaceService {
  static List<Place> getPlacesForCategory(String category, String city) {
    final places = _mockData[category] ?? [];
    return places.map((p) => Place(
      name: p['name'] as String,
      subtitle: p['subtitle'] as String,
      description: p['description'] as String,
      placeholderIcon: p['icon'] as IconData,
      placeholderColor: p['color'] as Color,
      imageUrls: List<String>.from(p['imageUrls'] ?? []),
    )).toList();
  }

  static final Map<String, List<Map<String, dynamic>>> _mockData = {
    'Historical sights': [
      {
        'name': 'Old Castle',
        'subtitle': 'Medieval fortress from 12th century',
        'description': 'A magnificent medieval castle that has stood the test of time. Explore the ancient halls, climb the tower for panoramic views, and discover the rich history within these walls.',
        'icon': Icons.account_balance,
        'color': Colors.brown,
        'imageUrls': [
          'https://picsum.photos/seed/castle1/400/300',
          'https://picsum.photos/seed/castle2/400/300',
          'https://picsum.photos/seed/castle3/400/300',
        ],
      },
      {
        'name': 'Ancient Ruins',
        'subtitle': 'Roman settlement remains',
        'description': 'Walk through the preserved ruins of an ancient Roman settlement. See the remains of temples, houses, and public buildings that tell the story of life centuries ago.',
        'icon': Icons.architecture,
        'color': Colors.brown.shade700,
        'imageUrls': [
          'https://picsum.photos/seed/ruins1/400/300',
          'https://picsum.photos/seed/ruins2/400/300',
        ],
      },
      {
        'name': 'Historic Square',
        'subtitle': 'Main city square since 1400s',
        'description': 'The heart of the city for over 600 years. Surrounded by historic buildings, cafes, and monuments. Street performers and markets often animate this vibrant space.',
        'icon': Icons.location_city,
        'color': Colors.brown.shade500,
        'imageUrls': [
          'https://picsum.photos/seed/square1/400/300',
          'https://picsum.photos/seed/square2/400/300',
        ],
      },
      {
        'name': 'Medieval Wall',
        'subtitle': 'City fortifications from 1300s',
        'description': 'Walk along the remarkably preserved medieval city walls. The 2-mile path offers stunning views of the city and surrounding landscape while showcasing historical defense architecture.',
        'icon': Icons.domain,
        'color': Colors.brown.shade600,
      },
      {
        'name': 'Royal Palace',
        'subtitle': 'Former royal residence',
        'description': 'Once home to kings and queens, this palace showcases centuries of royal history. Visit the throne room, royal chambers, and expansive gardens that demonstrate past grandeur.',
        'icon': Icons.castle,
        'color': Colors.brown.shade800,
      },
    ],
    'For the art lovers': [
      {
        'name': 'Modern Art Museum',
        'subtitle': 'Contemporary art collection',
        'description': 'A stunning collection of modern and contemporary art from local and international artists. The museum features rotating exhibitions, interactive installations, and a rooftop sculpture garden.',
        'icon': Icons.palette,
        'color': Colors.purple,
      },
      {
        'name': 'Street Art Alley',
        'subtitle': 'Urban art gallery outdoors',
        'description': 'An ever-changing outdoor gallery featuring murals and graffiti by local and international street artists. Each visit offers something new as artists continually add fresh works.',
        'icon': Icons.brush,
        'color': Colors.purple.shade400,
      },
      {
        'name': 'Sculpture Park',
        'subtitle': 'Open-air sculpture exhibition',
        'description': 'Wander through beautifully landscaped gardens featuring over 50 sculptures from various periods and styles. The park blends art with nature for a unique cultural experience.',
        'icon': Icons.architecture,
        'color': Colors.purple.shade600,
      },
      {
        'name': 'Gallery District',
        'subtitle': 'Multiple art galleries in one area',
        'description': 'A vibrant neighborhood filled with independent art galleries, studios, and workshops. Meet local artists, watch live demonstrations, and purchase unique pieces directly from creators.',
        'icon': Icons.museum,
        'color': Colors.purple.shade300,
      },
    ],
    'Atmosphere & experience': [
      {
        'name': 'Sunset Viewpoint',
        'subtitle': 'Best sunset spot in the city',
        'description': 'A breathtaking viewpoint offering panoramic sunset views over the city and beyond. Arrive early to secure a spot and enjoy the changing colors as day turns to night.',
        'icon': Icons.sunny,
        'color': Colors.orange,
      },
      {
        'name': 'Jazz Club',
        'subtitle': 'Live jazz every weekend',
        'description': 'An intimate venue featuring live jazz performances in a cozy atmosphere. Enjoy craft cocktails and authentic cuisine while listening to talented local and touring musicians.',
        'icon': Icons.music_note,
        'color': Colors.orange.shade700,
      },
      {
        'name': 'Rooftop Bar',
        'subtitle': 'Cocktails with a view',
        'description': 'Sip expertly crafted cocktails while enjoying 360-degree city views. The elegant rooftop setting is perfect for evening relaxation and socializing with both locals and travelers.',
        'icon': Icons.local_bar,
        'color': Colors.orange.shade600,
      },
      {
        'name': 'Night Market',
        'subtitle': 'Street food and local crafts',
        'description': 'A bustling evening market offering diverse street food, handmade crafts, and live entertainment. Experience the local night culture while sampling delicacies from various vendors.',
        'icon': Icons.nightlife,
        'color': Colors.orange.shade800,
      },
    ],
    'Hidden gems': [
      {
        'name': 'Secret Garden',
        'subtitle': 'Hidden oasis in the city center',
        'description': 'A little-known peaceful garden tucked away behind an unassuming door. Enjoy lush greenery, hidden fountains, and rare plant species in this urban sanctuary.',
        'icon': Icons.local_florist,
        'color': Colors.teal,
      },
      {
        'name': 'Local Bakery',
        'subtitle': 'Best pastries since 1950',
        'description': 'A family-run bakery that has been perfecting their recipes for generations. Their secret croissant recipe and award-winning pastries attract locals who line up each morning.',
        'icon': Icons.bakery_dining,
        'color': Colors.teal.shade600,
      },
      {
        'name': 'Hidden Courtyard',
        'subtitle': 'Ancient courtyard with cafe',
        'description': 'Discover this tucked-away courtyard featuring a charming café, historic architecture, and a tranquil atmosphere. Locals gather here to escape the tourist crowds.',
        'icon': Icons.cottage,
        'color': Colors.teal.shade400,
      },
      {
        'name': 'Unknown Bookshop',
        'subtitle': 'Rare books and quiet reading',
        'description': 'A treasure trove for book lovers, this shop houses rare editions, local authors, and comfortable reading nooks. The knowledgeable owner offers personalized recommendations.',
        'icon': Icons.menu_book,
        'color': Colors.teal.shade700,
      },
    ],
    'Close by': [
      {
        'name': 'Neighboring Town',
        'subtitle': 'Charming town 30 minutes away',
        'description': 'A picturesque town just a short journey away. Explore its cobblestone streets, visit the local market, and enjoy authentic regional cuisine in family-run restaurants.',
        'icon': Icons.location_city,
        'color': Colors.green,
      },
      {
        'name': 'Nearby Village',
        'subtitle': 'Traditional village life',
        'description': 'Experience authentic rural traditions in this well-preserved village. Watch craftspeople at work, taste farm-to-table cuisine, and enjoy the slower pace of country life.',
        'icon': Icons.foundation,
        'color': Colors.green.shade700,
      },
      {
        'name': 'Adjacent Park',
        'subtitle': 'Large nature reserve nearby',
        'description': 'A vast natural park offering hiking trails, wildlife spotting, and picnic areas. The diverse ecosystems include forests, meadows, and a crystal-clear lake perfect for swimming.',
        'icon': Icons.park,
        'color': Colors.green.shade600,
      },
      {
        'name': 'Close Beach',
        'subtitle': 'Beautiful beach 20 minutes away',
        'description': 'Escape to this pristine beach with golden sand and clear waters. Enjoy swimming, water sports, beachside dining, and spectacular sunset views over the ocean.',
        'icon': Icons.beach_access,
        'color': Colors.green.shade800,
      },
    ],
    'My places': [
      {
        'name': 'Favorite Restaurant',
        'subtitle': 'Best local cuisine in town',
        'description': 'Your go-to spot for authentic local dishes made with fresh, seasonal ingredients. The warm atmosphere and attentive service keep you coming back again and again.',
        'icon': Icons.restaurant,
        'color': Colors.red,
      },
      {
        'name': 'My Hotel',
        'subtitle': 'Comfortable stay in city center',
        'description': 'Your home away from home offering modern amenities, comfortable rooms, and an ideal location for exploring. The friendly staff ensures every stay is memorable.',
        'icon': Icons.hotel,
        'color': Colors.red.shade700,
      },
      {
        'name': 'Regular Café',
        'subtitle': 'Morning coffee ritual spot',
        'description': 'Start your day at this cozy café known for excellent coffee, freshly baked pastries, and a relaxed atmosphere. The baristas know your order by heart.',
        'icon': Icons.local_cafe,
        'color': Colors.red.shade600,
      },
      {
        'name': 'Gym I Visit',
        'subtitle': 'My daily workout place',
        'description': 'Stay fit at this well-equipped fitness center featuring modern machines, group classes, and personal trainers. The motivating environment helps you maintain your exercise routine.',
        'icon': Icons.fitness_center,
        'color': Colors.red.shade800,
      },
    ],
  };
}
