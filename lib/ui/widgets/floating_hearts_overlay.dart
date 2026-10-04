import 'dart:math';
import 'package:flutter/material.dart';

class FloatingHeartsOverlay extends StatefulWidget {
  final Widget child;
  final int heartCount;

  const FloatingHeartsOverlay({
    super.key,
    required this.child,
    this.heartCount = 12,
  });

  @override
  State<FloatingHeartsOverlay> createState() => _FloatingHeartsOverlayState();
}

class _FloatingHeartsOverlayState extends State<FloatingHeartsOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_HeartParticle> _hearts = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    for (int i = 0; i < widget.heartCount; i++) {
      _hearts.add(_HeartParticle.generate(_random));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return IgnorePointer(
              child: Stack(
                children: _hearts.map((heart) {
                  double progress = (_controller.value + heart.startOffset) % 1.0;
                  double bottom = progress * MediaQuery.of(context).size.height * 1.2 - 50;
                  double left = heart.leftRatio * MediaQuery.of(context).size.width +
                      sin(progress * pi * 4) * 20;
                  double opacity = (1.0 - progress).clamp(0.0, 0.8);

                  return Positioned(
                    bottom: bottom,
                    left: left,
                    child: Opacity(
                      opacity: opacity,
                      child: Text(
                        heart.emoji,
                        style: TextStyle(
                          fontSize: heart.size,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _HeartParticle {
  final double leftRatio;
  final double startOffset;
  final double size;
  final String emoji;

  _HeartParticle({
    required this.leftRatio,
    required this.startOffset,
    required this.size,
    required this.emoji,
  });

  factory _HeartParticle.generate(Random random) {
    const emojis = ['❤️', '💖', '💕', '💗', '🌸', '💘', '💓'];
    return _HeartParticle(
      leftRatio: random.nextDouble(),
      startOffset: random.nextDouble(),
      size: 16.0 + random.nextDouble() * 20.0,
      emoji: emojis[random.nextInt(emojis.length)],
    );
  }
}
