// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart' hide Level;
import 'package:poker_with_friends/src/game_internals/poker_game_state.dart';
import 'package:poker_with_friends/src/game_play/dropdown_menu.dart';
import 'package:poker_with_friends/src/game_play/player_panel.dart';
import 'package:poker_with_friends/src/game_play/raiser_menu.dart';

import '../audio/audio_controller.dart';
import '../settings/settings.dart';
import '../audio/sounds.dart';
import '../game_internals/level_state.dart';
import '../game_internals/poker_game_state.dart';
import '../style/confetti.dart';
import '../style/palette.dart';
import '../cards/cards.dart';

import 'dealer.dart';
import 'dropdown_menu.dart' as custom;
import '../../proto/message.pb.dart' as $proto;
import '../network_agent/network_agent.dart';


Widget _buildPlayerBetContainer(BuildContext context, int playerIndex) {
  final gameState = context.read<PokerGameState>();
  final player = gameState.getPlayerByIndex(playerIndex);

  final List<Offset> positions = [
    const Offset(380, 245), // main
    const Offset(245, 245), // player 1
    const Offset(180, 210), // player 2
    const Offset(180, 150), // player 3
    const Offset(245, 100), // player 4
    const Offset(380, 100), // player 5
    const Offset(550, 100), // player 6
    const Offset(580, 150), // player 7
    const Offset(580, 210), // player 8
    const Offset(530, 245), // player 9
  ];
  return Positioned(
    top: positions[playerIndex].dy,
    left: positions[playerIndex].dx,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5),
      ),

      child: Row(
        children: [
          ColorFiltered(
            colorFilter:const ColorFilter.mode(
              Colors.transparent,
              BlendMode.multiply,
            ),
            child: Image.asset(
              'assets/images/chip.png',
              width: 12,
              height: 12,
            ),
          ),
          Text(
            '${player.getBet} ', // Replace with actual bet amount
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 11,
            ),
          ),
        ],
      ),
    ),
  );
}

class PlaySessionScreen extends StatefulWidget {
  final int level;
  const PlaySessionScreen(this.level, {super.key});

  @override
  State<PlaySessionScreen> createState() => _PlaySessionScreenState();
}

class _PlaySessionScreenState extends State<PlaySessionScreen> {
  static final _log = Logger('PlaySessionScreen');

  // static const _celebrationDuration = Duration(milliseconds: 2000);
  static const _preCelebrationDuration = Duration(milliseconds: 500);

  bool _duringCelebration = false;

