import 'package:flutter/foundation.dart';
import 'package:pinmap_travel_journal/models/place.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';
import 'package:pinmap_travel_journal/services/country_service.dart';

class PlaceService {
  static final Map<String, List<Place>> _cityCache = {};

  static Future<List<Place>> getPlacesForCategory(String categoryName, String cityName) async {
    if (!_cityCache.containsKey(cityName)) {
      await _loadPlacesForCity(cityName);
    }
    final cityPlaces = _cityCache[cityName] ?? [];
    return cityPlaces.where((p) => p.categoryName == categoryName).toList();
  }

  static Future<void> _loadPlacesForCity(String cityName) async {
    try {
      final countries = CountryService.getAllCountries();
      int? cityId;
      outer:
      for (final country in countries) {
        for (final city in country.cityPins) {
          if (city.name == cityName) {
            cityId = city.cityId;
            break outer;
          }
        }
      }

      if (cityId == null) {
        _cityCache[cityName] = [];
        return;
      }

      final data = await ApiClient.get('/places?city_id=$cityId');
      _cityCache[cityName] = (data as List).map((json) => Place.fromJson({
        ...json,
        'category_name': json['category_name'] as String?,
      })).toList();
    } catch (e) {
      debugPrint('PlaceService._loadPlacesForCity($cityName) error: $e');
      _cityCache[cityName] = [];
    }
  }

  // Fallback mock data when API is unavailable
  static List<Place> getMockPlacesForCategory(String category) {
    return _mockData[category] ?? [];
  }

