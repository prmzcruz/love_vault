import 'package:flutter_bloc/flutter_bloc.dart';
import 'couple_event.dart';
import 'couple_state.dart';

class CoupleBloc extends Bloc<CoupleEvent, CoupleState> {
  CoupleBloc() : super(CoupleState.initial()) {
    on<LoadCoupleInfoEvent>(_onLoadCoupleInfo);
    on<CompleteOnboardingEvent>(_onCompleteOnboarding);
    on<UpdatePartnerPhotoEvent>(_onUpdatePartnerPhoto);
    on<UpdateCoupleNamesEvent>(_onUpdateCoupleNames);
    on<UpdateImportantDatesEvent>(_onUpdateImportantDates);
    on<UpdateCustomNoteEvent>(_onUpdateCustomNote);
  }

  void _onLoadCoupleInfo(
    LoadCoupleInfoEvent event,
    Emitter<CoupleState> emit,
  ) {
    emit(state.copyWith(status: CoupleStatus.loaded));
  }

  void _onCompleteOnboarding(
    CompleteOnboardingEvent event,
    Emitter<CoupleState> emit,
  ) {
    final updatedInfo = state.coupleInfo.copyWith(
      myName: event.myName,
      partnerName: event.partnerName,
      myPhotoUrl: event.myPhotoUrl,
      partnerPhotoUrl: event.partnerPhotoUrl,
      relationshipNickname: event.nickname,
      initialMeetDate: event.initialMeetDate,
      partnerBirthday: event.partnerBirthday,
      isSetupComplete: true,
    );
    emit(state.copyWith(status: CoupleStatus.loaded, coupleInfo: updatedInfo));
  }

  void _onUpdatePartnerPhoto(
    UpdatePartnerPhotoEvent event,
    Emitter<CoupleState> emit,
  ) {
    final updatedInfo = event.isMyPhoto
        ? state.coupleInfo.copyWith(myPhotoUrl: event.photoUrl)
        : state.coupleInfo.copyWith(partnerPhotoUrl: event.photoUrl);
    emit(state.copyWith(coupleInfo: updatedInfo));
  }

  void _onUpdateCoupleNames(
    UpdateCoupleNamesEvent event,
    Emitter<CoupleState> emit,
  ) {
    final updatedInfo = state.coupleInfo.copyWith(
      myName: event.myName,
      partnerName: event.partnerName,
      relationshipNickname: event.nickname,
    );
    emit(state.copyWith(coupleInfo: updatedInfo));
  }

  void _onUpdateImportantDates(
    UpdateImportantDatesEvent event,
    Emitter<CoupleState> emit,
  ) {
    final updatedInfo = state.coupleInfo.copyWith(
      initialMeetDate: event.initialMeetDate,
      partnerBirthday: event.partnerBirthday,
    );
    emit(state.copyWith(coupleInfo: updatedInfo));
  }

  void _onUpdateCustomNote(
    UpdateCustomNoteEvent event,
    Emitter<CoupleState> emit,
  ) {
    final updatedInfo = state.coupleInfo.copyWith(
      customLoveNote: event.note,
    );
    emit(state.copyWith(coupleInfo: updatedInfo));
  }
}
