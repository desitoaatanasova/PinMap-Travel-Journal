import 'package:pinmap_travel_journal/models/trip.dart';
import 'package:pinmap_travel_journal/models/user_profile.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';

class SocialService {
  static UserProfile _parseUser(Map<String, dynamic> json) {
    return UserProfile(
      userId: (json['user_id'] ?? json['userId'] ?? 0) as int,
      username: json['username'] ?? '',
      firstName: json['first_name'] ?? json['firstName'],
      lastName: json['last_name'] ?? json['lastName'],
      bio: json['bio'] ?? '',
      profilePicture: json['profile_picture'] ?? json['profilePicture'],
      profileStatus: json['profile_status'] ?? json['profileStatus'] ?? 'public',
      placesVisited: (json['placesVisited'] ?? 0) as int,
      ratingsGiven: (json['ratingsGiven'] ?? 0) as int,
      tripsPlanned: (json['tripsPlanned'] ?? 0) as int,
      journalsCreated: (json['journalsCreated'] ?? 0) as int,
      followersCount: (json['followersCount'] ?? 0) as int,
      followingCount: (json['followingCount'] ?? 0) as int,
      travelPhotos: (json['travelPhotos'] as List?)?.cast<String>() ?? [],
      isFollowing: json['isFollowing'] ?? false,
      isPrivate: json['isPrivate'] ?? false,
    );
  }

  static Future<List<UserProfile>> searchUsers(String query) async {
    if (query.trim().isEmpty) return [];
    final data = await ApiClient.get('/users/search?q=${Uri.encodeQueryComponent(query)}');
    return (data as List).map((json) => _parseUser(json as Map<String, dynamic>)).toList();
  }

  static Future<UserProfile> getUserProfile(int userId) async {
    final data = await ApiClient.get('/users/$userId');
    return _parseUser(data as Map<String, dynamic>);
  }

  static Future<bool> follow(int userId) async {
    await ApiClient.post('/users/$userId/follow');
    return true;
  }

  static Future<bool> unfollow(int userId) async {
    await ApiClient.delete('/users/$userId/follow');
    return true;
  }

  static Future<List<TripParticipant>> getMutualConnections() async {
    final data = await ApiClient.get('/users/mutual');
    return (data as List).map((json) => TripParticipant.fromJson(json)).toList();
  }
}
