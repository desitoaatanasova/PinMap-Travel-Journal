import 'package:flutter/material.dart';

class Trip {
  final String id;
  final String destination;
  final String? heroImageUrl;
  final DateTime startDate;
  final DateTime endDate;
  final int durationDays;
  final bool isSolo;
  final String tripType;
  final String budget;
  final List<TripDay> itinerary;

  const Trip({
    required this.id,
    required this.destination,
    this.heroImageUrl,
    required this.startDate,
    required this.endDate,
    required this.durationDays,
    required this.isSolo,
    required this.tripType,
    required this.budget,
    this.itinerary = const [],
  });
}

class TripDay {
  final int dayNumber;
  final List<TripActivity> morning;
  final List<TripActivity> afternoon;
  final List<TripActivity> evening;

  const TripDay({
    required this.dayNumber,
    this.morning = const [],
    this.afternoon = const [],
    this.evening = const [],
  });
}

class TripActivity {
  final String name;
  final String description;
  final String? time;
  final IconData icon;

  const TripActivity({
    required this.name,
    this.description = '',
    this.time,
    this.icon = Icons.place,
  });
}
