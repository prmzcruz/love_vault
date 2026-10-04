import 'package:equatable/equatable.dart';
import '../../core/models/love_coupon.dart';

class SurpriseState extends Equatable {
  final List<LoveCoupon> coupons;
  final bool candlesBlown;
  final bool triggerConfetti;
  final String activeBirthdayWish;

  const SurpriseState({
    required this.coupons,
    required this.candlesBlown,
    required this.triggerConfetti,
    required this.activeBirthdayWish,
  });

  factory SurpriseState.initial() {
    return SurpriseState(
      coupons: LoveCoupon.defaultCoupons(),
      candlesBlown: false,
      triggerConfetti: false,
      activeBirthdayWish:
          'Happy Birthday my soulmate! May your day be filled with endless smiles, sweet kisses, and magic! 🎂✨❤️',
    );
  }

  SurpriseState copyWith({
    List<LoveCoupon>? coupons,
    bool? candlesBlown,
    bool? triggerConfetti,
    String? activeBirthdayWish,
  }) {
    return SurpriseState(
      coupons: coupons ?? this.coupons,
      candlesBlown: candlesBlown ?? this.candlesBlown,
      triggerConfetti: triggerConfetti ?? this.triggerConfetti,
      activeBirthdayWish: activeBirthdayWish ?? this.activeBirthdayWish,
    );
  }

  @override
  List<Object?> get props => [
        coupons,
        candlesBlown,
        triggerConfetti,
        activeBirthdayWish,
      ];
}
