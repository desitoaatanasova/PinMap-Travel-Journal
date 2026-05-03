import 'package:flutter/material.dart';

class UserProfile {
  final String username;
  final String? avatarUrl;
  final String? bio;
  final DateTime memberSince;
  final int countriesVisited;
  final int citiesExplored;
  final int tripsPlanned;
  final int journalsCreated;
  final int followersCount;
  final int followingCount;
  final List<String> travelPhotos;

  const UserProfile({
    required this.username,
    this.avatarUrl,
    this.bio,
    required this.memberSince,
    this.countriesVisited = 0,
    this.citiesExplored = 0,
    this.tripsPlanned = 0,
    this.journalsCreated = 0,
    this.followersCount = 0,
    this.followingCount = 0,
    this.travelPhotos = const [],
  });
}
