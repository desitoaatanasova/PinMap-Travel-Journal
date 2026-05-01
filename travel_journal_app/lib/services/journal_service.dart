import 'package:flutter/material.dart';
import 'package:pinmap_travel_journal/models/journal.dart';

class JournalService {
  static List<JournalChapter> getAllChapters() {
    return _mockChapters;
  }

  static JournalChapter? getChapterById(String id) {
    try {
      return _mockChapters.firstWhere((ch) => ch.id == id);
    } catch (e) {
      return null;
    }
  }

  static final List<JournalChapter> _mockChapters = [
    JournalChapter(
      id: 'paris-adventure',
      title: 'Paris Adventure',
      country: 'France',
      city: 'Paris',
      date: DateTime(2025, 12, 15),
      coverImageUrl: 'https://picsum.photos/seed/paris-journal/400/300',
      previewText:
          'Woke up to the beautiful Eiffel Tower view from my window. The morning light hitting the iron lattice is magical...',
      accentColor: const Color(0xFF641919),
      entries: [
        JournalEntry(
          id: 'paris-entry-1',
          content:
              'Woke up to the beautiful Eiffel Tower view from my window. The morning light hitting the iron lattice is absolutely magical. Had breakfast at a cute café nearby - croissants were perfection!',
          createdAt: DateTime(2025, 12, 15, 9, 30),
          imageUrls: [
            'https://picsum.photos/seed/paris-morning/400/300',
          ],
          stickers: const [
            JournalSticker(emoji: '🗼', name: 'Eiffel Tower', size: 40),
            JournalSticker(emoji: '🥐', name: 'Croissant', size: 32),
          ],
        ),
        JournalEntry(
          id: 'paris-entry-2',
          content:
              'Afternoon at the Louvre was incredible. Mona Lisa is smaller than I expected but the atmosphere is amazing. Spent hours wandering through the galleries.',
          createdAt: DateTime(2025, 12, 15, 14, 0),
          imageUrls: [
            'https://picsum.photos/seed/louvre/400/300',
          ],
          stickers: const [
            JournalSticker(emoji: '🎨', name: 'Art', size: 36),
          ],
        ),
        JournalEntry(
          id: 'paris-entry-3',
          content:
              'Dinner cruise on the Seine was the perfect ending to the day. City lights reflecting on the water, wine in hand, and the Eiffel Tower sparkling every hour.',
          createdAt: DateTime(2025, 12, 15, 19, 0),
          imageUrls: [
            'https://picsum.photos/seed/seine-cruise/400/300',
          ],
          stickers: const [
            JournalSticker(emoji: '🚢', name: 'Boat', size: 40),
            JournalSticker(emoji: '🍷', name: 'Wine', size: 32),
          ],
        ),
      ],
    ),
    JournalChapter(
      id: 'tokyo-explored',
      title: 'Tokyo Explored',
      country: 'Japan',
      city: 'Tokyo',
      date: DateTime(2026, 3, 10),
      coverImageUrl: 'https://picsum.photos/seed/tokyo-journal/400/300',
      previewText:
          'First day in Tokyo! The energy here is incredible. Shinjuku crossed at rush hour - so many people but so organized...',
      accentColor: const Color(0xFF8B2500),
      entries: [
        JournalEntry(
          id: 'tokyo-entry-1',
          content:
              'First day in Tokyo! The energy here is incredible. Shinjuku crossed at rush hour - so many people but so organized. The neon lights are dazzling at night.',
          createdAt: DateTime(2026, 3, 10, 10, 0),
          imageUrls: [
            'https://picsum.photos/seed/shinjuku/400/300',
          ],
          stickers: const [
            JournalSticker(emoji: '🗼', name: 'Tokyo Tower', size: 40),
            JournalSticker(emoji: '🎌', name: 'Japan', size: 36),
          ],
        ),
        JournalEntry(
          id: 'tokyo-entry-2',
          content:
              'Tsukiji market for breakfast - freshest sushi I\'ve ever had! Then wandered through Asakusa to Senso-ji Temple. The contrast between ancient and modern is fascinating.',
          createdAt: DateTime(2026, 3, 10, 14, 30),
          imageUrls: [
            'https://picsum.photos/seed/tsukiji/400/300',
          ],
          stickers: const [
            JournalSticker(emoji: '🍣', name: 'Sushi', size: 36),
            JournalSticker(emoji: '⛩️', name: 'Temple', size: 40),
          ],
        ),
      ],
    ),
    JournalChapter(
      id: 'italy-dream',
      title: 'Italian Dreams',
      country: 'Italy',
      city: 'Rome',
      date: DateTime(2025, 9, 5),
      coverImageUrl: 'https://picsum.photos/seed/italy-journal/400/300',
      previewText:
          'The Colosseum exceeded all expectations. Walking through ancient ruins where gladiators once fought is surreal...',
      accentColor: const Color(0xFF7e6350),
      entries: [
        JournalEntry(
          id: 'italy-entry-1',
          content:
              'The Colosseum exceeded all expectations. Walking through ancient ruins where gladiators once fought is surreal. The architecture is mind-boggling.',
          createdAt: DateTime(2025, 9, 5, 10, 0),
          imageUrls: [
            'https://picsum.photos/seed/colosseum/400/300',
          ],
          stickers: const [
            JournalSticker(emoji: '🏛️', name: 'Colosseum', size: 40),
          ],
        ),
      ],
    ),
  ];
}
