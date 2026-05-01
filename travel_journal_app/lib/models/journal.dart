import 'package:flutter/material.dart';

class JournalChapter {
  final String id;
  final String title;
  final String country;
  final String? city;
  final DateTime date;
  final String? coverImageUrl;
  final String previewText;
  final List<JournalEntry> entries;
  final Color accentColor;

  const JournalChapter({
    required this.id,
    required this.title,
    required this.country,
    this.city,
    required this.date,
    this.coverImageUrl,
    required this.previewText,
    this.entries = const [],
    this.accentColor = Colors.brown,
  });
}

class JournalEntry {
  final String id;
  final String content;
  final DateTime createdAt;
  final List<String> imageUrls;
  final List<JournalSticker> stickers;

  const JournalEntry({
    required this.id,
    required this.content,
    required this.createdAt,
    this.imageUrls = const [],
    this.stickers = const [],
  });
}

class JournalSticker {
  final String emoji;
  final String name;
  final double size;

  const JournalSticker({
    required this.emoji,
    required this.name,
    this.size = 40,
  });
}
