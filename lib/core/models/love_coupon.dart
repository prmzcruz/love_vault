import 'package:equatable/equatable.dart';

class LoveCoupon extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String surpriseMessage;
  final String iconEmoji;
  final bool isUnlocked;
  final bool isRedeemed;

  const LoveCoupon({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.surpriseMessage,
    required this.iconEmoji,
    this.isUnlocked = false,
    this.isRedeemed = false,
  });

  LoveCoupon copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? surpriseMessage,
    String? iconEmoji,
    bool? isUnlocked,
    bool? isRedeemed,
  }) {
    return LoveCoupon(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      surpriseMessage: surpriseMessage ?? this.surpriseMessage,
      iconEmoji: iconEmoji ?? this.iconEmoji,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      isRedeemed: isRedeemed ?? this.isRedeemed,
    );
  }

  static List<LoveCoupon> defaultCoupons() {
    return [
      const LoveCoupon(
        id: 'cpn_1',
        title: 'Romantic Candlelight Dinner 🍽️',
        subtitle: 'Valid for a homemade or dream restaurant dinner',
        surpriseMessage:
            'Surprise! I am cooking your absolute favorite dish (or taking you to your favorite spot) with candlelights & sweet music! 🕯️❤️',
        iconEmoji: '🕯️',
        isUnlocked: true,
      ),
      const LoveCoupon(
        id: 'cpn_2',
        title: 'Unlimited Hugs & Kisses 💋',
        subtitle: 'Redeemable anytime, anywhere, 24/7!',
        surpriseMessage:
            'You get 1,000 warm bear hugs and soft kisses whenever you want! No expiration date ever! 🤗💖',
        iconEmoji: '🤗',
        isUnlocked: true,
      ),
      const LoveCoupon(
        id: 'cpn_3',
        title: 'Movie Night & Popcorn Master 🍿',
        subtitle: 'You choose the movie, I get the snacks!',
        surpriseMessage:
            'Tonight you get total control of the remote! Any movie you want, cozy blankets, and warm popcorn ready! 🎬✨',
        iconEmoji: '🍿',
        isUnlocked: false,
      ),
      const LoveCoupon(
        id: 'cpn_4',
        title: 'Relaxing Head & Foot Massage 💆‍♀️',
        subtitle: '30 mins of blissful pampering session',
        surpriseMessage:
            'Sit back and relax! Enjoy a gentle, soothing massage with scented oils and soft calming music. 🌸✨',
        iconEmoji: '💆‍♀️',
        isUnlocked: false,
      ),
      const LoveCoupon(
        id: 'cpn_5',
        title: 'Secret Birthday Surprise Gift 🎁',
        subtitle: 'Tap to unlock your special surprise box!',
        surpriseMessage:
            'Happy Birthday My Love! Your grand birthday gift is waiting for you! You are the greatest gift in my life! 🎉🎂💖',
        iconEmoji: '🎁',
        isUnlocked: false,
      ),
    ];
  }

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        surpriseMessage,
        iconEmoji,
        isUnlocked,
        isRedeemed,
      ];
}
