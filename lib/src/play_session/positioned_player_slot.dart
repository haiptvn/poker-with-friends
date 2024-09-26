import 'package:flutter/material.dart';


import '../cards/cards.dart';


class PlayerPanel extends StatelessWidget {
  final String state;
  final String playerName;
  final String chips;
  final bool active = false;
  final bool showCards;

  PlayerPanel({
    super.key,
    required this.state,
    required this.playerName,
    required this.chips,
    required this.showCards,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 172, // Adjust width as needed
      height: 100, // Adjust height as needed
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // Player 2 cards
          showCards ? Positioned(
            top: 10,
            left: 85,
            child: Container(
              width: 80, // Adjust width as needed
              height: 55, // Adjust height as needed
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7), // Adjust the color as needed
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  const SizedBox(height: 5),
                  Image.asset(
                    'assets/cards/1_7.png',
                    width: 40, // Card width
                    height: 60, // Card height
                  ),
                  Image.asset(
                    'assets/cards/4_2.png',
                    width: 40, // Card width
                    height: 60, // Card height
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ) : const SizedBox.shrink(),

          // Circular avatar for player image
          Positioned(
            top: 0,
            child: CircleAvatar(
              backgroundImage: AssetImage( playerName != '' ? 'assets/images/avatar_default.png'
              : 'assets/images/avatar_empty.png'), // Player image path
              radius: 40, // Adjust size
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: active ? Colors.lightGreen : Colors.grey, // Border color
                    width: 5, // Border width
                  ),
                ),
              ),
            ),
          ),

          // Role (e.g., SM. BLIND)
          if (state != "")
            Positioned(
              top: 43,
              left: 8,
              child: Container(
                color: Colors.black.withOpacity(0.7),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Text(
                  state,
                  style: const TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          // Player name and star count with chip
          if (playerName != "" && chips != "")
          Positioned(
            top: 64,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7), // Adjust the color as needed
                  borderRadius: BorderRadius.circular(5),
                ),
              child: Row(
                children: [
                  const SizedBox(width: 5),
                  Text(
                    playerName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Permanent Marker',
                      height: 1,
                    ),
                  ),
                  const SizedBox(width: 8), // Space between name and star
                  Row(
                    children: [
                      const Icon(
                        Icons.catching_pokemon_sharp, // Star icon
                        color: Colors.white,
                        size: 14,
                      ),
                      Text(
                        chips,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Permanent Marker',
                          height: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
