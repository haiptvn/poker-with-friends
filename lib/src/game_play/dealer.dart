import 'package:flutter/material.dart';

class DealerIcon extends StatelessWidget {
  // List of 9 specific positions (x, y coordinates)
  final List<Offset> positions = [
    const Offset(350, 260), // main
    const Offset(220, 250), // player 1
    const Offset(180, 230), // player 2
    const Offset(180, 125), // player 3
    const Offset(220, 95),  // player 4
    const Offset(350, 90), // player 5
    const Offset(530, 90), // player 6
    const Offset(610, 125), // player 7
    const Offset(610, 230), // player 8
    const Offset(510, 260), // player 9
  ];

  final int currentIndex;

  DealerIcon({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: positions[currentIndex].dx,
          top: positions[currentIndex].dy,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.transparent, width: 2),
            ),
            child: ClipOval(
              child: Image.asset('assets/images/dealer.png'),
            ),
          ),
        ),
      ],
    );
  }
}
