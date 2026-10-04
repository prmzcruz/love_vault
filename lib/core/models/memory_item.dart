import 'package:equatable/equatable.dart';

enum MemoryCategory {
  initialMeet,
  firstDate,
  firstILoveYou,
  milestone,
  trip,
  birthday,
  currentStatus,
}

extension MemoryCategoryX on MemoryCategory {
  String get label {
    switch (this) {
      case MemoryCategory.initialMeet:
        return 'Initial Meet ✨';
      case MemoryCategory.firstDate:
        return 'First Date ☕';
      case MemoryCategory.firstILoveYou:
        return 'First "I Love You" ❤️';
      case MemoryCategory.milestone:
        return 'Milestone 💍';
      case MemoryCategory.trip:
        return 'Romantic Trip ✈️';
      case MemoryCategory.birthday:
        return 'Birthday Celebration 🎉';
      case MemoryCategory.currentStatus:
        return 'Current Status 💖';
    }
  }

  String get defaultEmoji {
    switch (this) {
      case MemoryCategory.initialMeet:
        return '✨';
      case MemoryCategory.firstDate:
        return '☕';
      case MemoryCategory.firstILoveYou:
        return '💌';
      case MemoryCategory.milestone:
        return '💍';
      case MemoryCategory.trip:
        return '🏖️';
      case MemoryCategory.birthday:
        return '🎂';
      case MemoryCategory.currentStatus:
        return '👩‍❤️‍👨';
    }
  }
}

class MemoryItem extends Equatable {
  final String id;
  final String title;
  final DateTime date;
  final String location;
  final String description;
  final MemoryCategory category;
  final String heartEmoji;
  final bool isFavorite;
  final String? imageUrl;

  const MemoryItem({
    required this.id,
    required this.title,
    required this.date,
    required this.location,
    required this.description,
    required this.category,
    this.heartEmoji = '❤️',
    this.isFavorite = false,
    this.imageUrl,
  });

  MemoryItem copyWith({
    String? id,
    String? title,
    DateTime? date,
    String? location,
    String? description,
    MemoryCategory? category,
    String? heartEmoji,
    bool? isFavorite,
    String? imageUrl,
  }) {
    return MemoryItem(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      location: location ?? this.location,
      description: description ?? this.description,
      category: category ?? this.category,
      heartEmoji: heartEmoji ?? this.heartEmoji,
      isFavorite: isFavorite ?? this.isFavorite,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  static List<MemoryItem> defaultMemories() {
    return [
      MemoryItem(
        id: 'mem_1',
        title: 'The Spark - First Meet',
        date: DateTime(2023, 2, 14),
        location: 'Cozy Corner Cafe ☕',
        description:
            'The exact moment our eyes met! You wore that beautiful smile, and time stood still for a second. We talked for 3 hours straight over hot coffee.',
        category: MemoryCategory.initialMeet,
        heartEmoji: '💖',
        isFavorite: true,
      ),
      MemoryItem(
        id: 'mem_2',
        title: 'Our Magical First Official Date',
        date: DateTime(2023, 2, 28),
        location: 'Sunset Riverwalk Promenade 🌅',
        description:
            'Walking under the evening city lights holding hands for the very first time. Your hands were warm, and my heart beat so fast!',
        category: MemoryCategory.firstDate,
        heartEmoji: '💕',
        isFavorite: true,
      ),
      MemoryItem(
        id: 'mem_3',
        title: 'Whispering "I Love You"',
        date: DateTime(2023, 5, 20),
        location: 'Stargazing Hilltop 🌌',
        description:
            'Under a night sky full of shooting stars, we whispered those three special words to each other. A moment locked in our hearts forever.',
        category: MemoryCategory.firstILoveYou,
        heartEmoji: '💓',
        isFavorite: true,
      ),
      MemoryItem(
        id: 'mem_4',
        title: 'Beach Gateway & Waves',
        date: DateTime(2023, 9, 15),
        location: 'Paradise Cove Resort 🏝️',
        description:
            'Our first trip together! Shell collecting on the beach, watching sunrise over the ocean waves, and laughing until midnight.',
        category: MemoryCategory.trip,
        heartEmoji: '💗',
        isFavorite: false,
      ),
      MemoryItem(
        id: 'mem_5',
        title: '1st Anniversary Milestone',
        date: DateTime(2024, 2, 14),
        location: 'Candlelight Rooftop Bistro 🕯️',
        description:
            '365 days of love, giggles, support, and endless memories. Here is to a lifetime of togetherness!',
        category: MemoryCategory.milestone,
        heartEmoji: '💘',
        isFavorite: true,
      ),
      MemoryItem(
        id: 'mem_6',
        title: 'Current Status: Deeply In Love ❤️',
        date: DateTime.now(),
        location: 'Everywhere with You 🏡',
        description:
            'Stronger, happier, and more in love than ever before! Celebrating another glorious year of togetherness & your special Birthday!',
        category: MemoryCategory.currentStatus,
        heartEmoji: '💝',
        isFavorite: true,
      ),
    ];
  }

  @override
  List<Object?> get props => [
        id,
        title,
        date,
        location,
        description,
        category,
        heartEmoji,
        isFavorite,
        imageUrl,
      ];
}
