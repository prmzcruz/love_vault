import 'package:equatable/equatable.dart';

abstract class SurpriseEvent extends Equatable {
  const SurpriseEvent();

  @override
  List<Object?> get props => [];
}

class LoadSurprisesEvent extends SurpriseEvent {
  const LoadSurprisesEvent();
}

class UnlockCouponEvent extends SurpriseEvent {
  final String couponId;

  const UnlockCouponEvent(this.couponId);

  @override
  List<Object?> get props => [couponId];
}

class RedeemCouponEvent extends SurpriseEvent {
  final String couponId;

  const RedeemCouponEvent(this.couponId);

  @override
  List<Object?> get props => [couponId];
}

class BlowCandlesEvent extends SurpriseEvent {
  const BlowCandlesEvent();
}

class ResetCakeCandlesEvent extends SurpriseEvent {
  const ResetCakeCandlesEvent();
}
