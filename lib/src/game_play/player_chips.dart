import 'dart:math';
import 'package:flutter/material.dart';

class ChipTextAnimation extends StatefulWidget {
  final int previous;
  final int value;
  final Duration duration;

  const ChipTextAnimation({super.key,
    required this.previous,
    required this.value,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  _ChipTextAnimationState createState() => _ChipTextAnimationState();
}

class _ChipTextAnimationState extends State<ChipTextAnimation> {
  @override
  Widget build(BuildContext context) {
    debugPrint('ChipTextAnimation build: previous=${widget.previous} value=${widget.value}');

    if (widget.previous == widget.value) {
      debugPrint('ChipTextAnimation build: value=${widget.value} is same as previous');
      return Text(
          widget.previous.toString(),
          style: TextStyle(color: Colors.white.withOpacity(0.85),
              fontSize: 10,
              fontWeight: FontWeight.w500,
              fontFamily: 'Permanent Marker',
              height: 1.6
          ),
        );
    }

    final diff = (widget.value - widget.previous).abs();
    final digitCount = (widget.value - widget.previous).abs().toString().length;
    final baseValue = (widget.value ~/ pow(10, digitCount)) * pow(10, digitCount).toInt();

    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: baseValue, end: widget.value),
      duration: widget.duration,
      builder: (context, value, child) {
        // Create a random number rolling effect
        final randomValue = baseValue + Random().nextInt(diff);
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