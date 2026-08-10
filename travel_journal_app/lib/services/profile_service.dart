import 'package:flutter/foundation.dart';
import 'package:pinmap_travel_journal/models/user_profile.dart';
import 'package:pinmap_travel_journal/services/api_client.dart';
import 'package:pinmap_travel_journal/services/sync_queue_service.dart';

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

  static Future<void> updateProfile({
    String? firstName,
    String? lastName,
    String? bio,
    String? profilePicture,
    String? profileStatus,
  }) async {
    final body = <String, dynamic>{
      if (firstName != null) 'firstName': firstName,
      if (lastName != null) 'lastName': lastName,
      if (bio != null) 'bio': bio,
      if (profilePicture != null) 'profilePicture': profilePicture,
      if (profileStatus != null) 'profileStatus': profileStatus,
    };
    final current = _profile ?? await getProfile();
    _profile = UserProfile(
      username: current.username,
      firstName: firstName ?? current.firstName,
      lastName: lastName ?? current.lastName,
      bio: bio ?? current.bio,
      profilePicture: profilePicture ?? current.profilePicture,
      profileStatus: profileStatus ?? current.profileStatus,
      placesVisited: current.placesVisited,
      ratingsGiven: current.ratingsGiven,
      tripsPlanned: current.tripsPlanned,
      journalsCreated: current.journalsCreated,
      followersCount: current.followersCount,
      followingCount: current.followingCount,
      travelPhotos: current.travelPhotos,
    );
    try {
      final data = await ApiClient.put('/profile', body: body);
      _profile = _parseProfile(data);
    } catch (e) {
      debugPrint('ProfileService.updateProfile offline: $e');
      await SyncQueueService.enqueue(SyncAction(
        type: SyncActionType.saveProfile,
        data: body,
        timestamp: DateTime.now(),
      ));
    }
  }

  static void reset() {
    _profile = null;
  }

  static UserProfile _parseProfile(Map<String, dynamic> data) {
    return UserProfile(
      userId: (data['user_id'] as num?)?.toInt() ?? 0,
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
