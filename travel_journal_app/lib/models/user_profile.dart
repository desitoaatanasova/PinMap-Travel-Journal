class UserProfile {
  final int userId;
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
  final List<int> travelPhotoIds;
  final bool isFollowing;
  final bool isPrivate;

  const UserProfile({
    this.userId = 0,
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
    this.travelPhotoIds = const [],
    this.isFollowing = false,
    this.isPrivate = false,
  });

  String get displayName => '${firstName ?? username} ${lastName ?? ''}'.trim();

  UserProfile copyWith({bool? isFollowing}) {
    return UserProfile(
      userId: userId,
      username: username,
      firstName: firstName,
      lastName: lastName,
      bio: bio,
      profilePicture: profilePicture,
      profileStatus: profileStatus,
      placesVisited: placesVisited,
      ratingsGiven: ratingsGiven,
      tripsPlanned: tripsPlanned,
      journalsCreated: journalsCreated,
      followersCount: followersCount,
      followingCount: followingCount,
      travelPhotos: travelPhotos,
      travelPhotoIds: travelPhotoIds,
      isFollowing: isFollowing ?? this.isFollowing,
      isPrivate: isPrivate,
    );
  }
}
