import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import '../../proto/message.pb.dart' as proto;
import '../network_agent/network_agent.dart';
import '../game_internals/poker_game_state.dart';
import '../audio/audio_controller.dart';
import '../audio/sounds.dart';


class PlayerPanel extends StatelessWidget {
  final _log = Logger('PlayerPanel');

  final bool isMainPlayer;
  final int  playerUiIndex;
  final proto.PlayerStatusType state;
  final String playerName;
  final String chips;
  final proto.Card card1;
  final proto.Card card2;

  late final bool isEmptySlot;
  late final bool hasCards;
  late final bool isActive;

  final String? handRank;
  final bool? isShowHand;

  PlayerPanel({
    this.handRank,
    this.isShowHand,
    super.key,
    required this.isMainPlayer,
    required this.playerUiIndex,
    required this.state,
    required this.playerName,
    required this.chips,
    required this.card1,
    required this.card2,
  }) : isEmptySlot = playerName == '',
       hasCards = card1.rank != proto.RankType.UNSPECIFIED_RANK && card2.rank != proto.RankType.UNSPECIFIED_RANK,
       isActive = state == proto.PlayerStatusType.Wait4Act;

  String _cardToImagePath(proto.Card card) => 'assets/cards/${card.suit.value}_${card.rank.value + 1}.png';
  static const String _faceDownCardImagePath = 'assets/cards/0_0.png';
  String _convertHandRankToStatus() {
    // Check if contains a substring to determine the status
    if(handRank!.contains('HIGH CARD')) {
        return  'HIGH CARD';
    } else if (handRank!.contains('ONE PAIR')) {
        return 'PAIR';
    } else if (handRank!.contains('TWO PAIR')) {
        return 'TWO PAIR';
    } else if (handRank!.contains('THREE OF A KIND')) {
        return 'THREE OF A KIND';
    } else if (handRank!.contains('STRAIGHT')) {
        return 'STRAIGHT';
    } else if (handRank!.contains('FLUSH')) {
        return 'FLUSH';
    } else if (handRank!.contains('FULL HOUSE')) {
        return 'FULL HOUSE';
    } else if (handRank!.contains('FOUR OF A KIND')) {
        return 'FOUR OF A KIND';
    } else if (handRank!.contains('STRAIGHT FLUSH')) {
        return 'STRAIGHT FLUSH';
    } else if (handRank!.contains('ROYAL FLUSH')) {
        return 'ROYAL FLUSH';
    } else {
      return "WINNER";
    }
  }
  String _showStatus() {
    switch (state) {
      case proto.PlayerStatusType.SB:
        return 'SM. BLIND';
      case proto.PlayerStatusType.BB:
        return 'BIG BLIND';
      case proto.PlayerStatusType.Check:
        return 'CHECK';
      case proto.PlayerStatusType.Call:
        return 'CALL';
      case proto.PlayerStatusType.Raise:
        return 'RAISE';
      case proto.PlayerStatusType.Fold:
        return 'FOLD';
      case proto.PlayerStatusType.AllIn:
        return 'ALL IN';
      case proto.PlayerStatusType.WINNER:
        return _convertHandRankToStatus();
      case proto.PlayerStatusType.Sat_Out:
        return 'SAT OUT';
      case proto.PlayerStatusType.Spectating:
        return '...';
      default:
        return '';
    }
  }
  bool _needShowStatus() {
    switch (state) {
      case proto.PlayerStatusType.Wait4Act:
      case proto.PlayerStatusType.Playing:
      case proto.PlayerStatusType.Spectating:
      case proto.PlayerStatusType.Ready:
      case proto.PlayerStatusType.LOSER:
        return false;
      default:
        return true;
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
  bool _shouldShowCard() {
    switch (state) {
      case proto.PlayerStatusType.Spectating:
      case proto.PlayerStatusType.Sat_Out:
      case proto.PlayerStatusType.Fold:
      case proto.PlayerStatusType.Ready:
      // case proto.PlayerStatusType.LOSER:
        return false;
      default:
        return true;
    }
  }
  void _handleSelectingSlot(NetworkAgent networkAgent,PokerGameStateProvider gameState, int selectedSlot) {
    final requestedSlot = (selectedSlot+gameState.playerMainIndex) % gameState.maxPlayers;
    _log.info('Empty slot $selectedSlot tapped, Requested slot: $requestedSlot');
    final joinGameMsg = proto.ClientMessage()
      ..joinGame = proto.JoinGame()
      ..joinGame.chooseSlot = requestedSlot;
    gameState.setPlayerMainIndex(requestedSlot); // Todo: Update the playerMainIndex in the rx gameState
    networkAgent.sendMessageAsync(joinGameMsg.writeToBuffer());
  }

  @override
  Widget build(BuildContext context) {
    final networkAgent = context.read<NetworkAgent>();
    final gameState = context.read<PokerGameStateProvider>();
    final audioController = context.read<AudioController>();

    if (isMainPlayer) {
      _log.info('Main player: $playerName, $playerUiIndex, $state, $chips, $hasCards, $card1, $card2');
    }
    // _log.info('PlayerPanel: $playerName, $playerUiIndex, $state, $chips, $hasCards, $card1, $card2');

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
                if (gameState.hasPlayerMainIndex) {
                  _log.info('Player already in slot ${gameState.playerMainIndex}');
                  return;
                }
                audioController.playSfx(SfxType.btnTap);
                _handleSelectingSlot(networkAgent, gameState, playerUiIndex);
              },
              child: !gameState.hasPlayerMainIndex ?
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
              ): const SizedBox.shrink(),
            ),
          ):
          Positioned(
            // ignore: unrelated_type_equality_checks
            top: 0,
            child: CircleAvatar(
              backgroundImage: const AssetImage('assets/images/avatar_default.png'), // Player image path
              radius: 34, // Adjust size
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
          !isEmptySlot && _shouldShowCard() ? Positioned(
            top: 0,
            left: (isShowHand ?? false) ? 30 : 35,
            child: SizedBox(
                width: 80, // Adjust width as needed
                height: 55, // Adjust height as needed
                child:
                // If there are two cards, display them side by side (overlapping slightly
                Stack(
                  children: [
                    Transform.rotate(
                      angle: (isShowHand ?? false) ? 0 : -0.1, // Adjust the angle as needed
                      child: Image.asset(
                        hasCards ? _cardToImagePath(card1): _faceDownCardImagePath,
                        width: 40, // Card width
                        height: 60, // Card height
                      ),
                    ),
                    Positioned(
                      top : (isShowHand ?? false) ?- 2.5 : 0,
                      left: (isShowHand ?? false) ? 30 : 20, // Adjust the overlap distance
                      child: Transform.rotate(
                        angle: (isShowHand ?? false) ? 0 : 0.1, // Adjust the angle as needed
                        child: Image.asset(
                          hasCards ? _cardToImagePath(card2): _faceDownCardImagePath,
                          width: 40, // Card width
                          height: 60, // Card height
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ) : const SizedBox.shrink(),

          // Role/Action (e.g., SM. BLIND, BIG BLIND, CHECK, CALL, RAISE, FOLD, ALL IN, WINNER, LOSER)
          if (!isEmptySlot && _needShowStatus())
            Positioned(
              top: 32, // 35
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
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          // Player name and star count with chip
          if (!isEmptySlot)
          Positioned(
            top: 52, // 55
            child: Container(
              decoration: BoxDecoration(
                  color: isActive? Colors.green
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
                      fontSize: isActive ? 12 : 11,
                      fontWeight: isActive ? FontWeight.w800: FontWeight.normal,
                      fontFamily: 'Permanent Marker',
                      height: 1,
                    ),
                  ),
                  SizedBox(width: isActive ? 6 : 4), // Space between name and star
                  Row(
                    children: [
                      Image.asset(
                        color: isActive ? Colors.black: Colors.white.withOpacity(0.85),
                        'assets/images/chip.png',
                        width: 10,
                        height: 10,
                      ),
                      const SizedBox(width: 1),
                      Text(
                        chips,
                        style: TextStyle(
                          color: isActive ? Colors.black: Colors.white.withOpacity(0.85),
                          fontSize: isActive ? 12 : 11,
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
