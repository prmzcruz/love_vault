import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/couple/couple_bloc.dart';
import '../../blocs/couple/couple_state.dart';
import '../../blocs/surprise/surprise_bloc.dart';
import '../../blocs/surprise/surprise_event.dart';
import '../../blocs/surprise/surprise_state.dart';
import '../../core/models/love_coupon.dart';
import '../../core/theme/pink_theme.dart';
import '../widgets/birthday_cake_widget.dart';

class BirthdaySurpriseScreen extends StatelessWidget {
  const BirthdaySurpriseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoupleBloc, CoupleState>(
      builder: (context, coupleState) {
        final partnerName = coupleState.coupleInfo.partnerName;

        return BlocBuilder<SurpriseBloc, SurpriseState>(
          builder: (context, surpriseState) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Wish Banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: PinkTheme.romanticGradient,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: PinkTheme.primaryPink.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          '🎉 HAPPY BIRTHDAY SURPRISE 🎉',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'To my dearest $partnerName, you deserve all the love, happiness, and sweetness in the world! ❤️',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Virtual Cake Widget
                  BirthdayCakeWidget(
                    candlesBlown: surpriseState.candlesBlown,
                    onBlow: () {
                      context.read<SurpriseBloc>().add(const BlowCandlesEvent());
                      _showBirthdayWishDialog(context, partnerName, surpriseState.activeBirthdayWish);
                    },
                    onReset: () {
                      context.read<SurpriseBloc>().add(const ResetCakeCandlesEvent());
                    },
                  ),

                  const SizedBox(height: 28),

                  // Love Coupons / Surprise Gift Boxes Section
                  const Text(
                    'Birthday Love Coupons & Gifts 🎁',
                    style: TextStyle(
                      color: PinkTheme.darkMagenta,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Tap to unwrap secret birthday coupons redeemable anytime!',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 16),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: surpriseState.coupons.length,
                    itemBuilder: (context, index) {
                      final coupon = surpriseState.coupons[index];
                      return _buildCouponCard(context, coupon);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCouponCard(BuildContext context, LoveCoupon coupon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: coupon.isUnlocked
              ? PinkTheme.primaryPink.withValues(alpha: 0.3)
              : Colors.grey.shade300,
        ),
        boxShadow: [
          BoxShadow(
            color: PinkTheme.primaryPink.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: coupon.isUnlocked
                ? PinkTheme.softCardPink
                : Colors.grey.shade100,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              coupon.isUnlocked ? coupon.iconEmoji : '🎁',
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
        title: Text(
          coupon.title,
          style: TextStyle(
            color: PinkTheme.darkMagenta,
            fontWeight: FontWeight.bold,
            fontSize: 15,
            decoration:
                coupon.isRedeemed ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            coupon.isUnlocked ? coupon.subtitle : 'Locked Surprise! Tap to unlock 🔒',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ),
        trailing: coupon.isUnlocked
            ? IconButton(
                icon: Icon(
                  coupon.isRedeemed ? Icons.check_circle : Icons.favorite,
                  color: coupon.isRedeemed ? Colors.green : PinkTheme.primaryPink,
                ),
                onPressed: () {
                  _showCouponRevealDialog(context, coupon);
                },
              )
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: PinkTheme.primaryPink,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                ),
                onPressed: () {
                  context.read<SurpriseBloc>().add(UnlockCouponEvent(coupon.id));
                  _showCouponRevealDialog(context, coupon);
                },
                child: const Text('Unwrap 🎁', style: TextStyle(fontSize: 12)),
              ),
      ),
    );
  }

  void _showCouponRevealDialog(BuildContext context, LoveCoupon coupon) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Row(
            children: [
              Text(coupon.iconEmoji, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  coupon.title,
                  style: const TextStyle(
                    color: PinkTheme.darkMagenta,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                coupon.surpriseMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: PinkTheme.deepPassion,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '❤️ Redeemable anytime by showing this app! ❤️',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          actions: [
            if (!coupon.isRedeemed)
              TextButton(
                onPressed: () {
                  context.read<SurpriseBloc>().add(RedeemCouponEvent(coupon.id));
                  Navigator.pop(dialogContext);
                },
                child: const Text(
                  'Mark as Redeemed ✔️',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ElevatedButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close 💕'),
            ),
          ],
        );
      },
    );
  }

  void _showBirthdayWishDialog(BuildContext context, String name, String wish) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: const Column(
            children: [
              Text('✨ 🥳 🎂 ✨', style: TextStyle(fontSize: 32)),
              SizedBox(height: 8),
              Text(
                'Candles Blown Out!',
                style: TextStyle(
                  color: PinkTheme.darkMagenta,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          content: Text(
            'Your birthday wish for $name has been blown into the universe with infinite love! 🌟💖',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: PinkTheme.deepPassion,
              fontSize: 15,
              height: 1.4,
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Hooray! 🎉'),
              ),
            ),
          ],
        );
      },
    );
  }
}
