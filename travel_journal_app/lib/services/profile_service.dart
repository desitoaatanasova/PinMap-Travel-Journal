import 'package:flutter/material.dart';
import 'package:pinmap_travel_journal/models/user_profile.dart';

class ProfileService {
  static UserProfile getProfile() {
    return _mockProfile;
  }

  static final UserProfile _mockProfile = UserProfile(
    username: 'TravelExplorer',
    bio: 'Wandering the world one city at a time ✈️',
    memberSince: DateTime(2023, 6, 15),
    countriesVisited: 12,
    citiesExplored: 28,
    tripsPlanned: 5,
    journalsCreated: 8,
    travelPhotos: [
      'https://picsum.photos/seed/profile1/200/200',
      'https://picsum.photos/seed/profile2/200/200',
      'https://picsum.photos/seed/profile3/200/200',
      'https://picsum.photos/seed/profile4/200/200',
      'https://picsum.photos/seed/profile5/200/200',
      'https://picsum.photos/seed/profile6/200/200',
      'https://picsum.photos/seed/profile7/200/200',
      'https://picsum.photos/seed/profile8/200/200',
      'https://picsum.photos/seed/profile9/200/200',
    ],
  );
}
