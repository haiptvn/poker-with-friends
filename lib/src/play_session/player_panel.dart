import 'package:flutter/material.dart';
import 'package:logging/logging.dart';


import '../cards/cards.dart';
import '../../proto/message.pb.dart' as $proto;


class PlayerPanel extends StatelessWidget {
  final _log = Logger('PlayerPanel');

  final bool isMainPlayer;
  final int  playerUiIndex;
  final $proto.PlayerStatusType state;
  final String playerName;
  final String chips;
  final $proto.Card card1;
  final $proto.Card card2;

  late final bool isEmptySlot;
  late final bool hasCards;
  late final bool isActive;

  PlayerPanel({
    super.key,
    required this.isMainPlayer,
    required this.playerUiIndex,
    required this.state,
    required this.playerName,
    required this.chips,
    required this.card1,
    required this.card2,
  }) : isEmptySlot = playerName == '',
       hasCards = card1.rank != $proto.RankType.UNSPECIFIED_RANK && card2.rank != $proto.RankType.UNSPECIFIED_RANK,
       isActive = state == $proto.PlayerStatusType.Wait4Act;

  String _cardToImagePath($proto.Card card) => 'assets/cards/${card.suit.value}_${card.rank.value + 1}.png';
  static const String _faceDownCardImagePath = 'assets/cards/0_0.png';
  String _showStatus() {
    switch (state) {
      case $proto.PlayerStatusType.Playing:
        return '';
      case $proto.PlayerStatusType.SB:
        return 'SM. BLIND';
      case $proto.PlayerStatusType.BB:
        return 'BIG BLIND';
      case $proto.PlayerStatusType.Fold:
        return 'FOLD';
      case $proto.PlayerStatusType.AllIn:
        return 'ALL IN';
      case $proto.PlayerStatusType.WINNER:
        return 'WINNER';
      case $proto.PlayerStatusType.LOSER:
        return 'LOSER';
      default:
        return '';
    }
  }
  double _getPlusIconTopAlignment() {
    switch (playerUiIndex) {
      case 0:
        return 33;
      case 1:
      case 9:
        return 37;
      default:
        return 14;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130, // Adjust width as needed
      height: 100, // Adjust height as needed
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular avatar for player image or empty slot
          isEmptySlot ?
          Positioned(
            top: _getPlusIconTopAlignment(),
            child: GestureDetector(
              onTap: () {
                _log.info('Empty slot $playerUiIndex tapped');
              },
              child:
              CircleAvatar(
                backgroundImage: const AssetImage('assets/images/avatar_plus.png'), // Player image path
                radius: 20, // Adjust size
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 4, // Border width
                    ),
                  ),
                ),
              ),
            ),
          ):
          Positioned(
            // ignore: unrelated_type_equality_checks
            top: 0,
            child: CircleAvatar(
              backgroundImage: const AssetImage('assets/images/avatar_default.png'), // Player image path
              radius: 40, // Adjust size
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isActive ? Colors.green
                    : Colors.grey, // Border color
                    width: 5, // Border width
                  ),
                ),
              ),
            ),
          ),

          // Cards
          hasCards && !isEmptySlot ? Positioned(
            top: 5,
            left: 35,
            child: SizedBox(
                width: 80, // Adjust width as needed
                height: 55, // Adjust height as needed
                child:
                // If there are two cards, display them side by side (overlapping slightly
                Stack(
                  children: [
                    Transform.rotate(
                      angle: -0.1, // Adjust the angle as needed
                      child: Image.asset(
                        isMainPlayer ? _cardToImagePath(card1): _faceDownCardImagePath,
                        width: 40, // Card width
                        height: 60, // Card height
                      ),
                    ),
                    Positioned(
                      left: 20, // Adjust the overlap distance
                      child: Transform.rotate(
                        angle: 0.1, // Adjust the angle as needed
                        child: Image.asset(
                          isMainPlayer ? _cardToImagePath(card2): _faceDownCardImagePath,
                          width: 40, // Card width
                          height: 60, // Card height
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ) : const SizedBox.shrink(),

          // Role (e.g., SM. BLIND)
          if (!isEmptySlot && _showStatus() != "")
            Positioned(
              top: 39,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Text(
                  _showStatus(),
                  style: const TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          // Player name and star count with chip
          if (!isEmptySlot)
          Positioned(
            top: 60,
            child: Container(
              decoration: BoxDecoration(
                  color: isActive? Colors.white.withOpacity(0.55)
                    : Colors.black.withOpacity(0.55), // Adjust the color as needed
                  borderRadius: BorderRadius.circular(3),
                ),
              child: Row(
                children: [
                  const SizedBox(width: 5),
                  Text(
                    playerName,
                    style: TextStyle(
                      color: isActive ? Colors.black: Colors.white.withOpacity(0.85),
                      fontSize: isActive ? 14 : 11,
                      fontWeight: isActive ? FontWeight.w800: FontWeight.normal,
                      fontFamily: 'Permanent Marker',
                      height: 1,
                    ),
                  ),
                  SizedBox(width: isActive ? 10 : 4), // Space between name and star
                  Row(
                    children: [
                      Icon(
                        Icons.menu, // Star icon
                        color: isActive ? Colors.black: Colors.white.withOpacity(0.85),
                        size: 16,
                      ),
                      Text(
                        chips,
                        style: TextStyle(
                          color: isActive ? Colors.black: Colors.white.withOpacity(0.85),
                          fontSize: isActive ? 14 : 11,
                          fontWeight: FontWeight.w500,
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
