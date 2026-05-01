import 'package:latlong2/latlong.dart';
import 'package:travel_journal_app/models/country.dart';

class CountryService {
  static List<Country> getAllCountries() {
    return _countries;
  }

  static Country? findCountryByLocation(double lat, double lng) {
    final point = LatLng(lat, lng);
    for (final country in _countries) {
      if (country.contains(point)) return country;
    }
    return null;
  }

  static const List<Country> _countries = [
    Country(
      name: 'USA',
      description: 'The United States is a diverse country spanning multiple regions, known for its mix of urban culture and natural wonders.',
      latitude: 39.8283,
      longitude: -98.5795,
      radiusKm: 3000,
      cityPins: [
        CityPin(name: 'New York', latitude: 40.7128, longitude: -74.0060),
        CityPin(name: 'Los Angeles', latitude: 34.0522, longitude: -118.2437),
        CityPin(name: 'Chicago', latitude: 41.8781, longitude: -87.6298),
        CityPin(name: 'Miami', latitude: 25.7617, longitude: -80.1918),
      ],
      flag: '🇺🇸',
      imageUrl: 'https://images.unsplash.com/photo-1485738422979-f5c462cd1f0a?w=800',
      rating: 4.5,
      isVisited: true,
    ),
    Country(
      name: 'United Kingdom',
      description: 'The United Kingdom is an island nation in Europe, famous for its royal heritage and historic landmarks.',
      latitude: 54.7024,
      longitude: -3.2766,
      radiusKm: 800,
      cityPins: [
        CityPin(name: 'London', latitude: 51.5074, longitude: -0.1278),
        CityPin(name: 'Manchester', latitude: 53.4808, longitude: -2.2426),
        CityPin(name: 'Edinburgh', latitude: 55.9533, longitude: -3.1883),
      ],
      flag: '🇬🇧',
      imageUrl: 'https://images.unsplash.com/photo-1513635269975-59663e0ac1ad?w=800',
      rating: 4.7,
      isVisited: true,
    ),
    Country(
      name: 'France',
      description: 'France is known for its art, fashion, and cuisine, hosting world-famous landmarks like the Eiffel Tower.',
      latitude: 46.2276,
      longitude: 2.2137,
      radiusKm: 800,
      cityPins: [
        CityPin(name: 'Paris', latitude: 48.8566, longitude: 2.3522),
        CityPin(name: 'Lyon', latitude: 45.7640, longitude: 4.8357),
        CityPin(name: 'Nice', latitude: 43.7102, longitude: 7.2620),
      ],
      flag: '🇫🇷',
      imageUrl: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=800',
      rating: 4.8,
      isVisited: true,
    ),
    Country(
      name: 'Japan',
      description: 'Japan is an island nation in East Asia, blending ancient traditions with futuristic technology.',
      latitude: 36.2048,
      longitude: 138.2529,
      radiusKm: 800,
      cityPins: [
        CityPin(name: 'Tokyo', latitude: 35.6762, longitude: 139.6503),
        CityPin(name: 'Osaka', latitude: 34.6937, longitude: 135.5023),
        CityPin(name: 'Kyoto', latitude: 35.0116, longitude: 135.7681),
      ],
      flag: '🇯🇵',
      imageUrl: 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=800',
      rating: 4.9,
      isVisited: false,
    ),
    Country(
      name: 'Australia',
      description: 'Australia is a vast island continent known for its unique wildlife and stunning natural landscapes.',
      latitude: -25.2744,
      longitude: 133.7751,
      radiusKm: 2500,
      cityPins: [
        CityPin(name: 'Sydney', latitude: -33.8688, longitude: 151.2093),
        CityPin(name: 'Melbourne', latitude: -37.8136, longitude: 144.9631),
        CityPin(name: 'Brisbane', latitude: -27.4698, longitude: 153.0251),
      ],
      flag: '🇦🇺',
      imageUrl: 'https://images.unsplash.com/photo-1506973035872-a4ec16b8e8d9?w=800',
      rating: 4.6,
      isVisited: false,
    ),
    Country(
      name: 'Italy',
      description: 'Italy is a Mediterranean country renowned for its art, architecture, and culinary traditions.',
      latitude: 41.8719,
      longitude: 12.5674,
      radiusKm: 600,
      cityPins: [
        CityPin(name: 'Rome', latitude: 41.9028, longitude: 12.4964),
        CityPin(name: 'Milan', latitude: 45.4642, longitude: 9.1900),
        CityPin(name: 'Venice', latitude: 45.4408, longitude: 12.3155),
      ],
      flag: '🇮🇹',
      imageUrl: 'https://images.unsplash.com/photo-1515542622106-78bda8ba0e5b?w=800',
      rating: 4.8,
      isVisited: true,
    ),
    Country(
      name: 'Germany',
      description: 'Germany is a central European country with a rich history and strong economy.',
      latitude: 51.1657,
      longitude: 10.4515,
      radiusKm: 600,
      cityPins: [
        CityPin(name: 'Berlin', latitude: 52.5200, longitude: 13.4050),
        CityPin(name: 'Munich', latitude: 48.1351, longitude: 11.5820),
        CityPin(name: 'Hamburg', latitude: 53.5511, longitude: 9.9937),
      ],
      flag: '🇩🇪',
      imageUrl: 'https://images.unsplash.com/photo-1467269204594-9661b134dd2b?w=800',
      rating: 4.5,
      isVisited: false,
    ),
    Country(
      name: 'Spain',
      description: 'Spain is a vibrant country known for its flamenco music, tapas, and sunny beaches.',
      latitude: 40.4637,
      longitude: -3.7492,
      radiusKm: 800,
      cityPins: [
        CityPin(name: 'Madrid', latitude: 40.4168, longitude: -3.7038),
        CityPin(name: 'Barcelona', latitude: 41.3874, longitude: 2.1686),
        CityPin(name: 'Seville', latitude: 37.3891, longitude: -5.9845),
      ],
      flag: '🇪🇸',
      imageUrl: 'https://images.unsplash.com/photo-1543783207-ec64e4d95325?w=800',
      rating: 4.7,
      isVisited: true,
    ),
    Country(
      name: 'Brazil',
      description: 'Brazil is the largest country in South America, famous for Amazon rainforest and Carnival.',
      latitude: -14.2350,
      longitude: -51.9253,
      radiusKm: 2500,
      cityPins: [
        CityPin(name: 'Rio de Janeiro', latitude: -22.9068, longitude: -43.1729),
        CityPin(name: 'Sao Paulo', latitude: -23.5505, longitude: -46.6333),
        CityPin(name: 'Brasilia', latitude: -15.7975, longitude: -47.8919),
      ],
      flag: '🇧🇷',
      imageUrl: 'https://images.unsplash.com/photo-1483721310020-03333e577078?w=800',
      rating: 4.4,
      isVisited: false,
    ),
    Country(
      name: 'Egypt',
      description: 'Egypt is an ancient civilization along the Nile River, home to the pyramids and Sphinx.',
      latitude: 26.8206,
      longitude: 30.8025,
      radiusKm: 800,
      cityPins: [
        CityPin(name: 'Cairo', latitude: 30.0444, longitude: 31.2357),
        CityPin(name: 'Alexandria', latitude: 31.2001, longitude: 29.9187),
        CityPin(name: 'Luxor', latitude: 25.6872, longitude: 32.6396),
      ],
      flag: '🇪🇬',
      imageUrl: 'https://images.unsplash.com/photo-1503177119275-0aa32b3a9368?w=800',
      rating: 4.3,
      isVisited: false,
    ),
  ];
}