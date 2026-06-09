class UserProfile {
  final String username;
  final String? firstName;
  final String? lastName;
  final String? bio;
  final String? profilePicture;
  final String profileStatus;
  final int placesVisited;
  final int ratingsGiven;
  final int tripsPlanned;
  final int journalsCreated;
  final int followersCount;
  final int followingCount;
  final List<String> travelPhotos;

  const UserProfile({
    required this.username,
    this.firstName,
    this.lastName,
    this.bio,
    this.profilePicture,
    this.profileStatus = 'public',
    this.placesVisited = 0,
    this.ratingsGiven = 0,
    this.tripsPlanned = 0,
    this.journalsCreated = 0,
    this.followersCount = 0,
    this.followingCount = 0,
    this.travelPhotos = const [],
  });

  String get displayName => '${firstName ?? username} ${lastName ?? ''}'.trim();
}