  // late DateTime _startOfPlay;
  late NetworkAgent _networkAgent;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    final palette = context.watch<Palette>();
    final gameState = context.watch<PokerGameState>();
    final audioController = context.watch<AudioController>();
    gameState.attachAudioController(audioController);
    _log.info('Building PlaySessionScreen for level ${widget.level}, Height: ${MediaQuery.of(context).size.height}, Width: ${MediaQuery.of(context).size.width}');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LevelState(
            goal: 100,
            onWin: _playerWon,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => DropdownProvider(), // Provide PokerGameState
        ),
        Provider(
          create: (context) => _networkAgent,
        ),
      ],
      child: IgnorePointer(
        ignoring: _duringCelebration,
        child: Scaffold(
          appBar: null,
          backgroundColor: palette.trueWhite,
          body: Stack(
            children: <Widget>[
              // table background
              Positioned.fill(
                child: Image.asset(
                  'assets/images/poker_table.png', // Add your poker table background image here
                  fit: BoxFit.cover,
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height / 2 - 40,
                left:  MediaQuery.of(context).size.width / 2 - 115,
                child: Row(
                  children: [
                    // Community cards
                    ...List.generate(gameState.communityCards.length,
                      (i) => buildCommCardFromProtoCard(gameState.communityCards[i]),
                    ),
                  ],
              ),
              ),

              // Total pot
              Align(
                alignment: const Alignment(0, -0.30), // Adjust this value for top alignment (-1 is top, 1 is bottom)
                child: Container(
                  width: 140,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Consumer<PokerGameState>(
                    builder: (context, pokerGameState, child) => Text(
                      'Total Pot: ${pokerGameState.totalPot}', // Replace with actual total pot amount
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),

               // Total pot
              gameState.handRanking != '' ? Align(
                alignment: const Alignment(0, 0.18), // Adjust this value for top alignment (-1 is top, 1 is bottom)
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    gameState.handRanking,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 12,
                    ),
                  ),
                ),
              ): const SizedBox.shrink(),

              // Dealer icon
              Positioned(
                child: Consumer<PokerGameState>(
                  builder: (context, pokerGameState, child) => DealerIcon(currentIndex: pokerGameState.currentButtonIndex),
                ),
              ),

              ...List.generate(10, (i) {
                if (context.watch<PokerGameState>().getPlayerByIndex(i).getBet > 0) {
                  return _buildPlayerBetContainer(context, i);
                }
                return const SizedBox.shrink();
              }),

              // Main player
              Positioned(
                top: MediaQuery.of(context).size.height / 2 + 79,
                left: MediaQuery.of(context).size.width / 2 - 70,
                child: Consumer<PokerGameState>(
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(
                      isMainPlayer: true,
                      playerUiIndex: 0,
                      state: pokerGameState.playerC.getState, // Replace with actual state
                      playerName: pokerGameState.playerC.getName, // Replace with player's name
                      chips: pokerGameState.playerC.getChips.toString(), // Replace with chips amount
                      card1: pokerGameState.playerC.getCard1,
                      card2: pokerGameState.playerC.getCard2
                    );
                  },
                ),
              ),
              // Player 1
              Positioned(
                top: MediaQuery.of(context).size.height / 2 + 75,
                left: MediaQuery.of(context).size.width / 2 - 225,
                child: Consumer<PokerGameState>(
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(
                      isMainPlayer: false,
                      playerUiIndex: 1,
                      state: pokerGameState.player1.getState, // Replace with actual state
                      playerName: pokerGameState.player1.getName, // Replace with player's name
                      chips: pokerGameState.player1.getChips.toString(), // Replace with chips amount
                      card1: pokerGameState.player1.getCard1,
                      card2: pokerGameState.player1.getCard2
                    );
                  },
                ),
              ),
              // Player 2
              Positioned(
                top: MediaQuery.of(context).size.height / 2 + 20,
                left: MediaQuery.of(context).size.width / 2 - 350,
                child: Consumer<PokerGameState>(
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(
                      isMainPlayer: false,
                      playerUiIndex: 2,
                      state: pokerGameState.player2.getState, // Replace with actual state
                      playerName: pokerGameState.player2.getName, // Replace with player's name
                      chips: pokerGameState.player2.getChips.toString(), // Replace with chips amount
                      card1: pokerGameState.player2.getCard1,
                      card2: pokerGameState.player2.getCard2
                    );
                  },
                ),
              ),
              // Player 3
              Positioned(
                top: MediaQuery.of(context).size.height / 2 - 115,
                left: MediaQuery.of(context).size.width / 2 - 350,
                child: Consumer<PokerGameState>(
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(
                      isMainPlayer: false,
                      playerUiIndex: 3,
                      state: pokerGameState.player3.getState, // Replace with actual state
                      playerName: pokerGameState.player3.getName, // Replace with player's name
                      chips: pokerGameState.player3.getChips.toString(), // Replace with chips amount
                      card1: pokerGameState.player3.getCard1,
                      card2: pokerGameState.player3.getCard2
                    );
                  },
                ),
              ),
              // Player 4, top left
              Positioned(
                top: 6,
                left: MediaQuery.of(context).size.width / 2 - 225,
                child: Consumer<PokerGameState>(
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(
                      isMainPlayer: false,
                      playerUiIndex: 4,
                      state: pokerGameState.player4.getState, // Replace with actual state
                      playerName: pokerGameState.player4.getName, // Replace with player's name
                      chips: pokerGameState.player4.getChips.toString(), // Replace with chips amount
                      card1: pokerGameState.player4.getCard1,
                      card2: pokerGameState.player4.getCard2
                    );
                  },
                ),
              ),

              // Player 5, top center player
              Positioned(
                top: 5,
                left: MediaQuery.of(context).size.width / 2 - 70,
                child: Consumer<PokerGameState>(
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(
                      isMainPlayer: false,
                      playerUiIndex: 5,
                      state: pokerGameState.player5.getState, // Replace with actual state
                      playerName: pokerGameState.player5.getName, // Replace with player's name
                      chips: pokerGameState.player5.getChips.toString(), // Replace with chips amount
                      card1: pokerGameState.player5.getCard1,
                      card2: pokerGameState.player5.getCard2
                    );
                  },
                ),
              ),
              // Player 6, top right
              Positioned(
                top: 6,
                left: MediaQuery.of(context).size.width / 2 + 90,
                child: Consumer<PokerGameState>(
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(
                      isMainPlayer: false,
                      playerUiIndex: 6,
                      state: pokerGameState.player6.getState, // Replace with actual state
                      playerName: pokerGameState.player6.getName, // Replace with player's name
                      chips: pokerGameState.player6.getChips.toString(), // Replace with chips amount
                      card1: pokerGameState.player6.getCard1,
                      card2: pokerGameState.player6.getCard2
                    );
                  },
                ),
              ),
              // player 7
              Positioned(
                top: MediaQuery.of(context).size.height / 2 - 115,
                left: MediaQuery.of(context).size.width / 2 + 225,
                child: Consumer<PokerGameState>(
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(
                      isMainPlayer: false,
                      playerUiIndex: 7,
                      state: pokerGameState.player7.getState, // Replace with actual state
                      playerName: pokerGameState.player7.getName, // Replace with player's name
                      chips: pokerGameState.player7.getChips.toString(), // Replace with chips amount
                      card1: pokerGameState.player7.getCard1,
                      card2: pokerGameState.player7.getCard2
                    );
                  },
                ),
              ),
              // player 8
              Positioned(
                top: MediaQuery.of(context).size.height / 2 + 20,
                left: MediaQuery.of(context).size.width / 2 + 225,
                child: Consumer<PokerGameState>(
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(
                      isMainPlayer: false,
                      playerUiIndex: 8,
                      state: pokerGameState.player8.getState, // Replace with actual state
                      playerName: pokerGameState.player8.getName, // Replace with player's name
                      chips: pokerGameState.player8.getChips.toString(), // Replace with chips amount
                      card1: pokerGameState.player8.getCard1,
                      card2: pokerGameState.player8.getCard2
                    );
                  },
                ),
              ),
              // player 9
              Positioned(
                top: MediaQuery.of(context).size.height / 2 + 75,
                left: MediaQuery.of(context).size.width / 2 + 90,
                child: Consumer<PokerGameState>(
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(
                      isMainPlayer: false,
                      playerUiIndex: 9,
                      state: pokerGameState.player9.getState, // Replace with actual state
                      playerName: pokerGameState.player9.getName, // Replace with player's name
                      chips: pokerGameState.player9.getChips.toString(), // Replace with chips amount
                      card1: pokerGameState.player9.getCard1,
                      card2: pokerGameState.player9.getCard2
                    );
                  },
                ),
              ),

              // Other widgets can go here
              gameState.hasPlayerMainIndex ? Positioned(
                bottom: 0,  // Distance from the bottom
                right: 0,   // Distance from the right
                left: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 185, // Fixed width for the button
                      height: 28, // Fixed height for the button
                      child: ElevatedButton(
                        onPressed: () {
                          audioController.playSfx(SfxType.btnTap);
                          _handleButtonPress('FOLD', gameState.playerMainIndex);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(2), // Remove default padding since size is fixed
                          textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text('FOLD'),
                      ),
                    ),
                    const SizedBox(width: 4), // Space between buttons
                    SizedBox(
                      width: 185, // Fixed width for the button
                      height: 28, // Fixed height for the button
                      child: ElevatedButton(
                        onPressed: () {
                          audioController.playSfx(SfxType.btnTap);
                          _handleButtonPress('CHECK', gameState.playerMainIndex);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: gameState.currentBet == gameState.playerC.getBet ? const Color(0xfff4f3fa): Colors.white60,
                          padding: const EdgeInsets.all(2), // Remove default padding since size is fixed
                          textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                          // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: gameState.currentBet == gameState.playerC.getBet ? const Text('CHECK'): const SizedBox.shrink(),
                      ),
                    ),
                    const SizedBox(width: 4), // Space between buttons
                    SizedBox(
                      width: 185, // Fixed width for the button
                      height: 28, // Fixed height for the button
                      child: ElevatedButton(
                        onPressed: () {
                          audioController.playSfx(SfxType.btnTap);
                          _handleButtonPress('CALL', gameState.playerMainIndex);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: gameState.currentBet == gameState.playerC.getBet ? Colors.white60:const Color(0xfff4f3fa),
                          padding: const EdgeInsets.all(2), // Remove default padding since size is fixed
                          textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: gameState.currentBet == gameState.playerC.getBet ? const SizedBox.shrink() : Text('CALL ${() {
                          final callAmount = gameState.currentBet - gameState.playerC.getBet;
                          return (callAmount == 0) ? '' : callAmount.toString();
                        }()}'),
                      ),
                    ),
                    const SizedBox(width: 4), // Space between buttons
                    SizedBox(
                      width: 185, // Fixed width for the button
                      height: 28, // Fixed height for the button
                      child: ElevatedButton(
                        onPressed: () {
                          audioController.playSfx(SfxType.btnTap);
                          final raiserProvider = context.read<RaiserProvider>();
                          if (raiserProvider.isRaiserVisible) {
                            raiserProvider.isMax ? _handleRaiseButtonPress(gameState.playerMainIndex, 0x7FFFFFFF) :
                              _handleRaiseButtonPress(gameState.playerMainIndex, raiserProvider.currentRaiseAmountAsInt);
                          }
                          raiserProvider.setMinRaiseValue(gameState.currentBet);
                          raiserProvider.toggleRaiserVisibility();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(2), // Remove default padding since size is fixed
                          textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(context.watch<RaiserProvider>().isRaiserVisible ? 'CONFIRM' : gameState.currentBet == 0 ? 'BET' : 'RAISE'),
                      ),
                    ),
                  ],
                ),
              ): const SizedBox.shrink(),

              // Dropdown menu first
              Positioned(
                top: 0,
                right: 0,
                child: custom.DropdownMenu(),
              ),

              // Raiser menu
              Positioned(
              bottom: 30,
              left: MediaQuery.of(context).size.width / 2 + 250,
              child: const RaiseSliderScreen(),
            ),
            ],  // End of children



            // children: [
            //   Center(
            //     // This is the entirety of the "game".
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Align(
            //           alignment: Alignment.centerRight,
            //           child: InkResponse(
            //             onTap: () => GoRouter.of(context).push('/settings'),
            //             child: Image.asset(
            //               'assets/images/settings.png',
            //               semanticLabel: 'Settings',
            //             ),
            //           ),
            //         ),
            //         const Spacer(),
            //         const Text('Drag the slider to 100%'
            //             ' or above!'),
            //         Consumer<LevelState>(
            //           builder: (context, levelState, child) => Slider(
            //             label: 'Level Progress',
            //             autofocus: true,
            //             value: levelState.progress / 100,
            //             onChanged: (value) =>
            //                 levelState.setProgress((value * 100).round()),
            //             onChangeEnd: (value) => levelState.evaluate(),
            //           ),
            //         ),
            //         const Spacer(),
            //         Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: SizedBox(
            //             width: double.infinity,
            //             child: FilledButton(
            //               onPressed: () => GoRouter.of(context).go('/lobby'),
            //               child: const Text('Back'),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            //   SizedBox.expand(
            //     child: Visibility(
            //       visible: _duringCelebration,
            //       child: IgnorePointer(
            //         child: Confetti(
            //           isStopped: !_duringCelebration,
            //         ),
            //       ),
            //     ),
            //   ),
            // ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final gameState = Provider.of<PokerGameState>(context, listen: false);
    final serverAddress = Provider.of<SettingsController>(context, listen: false).serverAddress.value;
    final playerName = Provider.of<SettingsController>(context, listen: false).playerName.value;
    gameState.reinit();
    _networkAgent = NetworkAgent('wss://$serverAddress:28888/ws', playerName, gameState);
    _networkAgent.ws_connect();
  }

  @override
  void dispose() {
    _networkAgent.dispose();
    super.dispose();
  }

  void _handleRaiseButtonPress(int id, int amount) {
    _log.info('Raise button pressed at $id with amount $amount');
    if (amount == 0x7FFFFFFF) {
      $proto.ClientMessage outgoingMessage = $proto.ClientMessage();
      outgoingMessage.playerAction = $proto.PlayerAction()
            ..playerId = id.toString()
            ..actionType = 'allin';
      _networkAgent.sendMessageAsync(outgoingMessage.writeToBuffer());
      return;
    }
    $proto.ClientMessage outgoingMessage = $proto.ClientMessage();
    outgoingMessage.playerAction = $proto.PlayerAction()
          ..playerId = id.toString()
          ..actionType = $proto.PlayerGameActionType.RAISE.toString().toLowerCase()
          ..raiseAmount = amount;
    _networkAgent.sendMessageAsync(outgoingMessage.writeToBuffer());
  }

  void _handleButtonPress(String buttonName, int id) {
    _log.info('Button pressed');

    $proto.ClientMessage outgoingMessage = $proto.ClientMessage();

    switch (buttonName) {
      case 'FOLD':
        outgoingMessage.playerAction = $proto.PlayerAction()
          ..playerId = id.toString()
          ..actionType = $proto.PlayerGameActionType.FOLD.toString().toLowerCase();
        break;
      case 'CHECK':
        outgoingMessage.playerAction = $proto.PlayerAction()
          ..playerId = id.toString()
          ..actionType = $proto.PlayerGameActionType.CHECK.toString().toLowerCase();
        break;
      case 'CALL':
        outgoingMessage.playerAction = $proto.PlayerAction()
          ..playerId = id.toString()
          ..actionType = $proto.PlayerGameActionType.CALL.toString().toLowerCase();
        break;
      default:
        break;
    }
    _networkAgent.sendMessageAsync(outgoingMessage.writeToBuffer());
    _log.info('Sent message for $buttonName');
  }

  Future<void> _playerWon() async {
    // _log.info('Level ${widget.level.number} won');

    // final playerProgress = context.read<PlayerProgress>();
    // playerProgress.setLevelReached(widget.level.number);

    // Let the player see the game just after winning for a bit.
    await Future<void>.delayed(_preCelebrationDuration);
    if (!mounted) return;

    setState(() {
      _duringCelebration = true;
    });

    final audioController = context.read<AudioController>();
    audioController.playSfx(SfxType.collect);

  }
}
