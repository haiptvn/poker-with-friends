import 'package:flutter/material.dart';


// A widget to position player slots around the poker table
class PositionedPlayerSlot extends StatelessWidget {
  final double top;
  final double left;
  final double right;
  final int playerNumber;

  const PositionedPlayerSlot({
    Key? key,
    required this.top,
    this.left = 0,
    this.right = 0,
    required this.playerNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Column(
        children: [
          // Player avatar
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.green.shade700,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Colors.brown, width: 3),
            ),
            child: Text(
              'P$playerNumber',
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}