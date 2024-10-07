import 'package:flutter/material.dart';

class DealerIcon extends StatelessWidget {
  // List of 9 specific positions (x, y coordinates)
  final List<Offset> positions = [
    const Offset(-45, 25), // main
    const Offset(-165, 20),   // player 1
    const Offset(-220, -20),    // player 2 x
    const Offset(-210, -100),  // player 3 x
    const Offset(-162, -107),   // player 4
    const Offset(-42, -108),    // player 5
    const Offset(90, -107),    // player 6
    const Offset(190, -100), // player 7 x
    const Offset(205, -20),   // player 8 x
    const Offset(90, 25),  // player 9
  ];
  final int currentIndex;

  DealerIcon({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height / 2 + positions[currentIndex].dy,
          left: MediaQuery.of(context).size.width / 2 + positions[currentIndex].dx,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.transparent, width: 2),
            ),
            child: ClipOval(
              child: Image.asset('assets/images/dealer-icon.png'),
            ),
          ),
        ),
      ],
    );
  }
}
