import 'package:flutter/material.dart';
import '../../core/theme/pink_theme.dart';

class BirthdayCakeWidget extends StatefulWidget {
  final bool candlesBlown;
  final VoidCallback onBlow;
  final VoidCallback onReset;

  const BirthdayCakeWidget({
    super.key,
    required this.candlesBlown,
    required this.onBlow,
    required this.onReset,
  });

  @override
  State<BirthdayCakeWidget> createState() => _BirthdayCakeWidgetState();
}

class _BirthdayCakeWidgetState extends State<BirthdayCakeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _flickerController;

  @override
  void initState() {
    super.initState();
    _flickerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _flickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: PinkTheme.primaryPink.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: PinkTheme.primaryPink.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Virtual Birthday Cake 🎂',
            style: TextStyle(
              color: PinkTheme.darkMagenta,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.candlesBlown
                ? '✨ Make a wish! Your candles are blown! ✨'
                : 'Tap "Blow Candles" to make your birthday wish! 🕯️',
            style: TextStyle(
              color: widget.candlesBlown
                  ? PinkTheme.primaryPink
                  : Colors.grey.shade600,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          // Candle flames row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    if (!widget.candlesBlown)
                      AnimatedBuilder(
                        animation: _flickerController,
                        builder: (context, child) {
                          return Container(
                            width: 14 + _flickerController.value * 4,
                            height: 22 + _flickerController.value * 4,
                            decoration: BoxDecoration(
                              gradient: const RadialGradient(
                                colors: [
                                  Colors.yellowAccent,
                                  Colors.orange,
                                  Colors.transparent,
                                ],
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.orange.withValues(alpha: 0.8),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    else
                      Container(
                        width: 10,
                        height: 18,
                        alignment: Alignment.center,
                        child: const Text(
                          '💨',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    const SizedBox(height: 2),
                    // Candle stick
                    Container(
                      width: 8,
                      height: 32,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            PinkTheme.accentRose,
                            PinkTheme.primaryPink,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 4),
          // Cake Top Tier
          Container(
            width: 160,
            height: 36,
            decoration: BoxDecoration(
              color: PinkTheme.softCardPink,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
              border: Border.all(
                color: PinkTheme.primaryPink.withValues(alpha: 0.3),
              ),
            ),
            alignment: Alignment.center,
            child: const Text(
              '🍓 🍓 🍓',
              style: TextStyle(fontSize: 14),
            ),
          ),
          // Cake Bottom Tier
          Container(
            width: 220,
            height: 50,
            decoration: BoxDecoration(
              gradient: PinkTheme.romanticGradient,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: PinkTheme.primaryPink.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Text(
              'HAPPY BIRTHDAY MY LOVE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
                letterSpacing: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: widget.candlesBlown ? widget.onReset : widget.onBlow,
            icon: Icon(
              widget.candlesBlown ? Icons.refresh : Icons.air,
              size: 20,
            ),
            label: Text(
              widget.candlesBlown ? 'Relight Candles 🕯️' : 'Blow Candles! 💨',
            ),
          ),
        ],
      ),
    );
  }
}
