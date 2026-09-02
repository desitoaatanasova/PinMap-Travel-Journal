class Trip {
  final int tripId;
  final String title;
  final int countryId;
  final DateTime startDate;
  final DateTime endDate;
  final String tripType;
  final String travelStyle;
  final int? numberOfDays;
  final List<TripDay> itinerary;
  final List<int> cityIds;
  final String? arrivalCity;
  final String? departureCity;
  final List<TripParticipant> participants;

  const Trip({
    required this.tripId,
    required this.title,
    required this.countryId,
    required this.startDate,
    required this.endDate,
    this.tripType = '',
    this.travelStyle = '',
    this.numberOfDays,
    this.itinerary = const [],
    this.cityIds = const [],
    this.arrivalCity,
    this.departureCity,
    this.participants = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'countryId': countryId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'tripType': tripType,
      'travelStyle': travelStyle,
      'numberOfDays': numberOfDays,
      'arrivalCity': arrivalCity,
      'departureCity': departureCity,
      'cityIds': cityIds,
      'participantIds': participants.map((p) => p.userId).toList(),
      'itinerary': itinerary.map((day) => day.toJson()).toList(),
    };
  }

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      tripId: json['trip_id'] ?? int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      title: json['title'] ?? '',
      countryId: json['country_id'] ?? 0,
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      tripType: json['trip_type'] ?? '',
      travelStyle: json['travel_style'] ?? '',
      numberOfDays: json['number_of_days'] != null
          ? (json['number_of_days'] as num).toInt()
          : null,
      arrivalCity: json['arrival_city'],
      departureCity: json['departure_city'],
      cityIds: (json['city_ids'] as List?)
              ?.map((id) => (id as num).toInt())
              .toList() ??
          [],
      participants: (json['participants'] as List?)
              ?.map((p) => TripParticipant.fromJson(p))
              .toList() ??
          [],
      itinerary: json['itinerary'] != null
          ? (json['itinerary'] as List).map((d) => TripDay.fromJson(d)).toList()
          : [],
    );
  }

  Trip copyWith({
    int? tripId,
    String? title,
    int? countryId,
    DateTime? startDate,
    DateTime? endDate,
    String? tripType,
    String? travelStyle,
    int? numberOfDays,
    List<TripDay>? itinerary,
    List<int>? cityIds,
    String? arrivalCity,
    String? departureCity,
    List<TripParticipant>? participants,
  }) {
    return Trip(
      tripId: tripId ?? this.tripId,
      title: title ?? this.title,
      countryId: countryId ?? this.countryId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      tripType: tripType ?? this.tripType,
      travelStyle: travelStyle ?? this.travelStyle,
      numberOfDays: numberOfDays ?? this.numberOfDays,
      itinerary: itinerary ?? this.itinerary,
      cityIds: cityIds ?? this.cityIds,
      arrivalCity: arrivalCity ?? this.arrivalCity,
      departureCity: departureCity ?? this.departureCity,
      participants: participants ?? this.participants,
    );
  }
}

class TripParticipant {
  final int userId;
  final String username;
  final String? firstName;
  final String? lastName;
  final String? profilePicture;

  const TripParticipant({
    required this.userId,
    required this.username,
    this.firstName,
    this.lastName,
    this.profilePicture,
  });

  String get displayName => '${firstName ?? username} ${lastName ?? ''}'.trim();

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'profilePicture': profilePicture,
    };
  }

  factory TripParticipant.fromJson(Map<String, dynamic> json) {
    return TripParticipant(
      userId: (json['user_id'] ?? json['userId'] ?? 0) as int,
      username: json['username'] ?? '',
      firstName: json['first_name'] ?? json['firstName'],
      lastName: json['last_name'] ?? json['lastName'],
      profilePicture: json['profile_picture'] ?? json['profilePicture'],
    );
  }
}

class TripDay {
  final int dayNumber;
  final String? date;
  final List<TripActivity> morning;
  final List<TripActivity> afternoon;
  final List<TripActivity> evening;

  const TripDay({
    required this.dayNumber,
    this.date,
    this.morning = const [],
    this.afternoon = const [],
    this.evening = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'dayNumber': dayNumber,
      'date': date,
      'morning': morning.map((a) => a.toJson()).toList(),
      'afternoon': afternoon.map((a) => a.toJson()).toList(),
      'evening': evening.map((a) => a.toJson()).toList(),
    };
  }

  factory TripDay.fromJson(Map<String, dynamic> json) {
    return TripDay(
      dayNumber: json['day_number'] ?? 0,
      date: json['date'],
      morning: (json['morning'] as List?)
              ?.map((a) => TripActivity.fromJson(a))
              .toList() ??
          [],
      afternoon: (json['afternoon'] as List?)
              ?.map((a) => TripActivity.fromJson(a))
              .toList() ??
          [],
      evening: (json['evening'] as List?)
              ?.map((a) => TripActivity.fromJson(a))
              .toList() ??
          [],
    );
  }

  List<TripActivity> activitiesForSlot(String timeSlot) {
    switch (timeSlot) {
      case 'Morning':
        return morning;
      case 'Afternoon':
        return afternoon;
      case 'Evening':
        return evening;
      default:
        return const [];
    }
  }

  List<TripActivity> get allActivities =>
      [...morning, ...afternoon, ...evening];
}

class TripActivity {
  final int? placeId;
  final String? placeName;
  final String? placeImage;
  final String timeSlot;
  final String notes;
  final double? latitude;
  final double? longitude;
  final int? categoryId;
  final String? cityName;

  const TripActivity({
    this.placeId,
    this.placeName,
    this.placeImage,
    this.timeSlot = 'Morning',
    this.notes = '',
    this.latitude,
    this.longitude,
    this.categoryId,
    this.cityName,
  });

  Map<String, dynamic> toJson() {
    return {
      'placeId': placeId,
      'placeName': placeName,
      'timeSlot': timeSlot,
      'notes': notes,
    };
  }

  factory TripActivity.fromJson(Map<String, dynamic> json) {
    return TripActivity(
      placeId: json['place_id'],
      placeName: json['place_name'],
      placeImage: json['place_image'],
      timeSlot: json['time_slot'] ?? 'Morning',
      notes: json['notes'] ?? '',
      latitude: json['latitude'] != null
          ? (json['latitude'] is String
              ? double.tryParse(json['latitude'])
              : (json['latitude'] as num).toDouble())
          : null,
      longitude: json['longitude'] != null
          ? (json['longitude'] is String
              ? double.tryParse(json['longitude'])
              : (json['longitude'] as num).toDouble())
          : null,
      categoryId: json['category_id'] != null
          ? (json['category_id'] as num).toInt()
          : null,
      cityName: json['city_name'],
    );
  }
}
