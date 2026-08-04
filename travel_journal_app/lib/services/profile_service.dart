import 'package:flutter/foundation.dart';
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
    } catch (e) {
      debugPrint('ProfileService.reloadProfile error: $e');
    }
  }

  static UserProfile _parseProfile(Map<String, dynamic> data) {
    return UserProfile(
      username: data['username'] ?? '',
      firstName: data['first_name'],
      lastName: data['last_name'],
      bio: data['bio'] ?? '',
      profilePicture: data['profile_picture'],
      profileStatus: data['profile_status'] ?? 'public',
      placesVisited: data['placesVisited'] ?? 0,
      ratingsGiven: data['ratingsGiven'] ?? 0,
      tripsPlanned: data['tripsPlanned'] ?? 0,
      journalsCreated: data['journalsCreated'] ?? 0,
      followersCount: data['followersCount'] ?? 0,
      followingCount: data['followingCount'] ?? 0,
      travelPhotos: (data['travelPhotos'] as List?)?.cast<String>() ?? [],
    );
  }

  static final UserProfile _mockProfile = UserProfile(
    username: 'TravelExplorer',
    bio: 'Wandering the world one city at a time',
  );
}
