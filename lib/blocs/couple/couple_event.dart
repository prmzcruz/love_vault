import 'package:equatable/equatable.dart';

abstract class CoupleEvent extends Equatable {
  const CoupleEvent();

  @override
  List<Object?> get props => [];
}

class LoadCoupleInfoEvent extends CoupleEvent {
  const LoadCoupleInfoEvent();
}

class CompleteOnboardingEvent extends CoupleEvent {
  final String myName;
  final String partnerName;
  final String? myPhotoUrl;
  final String? partnerPhotoUrl;
  final String nickname;
  final DateTime initialMeetDate;
  final DateTime partnerBirthday;

  const CompleteOnboardingEvent({
    required this.myName,
    required this.partnerName,
    this.myPhotoUrl,
    this.partnerPhotoUrl,
    required this.nickname,
    required this.initialMeetDate,
    required this.partnerBirthday,
  });

  @override
  List<Object?> get props => [
        myName,
        partnerName,
        myPhotoUrl,
        partnerPhotoUrl,
        nickname,
        initialMeetDate,
        partnerBirthday,
      ];
}

class UpdatePartnerPhotoEvent extends CoupleEvent {
  final bool isMyPhoto;
  final String photoUrl;

  const UpdatePartnerPhotoEvent({
    required this.isMyPhoto,
    required this.photoUrl,
  });

  @override
  List<Object?> get props => [isMyPhoto, photoUrl];
}

class UpdateCoupleNamesEvent extends CoupleEvent {
  final String myName;
  final String partnerName;
  final String nickname;

  const UpdateCoupleNamesEvent({
    required this.myName,
    required this.partnerName,
    required this.nickname,
  });

  @override
  List<Object?> get props => [myName, partnerName, nickname];
}

class UpdateImportantDatesEvent extends CoupleEvent {
  final DateTime initialMeetDate;
  final DateTime partnerBirthday;

  const UpdateImportantDatesEvent({
    required this.initialMeetDate,
    required this.partnerBirthday,
  });

  @override
  List<Object?> get props => [initialMeetDate, partnerBirthday];
}

class UpdateCustomNoteEvent extends CoupleEvent {
  final String note;

  const UpdateCustomNoteEvent(this.note);

  @override
  List<Object?> get props => [note];
}