  static final Map<String, List<Place>> _mockData = {
    'Historical Sights': [
      Place(placeId: 1, name: 'Old Castle', categoryName: 'Historical Sights', shortDescription: 'Medieval fortress from 12th century', fullDescription: 'A magnificent medieval castle that has stood the test of time.', address: '10 Rue du Château, 75001 Paris', latitude: 48.8566, longitude: 2.3522, website: 'https://example.com/old-castle', openingHours: '9:00 AM - 6:00 PM', imageCover: 'https://picsum.photos/seed/castle1/800/400'),
      Place(placeId: 2, name: 'Ancient Ruins', categoryName: 'Historical Sights', shortDescription: 'Roman settlement remains', fullDescription: 'Walk through the preserved ruins of an ancient Roman settlement.', address: '25 Avenue des Ruines, 75002 Paris', latitude: 48.8606, longitude: 2.3376, website: 'https://example.com/ancient-ruins', openingHours: '8:30 AM - 7:00 PM', imageCover: 'https://picsum.photos/seed/ruins1/800/400'),
      Place(placeId: 3, name: 'Historic Square', categoryName: 'Historical Sights', shortDescription: 'Main city square since 1400s', address: '1 Place Centrale, 75001 Paris', latitude: 48.8600, longitude: 2.3364, imageCover: 'https://picsum.photos/seed/square1/800/400'),
      Place(placeId: 4, name: 'Medieval Wall', categoryName: 'Historical Sights', shortDescription: 'City fortifications from 1300s', address: '15 Boulevard des Remparts, 75003 Paris', latitude: 48.8630, longitude: 2.3450, imageCover: 'https://picsum.photos/seed/ruins2/800/400'),
      Place(placeId: 5, name: 'Royal Palace', categoryName: 'Historical Sights', shortDescription: 'Former royal residence', address: '50 Rue Royale, 75004 Paris', latitude: 48.8650, longitude: 2.3300, imageCover: 'https://picsum.photos/seed/castle2/800/400'),
    ],
    'For the Art Lovers': [
      Place(placeId: 6, name: 'Modern Art Museum', categoryName: 'For the Art Lovers', shortDescription: 'Contemporary art collection', address: '100 Boulevard des Arts, 75005 Paris', latitude: 48.8610, longitude: 2.3410, openingHours: '10:00 AM - 8:00 PM', imageCover: 'https://picsum.photos/seed/museum1/800/400'),
      Place(placeId: 7, name: 'Street Art Alley', categoryName: 'For the Art Lovers', shortDescription: 'Urban art gallery outdoors', address: '42 Rue des Artistes, 75006 Paris', latitude: 48.8620, longitude: 2.3450, imageCover: 'https://picsum.photos/seed/streetart/800/400'),
      Place(placeId: 8, name: 'Sculpture Park', categoryName: 'For the Art Lovers', shortDescription: 'Open-air sculpture exhibition', address: '5 Jardin des Sculptures, 75007 Paris', latitude: 48.8630, longitude: 2.3480, imageCover: 'https://picsum.photos/seed/sculpture/800/400'),
      Place(placeId: 9, name: 'Gallery District', categoryName: 'For the Art Lovers', shortDescription: 'Multiple art galleries in one area', address: 'Rue des Galeries, 75008 Paris', latitude: 48.8640, longitude: 2.3500, imageCover: 'https://picsum.photos/seed/gallery/800/400'),
    ],
    'Atmosphere & experience': [
      Place(placeId: 10, name: 'Sunset Viewpoint', categoryName: 'Atmosphere & experience', shortDescription: 'Best sunset spot in the city', address: 'Colline du Belvédère, 75009 Paris', latitude: 48.8650, longitude: 2.3550, imageCover: 'https://picsum.photos/seed/sunset/800/400'),
      Place(placeId: 11, name: 'Jazz Club', categoryName: 'Atmosphere & experience', shortDescription: 'Live jazz every weekend', address: '22 Rue du Jazz, 75010 Paris', latitude: 48.8660, longitude: 2.3400, openingHours: '8:00 PM - 2:00 AM', imageCover: 'https://picsum.photos/seed/jazz/800/400'),
      Place(placeId: 12, name: 'Rooftop Bar', categoryName: 'Atmosphere & experience', shortDescription: 'Cocktails with a view', address: 'Rooftop Hôtel Panorama, 75011 Paris', latitude: 48.8670, longitude: 2.3420, openingHours: '5:00 PM - 1:00 AM', imageCover: 'https://picsum.photos/seed/rooftop/800/400'),
      Place(placeId: 13, name: 'Night Market', categoryName: 'Atmosphere & experience', shortDescription: 'Street food and local crafts', address: 'Place du Marché Nocturne, 75012 Paris', latitude: 48.8680, longitude: 2.3440, openingHours: '6:00 PM - 11:00 PM', imageCover: 'https://picsum.photos/seed/nightmarket/800/400'),
    ],
    'Hidden Gems': [
      Place(placeId: 14, name: 'Secret Garden', categoryName: 'Hidden Gems', shortDescription: 'Hidden oasis in the city center', address: '12 Passage Secret, 75013 Paris', latitude: 48.8690, longitude: 2.3460, openingHours: '9:00 AM - 6:00 PM', imageCover: 'https://picsum.photos/seed/garden/800/400'),
      Place(placeId: 15, name: 'Local Bakery', categoryName: 'Hidden Gems', shortDescription: 'Best pastries since 1950', address: '8 Rue des Gourmands, 75014 Paris', latitude: 48.8700, longitude: 2.3480, openingHours: '6:00 AM - 8:00 PM', imageCover: 'https://picsum.photos/seed/bakery/800/400'),
      Place(placeId: 16, name: 'Hidden Courtyard', categoryName: 'Hidden Gems', shortDescription: 'Ancient courtyard with cafe', address: '3 Cour Intérieure, 75015 Paris', latitude: 48.8710, longitude: 2.3500, imageCover: 'https://picsum.photos/seed/courtyard/800/400'),
      Place(placeId: 17, name: 'Unknown Bookshop', categoryName: 'Hidden Gems', shortDescription: 'Rare books and quiet reading', address: '55 Rue des Livres, 75016 Paris', latitude: 48.8720, longitude: 2.3520, openingHours: '10:00 AM - 8:00 PM', imageCover: 'https://picsum.photos/seed/bookshop/800/400'),
    ],
    'Close by': [
      Place(placeId: 18, name: 'Neighboring Town', categoryName: 'Close by', shortDescription: 'Charming town 30 minutes away', address: 'Centre-Ville, 78000 Versailles', latitude: 48.8800, longitude: 2.3600, imageCover: 'https://picsum.photos/seed/town/800/400'),
      Place(placeId: 19, name: 'Nearby Village', categoryName: 'Close by', shortDescription: 'Traditional village life', address: 'Le Village, 78500 Triel-sur-Seine', latitude: 48.8900, longitude: 2.3700, imageCover: 'https://picsum.photos/seed/village/800/400'),
      Place(placeId: 20, name: 'Adjacent Park', categoryName: 'Close by', shortDescription: 'Large nature reserve nearby', address: 'Parc Naturel Régional, 78120 Paris', latitude: 48.9000, longitude: 2.3800, imageCover: 'https://picsum.photos/seed/park/800/400'),
      Place(placeId: 21, name: 'Close Beach', categoryName: 'Close by', shortDescription: 'Beautiful beach 20 minutes away', address: 'Plage des Sables, 78230 Le Pecq', latitude: 48.9100, longitude: 2.3900, imageCover: 'https://picsum.photos/seed/beach/800/400'),
    ],
    'My places': [
      Place(placeId: 22, name: 'Favorite Restaurant', categoryName: 'My places', shortDescription: 'Best local cuisine in town', address: '30 Rue des Saveurs, 75017 Paris', latitude: 48.8620, longitude: 2.3380, openingHours: '12:00 PM - 10:00 PM', imageCover: 'https://picsum.photos/seed/restaurant/800/400'),
      Place(placeId: 23, name: 'My Hotel', categoryName: 'My places', shortDescription: 'Comfortable stay in city center', address: '15 Rue de l\'Hôtel, 75018 Paris', latitude: 48.8630, longitude: 2.3390, imageCover: 'https://picsum.photos/seed/hotel/800/400'),
      Place(placeId: 24, name: 'Regular Cafe', categoryName: 'My places', shortDescription: 'Morning coffee ritual spot', address: '7 Rue du Café, 75019 Paris', latitude: 48.8640, longitude: 2.3400, openingHours: '7:00 AM - 7:00 PM', imageCover: 'https://picsum.photos/seed/cafe/800/400'),
      Place(placeId: 25, name: 'Gym I Visit', categoryName: 'My places', shortDescription: 'My daily workout place', address: '20 Rue du Sport, 75020 Paris', latitude: 48.8650, longitude: 2.3410, openingHours: '6:00 AM - 10:00 PM', imageCover: 'https://picsum.photos/seed/gym/800/400'),
    ],
  };
}
