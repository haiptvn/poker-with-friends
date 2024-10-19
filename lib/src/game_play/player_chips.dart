import 'dart:math';
import 'package:flutter/material.dart';

class ChipTextAnimation extends StatefulWidget {
  final int value;
  final Duration duration;

  const ChipTextAnimation({super.key,
    required this.value,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  _ChipTextAnimationState createState() => _ChipTextAnimationState();
}

class _ChipTextAnimationState extends State<ChipTextAnimation> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin:(widget.value ~/ 10), end: widget.value),
      duration: widget.duration,
      builder: (context, value, child) {
        // Create a random number rolling effect
        final randomValue = Random().nextInt(widget.value + 100);
        final displayedValue = (value == widget.value)
            ? widget.value // When animation ends, show the final value
            : randomValue;    // Show random values during the animation

        return Text(
          '$displayedValue',
          style: TextStyle(color: Colors.white.withOpacity(0.85),
              fontSize: 10,
              fontWeight: FontWeight.w500,
              fontFamily: 'Permanent Marker',
              height: 1.6
          ),
        );
      },
      onEnd: () {
        // Optionally, handle the end of the animation if needed
      },
    );
  }
}