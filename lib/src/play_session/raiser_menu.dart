import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class RaiserProvider extends ChangeNotifier {
  bool _isRaiserVisible = false;
  double _currentRaiseAmount = 0.0;

  bool get isRaiserVisible => _isRaiserVisible;
  double get currentRaiseAmount => _currentRaiseAmount;

  // Toggle the visibility of the raiser
  void toggleRaiserVisibility() {
    _isRaiserVisible = !_isRaiserVisible;
    notifyListeners();  // Notifies listeners (UI) of the state change
  }

  // Set the raise amount
  void setRaiseAmount(double amount) {
    _currentRaiseAmount = amount;
    notifyListeners();  // Notifies listeners (UI) of the state change
  }
}

class RaiseSliderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Conditionally show the slider based on the state in the provider
        if (context.watch<RaiserProvider>().isRaiserVisible)
          Container(
            height: 240,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background Shape for Raise slider
                CustomPaint(
                  size: Size(110, 340),
                  painter: RaiseBackgroundPainter(),
                ),

                // Vertical Raise Slider
                Transform.rotate(
                  angle: -pi / 2, // Rotate slider vertically
                  child: Slider(
                    value: context.watch<RaiserProvider>().currentRaiseAmount,
                    min: 0.0,
                    max: 1000.0,
                    divisions: 50, // 10 steps for the slider
                    onChanged: (double newValue) {
                      context.read<RaiserProvider>().setRaiseAmount(newValue);
                    },
                    activeColor: Colors.blue,
                    inactiveColor: Colors.white70,
                  ),
                ),

                // Display the value of the slider
                Positioned(
                  top: 5,
                  child: Text(
                    '${context.watch<RaiserProvider>().currentRaiseAmount.toInt()}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// Custom Background Painter for Raise slider
class RaiseBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xfff4f3fa).withOpacity(0.85)
      ..style = PaintingStyle.fill;

    // Create a path that starts small at the bottom and widens at the top
    final path = Path()
      ..moveTo(0, size.height * 0.15)
      ..lineTo(size.width * 0.25, size.height)
      ..lineTo(size.width * 0.75, size.height)
      ..lineTo(size.width, size.height * 0.15)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
