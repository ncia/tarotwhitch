import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class SpillingLikeButton extends StatefulWidget {
  final Widget child; // The actual Like button/icon/text to wrap
  final bool isEnabled;

  const SpillingLikeButton({
    super.key,
    required this.child,
    this.isEnabled = true,
  });

  @override
  State<SpillingLikeButton> createState() => _SpillingLikeButtonState();
}

class _SpillingLikeButtonState extends State<SpillingLikeButton> with TickerProviderStateMixin {
  final List<_FloatingHeart> _hearts = [];
  final Random _random = Random();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.isEnabled) {
      _startAmbientSpill();
    }
  }

  @override
  void didUpdateWidget(SpillingLikeButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isEnabled && !oldWidget.isEnabled) {
      _startAmbientSpill();
    } else if (!widget.isEnabled && oldWidget.isEnabled) {
      _timer?.cancel();
    }
  }

  void _startAmbientSpill() {
    // Periodically spawn a heart to induce clicking
    // The delay is random so it feels natural, e.g., every 1.5 to 3.5 seconds
    _scheduleNextSpill();
  }

  void _scheduleNextSpill() {
    if (!mounted || !widget.isEnabled) return;
    
    final delay = Duration(milliseconds: 1500 + _random.nextInt(2000));
    _timer = Timer(delay, () {
      if (mounted) {
        _spawnAmbientHeart();
        _scheduleNextSpill();
      }
    });
  }

  void _spawnAmbientHeart() {
    // Only spawn 1 or 2 hearts at a time to not overwhelm the UI
    int count = _random.nextInt(100) < 30 ? 2 : 1; // 30% chance for 2 hearts
    
    for (int i = 0; i < count; i++) {
      final controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1500 + _random.nextInt(1500)),
      );
      
      final heart = _FloatingHeart(
        controller: controller,
        startX: -5.0 + _random.nextDouble() * 20, // Spawn near the left side (where the heart icon is)
        targetX: -15.0 + _random.nextDouble() * 40, // Drift slightly left or right
        targetY: 40 + _random.nextDouble() * 60, // Float upwards by 40-100 pixels
        size: 10 + _random.nextDouble() * 8, // Size between 10-18
        color: Colors.pinkAccent.withOpacity(0.5 + _random.nextDouble() * 0.4), // Slightly transparent
      );
      
      setState(() {
        _hearts.add(heart);
      });
      
      controller.forward().then((_) {
        if (mounted) {
          setState(() {
            _hearts.remove(heart);
          });
        }
        controller.dispose();
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var heart in _hearts) {
      heart.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.centerLeft,
      children: [
        widget.child, // The base layout
        
        ..._hearts.map((heart) {
          return AnimatedBuilder(
            animation: heart.controller,
            builder: (context, child) {
              final progress = heart.controller.value;
              
              // Apply easing to the upward movement
              final curve = Curves.easeOut.transform(progress);
              
              final y = heart.targetY * curve;
              
              // Add a gentle sinusoidal horizontal wobble
              final wobble = sin(progress * pi * 3) * 8;
              final x = heart.startX + (heart.targetX * progress) + wobble;
              
              // Fade out smoothly in the second half of the animation
              final opacity = progress > 0.5 ? 1.0 - ((progress - 0.5) * 2) : 1.0;
              
              return Positioned(
                left: x,
                bottom: 8 + y, // Starting slightly above the bottom alignment
                child: Opacity(
                  opacity: opacity,
                  child: Icon(
                    Icons.favorite,
                    color: heart.color,
                    size: heart.size,
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}

class _FloatingHeart {
  final AnimationController controller;
  final double startX;
  final double targetX;
  final double targetY;
  final double size;
  final Color color;

  _FloatingHeart({
    required this.controller,
    required this.startX,
    required this.targetX,
    required this.targetY,
    required this.size,
    required this.color,
  });
}
