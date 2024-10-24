import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:poker_with_friends/src/game_play/glow_container.dart';
import 'package:poker_with_friends/src/game_play/player_chips.dart';
import 'package:provider/provider.dart';

import '../../proto/message.pb.dart' as proto;
import '../network_agent/network_agent.dart';
import '../game_internals/poker_game_state.dart';
import '../audio/audio_controller.dart';
import '../audio/sounds.dart';


class PlayerPanel extends StatelessWidget {
  final _log = Logger('PlayerPanel');

  final int  playerUiIndex;
  late final bool isMainPlayer;

  PlayerPanel({
    super.key,
    required this.playerUiIndex,
  }) : isMainPlayer = playerUiIndex == 0;

  String _cardToImagePath(proto.Card card) => 'assets/cards/${card.suit.value}_${card.rank.value + 1}.png';
  static const String _faceDownCardImagePath = 'assets/cards/0_0.png';
  String _convertHandRankToStatus(String? handRank) {
    // Check if contains a substring to determine the status
    if(handRank!.contains('HIGH CARD')) {
        return  'HIGH CARD';
    } else if (handRank.contains('ONE PAIR')) {
        return 'PAIR';
    } else if (handRank.contains('TWO PAIR')) {
        return 'TWO PAIR';
    } else if (handRank.contains('THREE OF A KIND')) {
        return 'THREE OF A KIND';
    } else if (handRank.contains('STRAIGHT')) {
        return 'STRAIGHT';
    } else if (handRank.contains('FLUSH')) {
        return 'FLUSH';
    } else if (handRank.contains('FULL HOUSE')) {
        return 'FULL HOUSE';
    } else if (handRank.contains('FOUR OF A KIND')) {
        return 'FOUR OF A KIND';
    } else if (handRank.contains('STRAIGHT FLUSH')) {
        return 'STRAIGHT FLUSH';
    } else if (handRank.contains('ROYAL FLUSH')) {
        return 'ROYAL FLUSH';
    } else {
      return "WINNER";
    }
  }
  String _showStatus(proto.PlayerStatusType state, String handRank) {
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
        return _convertHandRankToStatus(handRank);
      case proto.PlayerStatusType.LOSER:
        return _convertHandRankToStatus(handRank);
      case proto.PlayerStatusType.Sat_Out:
        return 'SAT OUT';
      default:
        return '';
    }
  }
  bool _needShowStatus(proto.PlayerStatusType state) {
    switch (state) {
      case proto.PlayerStatusType.Wait4Act:
      case proto.PlayerStatusType.Playing:
      case proto.PlayerStatusType.Spectating:
      case proto.PlayerStatusType.Ready:
      case proto.PlayerStatusType.Folded:
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
  bool _shouldShowCard(proto.PlayerStatusType state) {
    switch (state) {
      case proto.PlayerStatusType.Spectating:
      case proto.PlayerStatusType.Sat_Out:
      case proto.PlayerStatusType.Ready:
      case proto.PlayerStatusType.Folded:
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
    final audioController = context.read<AudioController>();
    final gameState = context.read<PokerGameStateProvider>();

    final player = gameState.getPlayerByIndex(playerUiIndex);
    final isEmptySlot = player.getName == '';
    final hasCards = player.getCard1.rank != proto.RankType.NONE && player.getCard2.rank != proto.RankType.NONE;
    final isFolded = (player.getState == proto.PlayerStatusType.Fold) || (player.getState == proto.PlayerStatusType.Folded);
    final isActive = player.getState == proto.PlayerStatusType.Wait4Act;
    final isShowHand = player.showCards;
    debugPrint('PlayerPanel build: playerUiIndex=$playerUiIndex, isEmptySlot=$isEmptySlot, hasCards=$hasCards, isFolded=$isFolded, isActive=$isActive, isShowHand=$isShowHand');

    return SizedBox(
      width: 130, // Adjust width as needed
      height: 100, // Adjust height as needed
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular avatar for player image or empty slot
          isEmptySlot
          ? Positioned(
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
          )
          : Positioned(
            // ignore: unrelated_type_equality_checks
            top: 0,
            child: CircleAvatar(
              backgroundImage: const AssetImage('assets/images/avatar_default.png'), // Player image path
              radius: 32, // Adjust size
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: () {
                      if (isFolded) {
                        return Colors.black54;
                      } else {
                        return Colors.grey.withOpacity(0.2);
                      }
                    }(), // Border color
                    width: 5, // Border width
                  ),
                ),
              ),
            ),
          ),

          // Cards
          !isEmptySlot && (_shouldShowCard(player.getState) || (isShowHand)) || (isMainPlayer && player.getState == proto.PlayerStatusType.Folded)?
          Positioned(
            top: 0,
            left: (isShowHand) ? 30 : 35,
            child: SizedBox(
                width: 80, // Adjust width as needed
                height: 55, // Adjust height as needed
                child:
                // If there are two cards, display them side by side (overlapping slightly
                Stack(
                  children: [
                    Transform.rotate(
                      angle: (isShowHand) ? 0 : -0.1, // Adjust the angle as needed
                      child: Image.asset(
                        hasCards ? _cardToImagePath(player.getCard1) : _faceDownCardImagePath,
                        color: isFolded && !(isShowHand) ? Colors.black.withOpacity(0.6) : Colors.transparent,
                        colorBlendMode : BlendMode.srcATop,
                        width: 40, // Card width
                        height: 60, // Card height
                      ),
                    ),
                    Positioned(
                      top : (isShowHand) ?- 2.5 : 0,
                      left: (isShowHand) ? 30 : 20, // Adjust the overlap distance
                      child: Transform.rotate(
                        angle: (isShowHand) ? 0 : 0.1, // Adjust the angle as needed
                        child: Image.asset(
                          hasCards ? _cardToImagePath(player.getCard2): _faceDownCardImagePath,
                          color: isFolded && !(isShowHand) ? Colors.black.withOpacity(0.6) : Colors.transparent,
                          colorBlendMode : BlendMode.srcATop,
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
          if (!isEmptySlot && _needShowStatus(player.getState))
            Positioned(
              top: 29, // 35
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                child: Text(
                  _showStatus(player.getState, player.handRanking),
                  style: TextStyle(
                    color: player.getState == proto.PlayerStatusType.LOSER ? Colors.white : Colors.yellowAccent,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          // Player name and star count with chip
          if (!isEmptySlot)
          Positioned(
            top: 45, // 55
            child: GlowingContainer(
              uiIdx: playerUiIndex,
              onTimeExceeded: () {
                debugPrint('PlayerPanel: onTimeExceeded for player $playerUiIndex');
                // Fold the player's hand if they take too long to act
                if (player.getState == proto.PlayerStatusType.Wait4Act &&
                    playerUiIndex == 0 && gameState.hasPlayerMainIndex) {
                  final int id = gameState.playerMainIndex;
                  proto.ClientMessage msg = proto.ClientMessage();
                  msg.playerAction = proto.PlayerAction()
                  ..playerId = id.toString()
                  ..actionType = proto.PlayerGameActionType.FOLD.toString().toLowerCase();
                  networkAgent.sendMessageAsync(msg.writeToBuffer());
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 1),
                  Text(
                    context.read<PokerGameStateProvider>().getPlayerByIndex(playerUiIndex).getName,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Permanent Marker',
                      height: 1,
                    ),
                  ),
                  // add a line break with a color line
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        color: Colors.white.withOpacity(0.85),
                        'assets/images/chip-new.png',
                        width: 9,
                        height: 9,
                      ),
                      const SizedBox(width: 2),
                      Selector<PokerGameStateProvider, (int, int) >(
                        selector: (_, gameState) => (gameState.getPlayerByIndex(playerUiIndex).getChips, gameState.getPlayerByIndex(playerUiIndex).getPreviousChips),
                        shouldRebuild: (prev, next) => prev != next,
                        builder: (context, value, child) {
                          return ChipTextAnimation(
                                value: value.$1,
                                previous: value.$2,
                                duration: const Duration(milliseconds: 300)
                              );
                        }
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
