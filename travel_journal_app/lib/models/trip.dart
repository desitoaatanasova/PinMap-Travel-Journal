class Trip {
  final int tripId;
  final String title;
  final int countryId;
  final DateTime startDate;
  final DateTime endDate;
  final String tripType;
  final String travelStyle;
  final List<TripDay> itinerary;

  const Trip({
    required this.tripId,
    required this.title,
    required this.countryId,
    required this.startDate,
    required this.endDate,
    this.tripType = '',
    this.travelStyle = '',
    this.itinerary = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'countryId': countryId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'tripType': tripType,
      'travelStyle': travelStyle,
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
      itinerary: json['itinerary'] != null
          ? (json['itinerary'] as List).map((d) => TripDay.fromJson(d)).toList()
          : [],
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
}

class TripActivity {
  final int? placeId;
  final String? placeName;
  final String? placeImage;
  final String timeSlot;
  final String notes;

  const TripActivity({
    this.placeId,
    this.placeName,
    this.placeImage,
    this.timeSlot = 'Morning',
    this.notes = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'placeId': placeId,
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
    );
  }
}
