import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class RaiserProvider extends ChangeNotifier {
  bool _isRaiserVisible = false;
  double _currentRaiseAmount = 0.0;
  double _min = 0.0;
  double _max = 1000.0;
  int _division = 10;
  double _totalPot = 0.0;

  bool get isRaiserVisible => _isRaiserVisible;
  double get currentRaiseAmount => _currentRaiseAmount;
  int get currentRaiseAmountAsInt {
    return _currentRaiseAmount.toInt();
  }
  double get min => _min;
  double get max => _max;
  bool get isMax => _currentRaiseAmount == _max;
  int get division => _division;

  void setMinRaiseValue(int min, int max, int totalPot) {
    if (min <= 0) { min = 20; }
     _division = max~/min;
    _min = min.toDouble();
    _max = _min * (_division+1);
    _currentRaiseAmount = _min;
    _totalPot = totalPot.toDouble();
  }

  void setEqualPotValue() {
    _currentRaiseAmount = _totalPot.toDouble();
    if (_currentRaiseAmount < _min) {
      _currentRaiseAmount = _min;
    } else {
      _currentRaiseAmount = (_currentRaiseAmount ~/ 10) * 10;
    }
    notifyListeners();
  }

  void setThreeQuarterPotValue() {
    _currentRaiseAmount = _totalPot.toDouble() * 0.75;
    if (_currentRaiseAmount < _min) {
      _currentRaiseAmount = _min;
    } else {
      _currentRaiseAmount = (_currentRaiseAmount ~/ 10) * 10;
    }
    notifyListeners();
  }

  void setHalfPotValue() {
    _currentRaiseAmount = _totalPot.toDouble() / 2;
    if (_currentRaiseAmount < _min) {
      _currentRaiseAmount = _min;
    } else {
      _currentRaiseAmount = (_currentRaiseAmount ~/ 10) * 10;
    }
    notifyListeners();
  }

  void incrementRaiseAmount() {
    if (_currentRaiseAmount < _max) {
      _currentRaiseAmount += _min;
      notifyListeners();
    }
  }

  void decrementRaiseAmount() {
    if (_currentRaiseAmount > _min) {
      _currentRaiseAmount -= _min;
      notifyListeners();
    }
  }

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
  const RaiseSliderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      if (context.watch<RaiserProvider>().isRaiserVisible)
      Column(
        children: [
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: () {
              context.read<RaiserProvider>().setEqualPotValue();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xfff4f3fa).withOpacity(0.85),
              textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            child: const Text('POT'),
          ),
          const SizedBox(height: 2),
          ElevatedButton(
            onPressed: () {
              context.read<RaiserProvider>().setThreeQuarterPotValue();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xfff4f3fa).withOpacity(0.85),
              textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            child: const Text('3/4'),
          ),
          const SizedBox(height: 2),
          ElevatedButton(
            onPressed: () {
              context.read<RaiserProvider>().setHalfPotValue();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xfff4f3fa).withOpacity(0.85),
              textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            child: const Text('1/2'),
          ),
          const SizedBox(height: 2),
          // Button +
          Positioned(bottom: 50, left: 0, width: 50,
            child: ElevatedButton(
              onPressed: () {
                context.read<RaiserProvider>().incrementRaiseAmount();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xfff4f3fa).withOpacity(0.85),
                textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              child: const Text('+'),
            ),
          ),
          const SizedBox(height: 2),
          // Button -
          Positioned(bottom: 0, left: 0, width: 55,
          child: ElevatedButton(
              onPressed: () {
                context.read<RaiserProvider>().decrementRaiseAmount();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xfff4f3fa).withOpacity(0.85),
                textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              child: const Text('-'),
            ),
          ),
        ],
      ),
      const SizedBox(width: 10),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Toggle the raiser slider visibility using the Provider
          context.watch<RaiserProvider>().isRaiserVisible ? ElevatedButton(
            onPressed: () {
              context.read<RaiserProvider>().toggleRaiserVisibility();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:  const Color(0xfff4f3fa).withOpacity(0.85),
              textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12
            ),
            child: const Text('CANCEL'),
          ): const SizedBox.shrink(),

          // Conditionally show the slider based on the state in the provider
          if (context.watch<RaiserProvider>().isRaiserVisible)
            SizedBox(
              height: 250,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background Shape for Raise slider
                  CustomPaint(
                    size: const Size(100, 240),
                    painter: RaiseBackgroundPainter(),
                  ),

                  SizedBox(
                    height: 200,
                    width: 100,
                    child: // Vertical Raise Slider
                    RotatedBox(
                      quarterTurns: 3, // Rotate slider vertically
                      child: Slider(
                        value: context.watch<RaiserProvider>().currentRaiseAmount,
                        min: context.watch<RaiserProvider>().min,
                        max:context.watch<RaiserProvider>().max,
                        divisions: context.watch<RaiserProvider>().division, // 9 steps for the slider
                        onChanged: (double newValue) {
                          context.read<RaiserProvider>().setRaiseAmount(newValue);
                        },
                        activeColor: Colors.green,
                        inactiveColor: Colors.white70,
                      ),
                    ),
                  ),

                  // Display the value of the slider
                  Positioned(
                    top: 10,
                    child: Text(
                      context.watch<RaiserProvider>().isMax ? 'ALL IN' : '${context.watch<RaiserProvider>().currentRaiseAmount.toInt()}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ]);
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
