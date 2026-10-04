import 'package:flutter_bloc/flutter_bloc.dart';
import 'surprise_event.dart';
import 'surprise_state.dart';

class SurpriseBloc extends Bloc<SurpriseEvent, SurpriseState> {
  SurpriseBloc() : super(SurpriseState.initial()) {
    on<LoadSurprisesEvent>(_onLoadSurprises);
    on<UnlockCouponEvent>(_onUnlockCoupon);
    on<RedeemCouponEvent>(_onRedeemCoupon);
    on<BlowCandlesEvent>(_onBlowCandles);
    on<ResetCakeCandlesEvent>(_onResetCakeCandles);
  }

  void _onLoadSurprises(
    LoadSurprisesEvent event,
    Emitter<SurpriseState> emit,
  ) {
    // Keep current state or reset if needed
  }

  void _onUnlockCoupon(
    UnlockCouponEvent event,
    Emitter<SurpriseState> emit,
  ) {
    final updatedList = state.coupons.map((c) {
      if (c.id == event.couponId) {
        return c.copyWith(isUnlocked: true);
      }
      return c;
    }).toList();
    emit(state.copyWith(coupons: updatedList, triggerConfetti: true));
  }

  void _onRedeemCoupon(
    RedeemCouponEvent event,
    Emitter<SurpriseState> emit,
  ) {
    final updatedList = state.coupons.map((c) {
      if (c.id == event.couponId) {
        return c.copyWith(isRedeemed: true);
      }
      return c;
    }).toList();
    emit(state.copyWith(coupons: updatedList));
  }

  void _onBlowCandles(
    BlowCandlesEvent event,
    Emitter<SurpriseState> emit,
  ) {
    emit(state.copyWith(
      candlesBlown: true,
      triggerConfetti: true,
    ));
  }

  void _onResetCakeCandles(
    ResetCakeCandlesEvent event,
    Emitter<SurpriseState> emit,
  ) {
    emit(state.copyWith(
      candlesBlown: false,
      triggerConfetti: false,
    ));
  }
}
