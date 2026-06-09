import 'package:pinmap_travel_journal/models/user_profile.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';

class ProfileService {
  static UserProfile? _profile;

  static Future<UserProfile> getProfile() async {
    if (_profile != null) return _profile!;
    try {
      final data = await ApiClient.get('/profile');
      _profile = _parseProfile(data);
      return _profile!;
    } catch (e) {
      return _mockProfile;
    }
  }

  static Future<void> reloadProfile() async {
    try {
      final data = await ApiClient.get('/profile');
      _profile = _parseProfile(data);
    } catch (_) {}
  }

  static UserProfile _parseProfile(Map<String, dynamic> json) {
    return UserProfile(
      username: json['username'] ?? '',
      firstName: json['first_name'],
      lastName: json['last_name'],
      bio: json['bio'] ?? '',
      profilePicture: json['profile_picture'],
      profileStatus: json['profile_status'] ?? 'public',
      placesVisited: json['placesVisited'] ?? 0,
      ratingsGiven: json['ratingsGiven'] ?? 0,
      tripsPlanned: json['tripsPlanned'] ?? 0,
      journalsCreated: json['journalsCreated'] ?? 0,
      followersCount: json['followersCount'] ?? 0,
      followingCount: json['followingCount'] ?? 0,
      travelPhotos: (json['travelPhotos'] as List?)?.cast<String>() ?? [],
    );
  }

  static final UserProfile _mockProfile = UserProfile(
    username: 'TravelExplorer',
    bio: 'Wandering the world one city at a time',
  );
}
