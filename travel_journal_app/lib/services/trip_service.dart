import 'package:flutter/material.dart';
import 'package:travel_journal_app/models/trip.dart';

class TripService {
  static List<Trip> getAllTrips() {
    return _mockTrips;
  }

  static Trip? getTripById(String id) {
    try {
      return _mockTrips.firstWhere((trip) => trip.id == id);
    } catch (e) {
      return null;
    }
  }

  static void deleteTrip(String id) {
    _mockTrips.removeWhere((trip) => trip.id == id);
  }

  static void addTrip(Trip trip) {
    _mockTrips.add(trip);
  }

  static final List<Trip> _mockTrips = [
    Trip(
      id: 'paris-001',
      destination: 'Paris, France',
      heroImageUrl: 'https://picsum.photos/seed/paris-trip/800/400',
      startDate: DateTime(2025, 12, 15),
      endDate: DateTime(2025, 12, 20),
      durationDays: 5,
      isSolo: true,
      tripType: 'Leisure',
      budget: '\$\$',
      itinerary: [
        TripDay(
          dayNumber: 1,
          morning: [
            TripActivity(
              name: 'Eiffel Tower Visit',
              description: 'Morning visit to the iconic tower',
              time: '9:00 AM',
              icon: Icons.location_city,
            ),
            TripActivity(
              name: 'Coffee at Café de Flore',
              description: 'Classic Parisian café experience',
              time: '11:00 AM',
              icon: Icons.local_cafe,
            ),
          ],
          afternoon: [
            TripActivity(
              name: 'Louvre Museum',
              description: 'Explore world-class art collection',
              time: '2:00 PM',
              icon: Icons.museum,
            ),
          ],
          evening: [
            TripActivity(
              name: 'Seine River Dinner Cruise',
              description: 'Dinner with city lights view',
              time: '7:00 PM',
              icon: Icons.dinner_dining,
            ),
          ],
        ),
        TripDay(
          dayNumber: 2,
          morning: [
            TripActivity(
              name: 'Notre-Dame Cathedral',
              description: 'Visit the Gothic masterpiece',
              time: '9:30 AM',
              icon: Icons.church,
            ),
          ],
          afternoon: [
            TripActivity(
              name: 'Montmartre & Sacré-Cœur',
              description: 'Artistic district exploration',
              time: '2:00 PM',
              icon: Icons.photo_camera,
            ),
          ],
          evening: [
            TripActivity(
              name: 'Moulin Rouge Show',
              description: 'Iconic cabaret performance',
              time: '8:00 PM',
              icon: Icons.theaters,
            ),
          ],
        ),
        TripDay(
          dayNumber: 3,
          morning: [
            TripActivity(
              name: 'Luxembourg Gardens',
              description: 'Morning stroll in beautiful gardens',
              time: '9:00 AM',
              icon: Icons.park,
            ),
          ],
          afternoon: [
            TripActivity(
              name: 'Shopping on Champs-Élysées',
              description: 'Famous avenue for shopping',
              time: '1:00 PM',
              icon: Icons.shopping_bag,
            ),
          ],
          evening: [
            TripActivity(
              name: 'Dinner in Le Marais',
              description: 'Historic district dining',
              time: '7:30 PM',
              icon: Icons.restaurant,
            ),
          ],
        ),
        TripDay(
          dayNumber: 4,
          morning: [
            TripActivity(
              name: 'Arc de Triomphe',
              description: 'Climb for panoramic views',
              time: '10:00 AM',
              icon: Icons.flag,
            ),
          ],
          afternoon: [
            TripActivity(
              name: 'Musée d\'Orsay',
              description: 'Impressionist art museum',
              time: '2:00 PM',
              icon: Icons.palette,
            ),
          ],
          evening: [
            TripActivity(
              name: 'Evening Walk on Pont des Arts',
              description: 'Romantic bridge stroll',
              time: '6:30 PM',
              icon: Icons.directions_walk,
            ),
          ],
        ),
        TripDay(
          dayNumber: 5,
          morning: [
            TripActivity(
              name: 'Père Lachaise Cemetery',
              description: 'Visit famous graves and monuments',
              time: '9:00 AM',
              icon: Icons.local_florist,
            ),
          ],
          afternoon: [
            TripActivity(
              name: 'Last-minute Souvenir Shopping',
              description: 'Pick up gifts and mementos',
              time: '1:00 PM',
              icon: Icons.card_giftcard,
            ),
          ],
          evening: [
            TripActivity(
              name: 'Farewell Dinner near Eiffel Tower',
              description: 'Final meal with tower view',
              time: '7:00 PM',
              icon: Icons.favorite,
            ),
          ],
        ),
      ],
    ),
    Trip(
      id: 'tokyo-001',
      destination: 'Tokyo, Japan',
      heroImageUrl: 'https://picsum.photos/seed/tokyo-trip/800/400',
      startDate: DateTime(2026, 3, 10),
      endDate: DateTime(2026, 3, 15),
      durationDays: 5,
      isSolo: false,
      tripType: 'Cultural',
      budget: '\$\$\$',
      itinerary: [
        TripDay(
          dayNumber: 1,
          morning: [
            TripActivity(
              name: 'Tsukiji Outer Market',
              description: 'Fresh seafood and street food',
              time: '8:00 AM',
              icon: Icons.set_meal,
            ),
          ],
          afternoon: [
            TripActivity(
              name: 'Senso-ji Temple',
              description: 'Tokyo\'s oldest temple',
              time: '1:00 PM',
              icon: Icons.temple_buddhist,
            ),
          ],
          evening: [
            TripActivity(
              name: 'Shibuya Crossing & Sky',
              description: 'Iconic intersection view',
              time: '6:00 PM',
              icon: Icons.visibility,
            ),
          ],
        ),
        TripDay(
          dayNumber: 2,
          morning: [
            TripActivity(
              name: 'Meiji Shrine',
              description: 'Peaceful forest shrine',
              time: '9:00 AM',
              icon: Icons.park,
            ),
          ],
          afternoon: [
            TripActivity(
              name: 'Harajuku & Takeshita Street',
              description: 'Youth culture and fashion',
              time: '2:00 PM',
              icon: Icons.shopping_bag,
            ),
          ],
          evening: [
            TripActivity(
              name: 'Akihabara Electric Town',
              description: 'Anime and electronics district',
              time: '6:00 PM',
              icon: Icons.videogame_asset,
            ),
          ],
        ),
        TripDay(
          dayNumber: 3,
          morning: [
            TripActivity(
              name: 'Tokyo Skytree',
              description: 'Tallest structure in Japan',
              time: '9:00 AM',
              icon: Icons.view_agenda,
            ),
          ],
          afternoon: [
            TripActivity(
              name: 'Asakusa Cultural Walk',
              description: 'Traditional district exploration',
              time: '1:00 PM',
              icon: Icons.directions_walk,
            ),
          ],
          evening: [
            TripActivity(
              name: 'Ramen Dinner in Shinjuku',
              description: 'Famous noodle dining',
              time: '7:00 PM',
              icon: Icons.ramen_dining,
            ),
          ],
        ),
        TripDay(
          dayNumber: 4,
          morning: [
            TripActivity(
              name: 'TeamLab Planets',
              description: 'Immersive digital art',
              time: '10:00 AM',
              icon: Icons.palette,
            ),
          ],
          afternoon: [
            TripActivity(
              name: 'Ginza Shopping',
              description: 'Upscale shopping district',
              time: '2:00 PM',
              icon: Icons.diamond,
            ),
          ],
          evening: [
            TripActivity(
              name: 'Izakaya Hopping in Omoide Yokocho',
              description: 'Traditional pub alley experience',
              time: '6:30 PM',
              icon: Icons.nightlife,
            ),
          ],
        ),
        TripDay(
          dayNumber: 5,
          morning: [
            TripActivity(
              name: 'Tsukiji Fish Market Final Visit',
              description: 'Last chance for fresh sushi',
              time: '8:00 AM',
              icon: Icons.set_meal,
            ),
          ],
          afternoon: [
            TripActivity(
              name: 'Relax in Ueno Park',
              description: 'Cherry blossoms and museums',
              time: '1:00 PM',
              icon: Icons.park,
            ),
          ],
          evening: [
            TripActivity(
              name: 'Farewell Dinner with Mt. Fuji View',
              description: 'Special ending meal',
              time: '7:00 PM',
              icon: Icons.flag,
            ),
          ],
        ),
      ],
    ),
  ];
}
