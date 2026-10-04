import 'package:equatable/equatable.dart';

class CoupleInfo extends Equatable {
  final String myName;
  final String partnerName;
  final String relationshipNickname;
  final DateTime initialMeetDate;
  final DateTime partnerBirthday;
  final String? partnerPhotoUrl;
  final String? myPhotoUrl;
  final String customLoveNote;
  final bool isSetupComplete;

  const CoupleInfo({
    required this.myName,
    required this.partnerName,
    required this.relationshipNickname,
    required this.initialMeetDate,
    required this.partnerBirthday,
    this.partnerPhotoUrl,
    this.myPhotoUrl,
    required this.customLoveNote,
    this.isSetupComplete = false,
  });

  factory CoupleInfo.defaultSetup() {
    return CoupleInfo(
      myName: 'Alex',
      partnerName: 'Maya',
      relationshipNickname: 'Eternal Soulmates 💕',
      initialMeetDate: DateTime(2023, 2, 14),
      partnerBirthday: DateTime(2026, 10, 20),
      customLoveNote: 'You are my today and all of my tomorrows. Happy Birthday my love! ❤️',
      isSetupComplete: false,
    );
  }

  CoupleInfo copyWith({
    String? myName,
    String? partnerName,
    String? relationshipNickname,
    DateTime? initialMeetDate,
    DateTime? partnerBirthday,
    String? partnerPhotoUrl,
    String? myPhotoUrl,
    String? customLoveNote,
    bool? isSetupComplete,
  }) {
    return CoupleInfo(
      myName: myName ?? this.myName,
      partnerName: partnerName ?? this.partnerName,
      relationshipNickname: relationshipNickname ?? this.relationshipNickname,
      initialMeetDate: initialMeetDate ?? this.initialMeetDate,
      partnerBirthday: partnerBirthday ?? this.partnerBirthday,
      partnerPhotoUrl: partnerPhotoUrl ?? this.partnerPhotoUrl,
      myPhotoUrl: myPhotoUrl ?? this.myPhotoUrl,
      customLoveNote: customLoveNote ?? this.customLoveNote,
      isSetupComplete: isSetupComplete ?? this.isSetupComplete,
    );
  }

  int get daysTogether {
    final now = DateTime.now();
    return now.difference(initialMeetDate).inDays;
  }

  int get daysUntilBirthday {
    final now = DateTime.now();
    DateTime nextBday = DateTime(
      now.year,
      partnerBirthday.month,
      partnerBirthday.day,
    );
    if (nextBday.isBefore(now) && !isSameDay(nextBday, now)) {
      nextBday = DateTime(
        now.year + 1,
        partnerBirthday.month,
        partnerBirthday.day,
      );
    }
    return nextBday.difference(now).inDays;
  }

  bool isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  @override
  List<Object?> get props => [
        myName,
        partnerName,
        relationshipNickname,
        initialMeetDate,
        partnerBirthday,
        partnerPhotoUrl,
        myPhotoUrl,
        customLoveNote,
        isSetupComplete,
      ];
}
