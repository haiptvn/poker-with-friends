// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poker_with_friends/src/game_play/action_buttons.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:poker_with_friends/src/game_play/balance_board.dart';
import 'package:poker_with_friends/src/message_format/client_message_builder.dart';
import 'package:provider/provider.dart';
import 'package:logging/logging.dart' hide Level;
import 'package:poker_with_friends/src/game_internals/poker_game_state.dart';
import 'package:poker_with_friends/src/game_play/dropdown_menu.dart';
import 'package:poker_with_friends/src/game_play/player_panel.dart';
import 'package:poker_with_friends/src/game_play/raiser_menu.dart';

import '../audio/audio_controller.dart';
import '../settings/settings.dart';
import '../audio/sounds.dart';
import '../game_internals/level_state.dart';
import '../style/palette.dart';
import '../cards/cards.dart';

import 'dealer_icon.dart';
import 'dropdown_menu.dart' as custom;
import '../../proto/message.pb.dart' as proto;
import '../network_agent/network_agent.dart';


Widget _buildPlayerBetContainer(BuildContext context, int playerIndex) {
  final gameState = context.read<PokerGameStateProvider>();
  final player = gameState.getPlayerByIndex(playerIndex);

  final List<Offset> positions = [
    const Offset(-20, 24), // main
    const Offset(-140, 20), // player 1
    const Offset(-210, 0), // player 2 x
    const Offset(-205, -75), // player 3 x
    const Offset(-140, -103),  // player 4
    const Offset(-20, -105),  // player 5
    const Offset(112, -103),  // player 6
    const Offset(165, -75), // player 7 x
    const Offset(170, 0), // player 8 x
    const Offset(112, 20), // player 9
  ];
  return Positioned(
    top: MediaQuery.of(context).size.height / 2 + positions[playerIndex].dy,
    left: MediaQuery.of(context).size.width / 2 + positions[playerIndex].dx,
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
              color: Colors.white,
              'assets/images/chip-new.png',
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

const List<Offset> playersCenterOffset = [
    Offset(-65, 48),    // main
    Offset(-200, 45),   // player 1
    Offset(-315, 0),    // player 2 x
    Offset(-315, -125), // player 3 x
    Offset(-200, 1),    // player 4
    Offset(-65, 0),     // player 5
    Offset(75, 1),      // player 6
    Offset(190, -125),  // player 7 x
    Offset(190, 0),     // player 8 x
    Offset(75, 45),     // player 9
  ];

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

  // For settings
  late bool? _disableMusic;
  SettingsController? _settingsController;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    final palette = context.watch<Palette>();
    final gameState = context.read<PokerGameStateProvider>();
    final audioController = context.read<AudioController>();
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
          create: (context) => DropdownProvider(), // Provide PokerGameStateProvider
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
                  'assets/images/poker-table.png', // Add your poker table background image here
                  fit: BoxFit.cover,
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height / 2 - 63,
                left:  MediaQuery.of(context).size.width / 2 - 115,
                child: Selector<PokerGameStateProvider, int>(
                  selector: (_, pokerGameState) => pokerGameState.communityCards.length,
                  builder: (context, playerMainIndex, child) {
                    return Row( children: [
                        // Community cards
                        ...List.generate(gameState.communityCards.length,
                          (i) => buildCommCardFromProtoCard(gameState.communityCards[i]),
                        ),
                      ],
                    );
                  }, // End of builder
                ),
              ),

              // Total pot
              Selector<PokerGameStateProvider, int>(
                selector: (_, pokerGameState) => pokerGameState.totalPot,
                builder: (context, totalPot, child) {
                  return totalPot > 0 ? Align(
                    alignment: const Alignment(0, -0.40), // Adjust this value for top alignment (-1 is top, 1 is bottom)
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'Total Pot: $totalPot', // Replace with actual total pot amount
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                  : const SizedBox.shrink();
                },
              ),

              // Hank ranking
              gameState.playerM.handRanking != '' ? Align(
                alignment: const Alignment(0, 0.05), // Adjust this value for top alignment (-1 is top, 1 is bottom)
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    gameState.playerM.handRanking,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.yellowAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ): const SizedBox.shrink(),

              // Dealer icon
              Positioned(
                child: Consumer<PokerGameStateProvider>(
                  builder: (context, pokerGameState, child) => DealerIcon(currentIndex: pokerGameState.currentButtonIndex),
                ),
              ),

              // Player bets
              ...List.generate(10, (i) {
                return Consumer<PokerGameStateProvider>(
                  builder: (context, pokerGameState, child) {
                    if (pokerGameState.getPlayerByIndex(i).getBet > 0) {
                      return _buildPlayerBetContainer(context, i);
                    }
                    return const SizedBox.shrink();
                  }
                );
              }),

              // Main player
              Positioned(
                top: MediaQuery.of(context).size.height / 2 + playersCenterOffset[0].dy,
                left: MediaQuery.of(context).size.width / 2 + playersCenterOffset[0].dx,
                child: Selector<PokerGameStateProvider, int>(
                  selector: (_, pokerGameState) => pokerGameState.playerM.getChangesCnt,
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(playerUiIndex: 0);
                  },
                ),
              ),
              // Player 1
              Positioned(
                top: MediaQuery.of(context).size.height / 2 + playersCenterOffset[1].dy,
                left: MediaQuery.of(context).size.width / 2 + playersCenterOffset[1].dx,
                child: Selector<PokerGameStateProvider, int>(
                  selector: (_, pokerGameState) => pokerGameState.player1.getChangesCnt,
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(playerUiIndex: 1);
                  },
                ),
              ),
              // Player 2
              Positioned(
                top: MediaQuery.of(context).size.height / 2 + playersCenterOffset[2].dy,
                left: MediaQuery.of(context).size.width / 2 + playersCenterOffset[2].dx,
                child: Selector<PokerGameStateProvider, int>(
                  selector: (_, pokerGameState) => pokerGameState.player2.getChangesCnt,
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(playerUiIndex: 2);
                  },
                ),
              ),
              // Player 3
              Positioned(
                top: MediaQuery.of(context).size.height / 2 + playersCenterOffset[3].dy,
                left: MediaQuery.of(context).size.width / 2 + playersCenterOffset[3].dx,
                child: Selector<PokerGameStateProvider, int>(
                  selector: (_, pokerGameState) => pokerGameState.player3.getChangesCnt,
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(playerUiIndex: 3);
                  },
                ),
              ),
              // Player 4, top left
              Positioned(
                top: 6,
                left: MediaQuery.of(context).size.width / 2 + playersCenterOffset[4].dx,
                child: Selector<PokerGameStateProvider, int>(
                  selector: (_, pokerGameState) => pokerGameState.player4.getChangesCnt,
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(playerUiIndex: 4);
                  },
                ),
              ),

              // Player 5, top center player
              Positioned(
                top: 5,
                left: MediaQuery.of(context).size.width / 2 + playersCenterOffset[5].dx,
                child: Selector<PokerGameStateProvider, int>(
                  selector: (_, pokerGameState) => pokerGameState.player5.getChangesCnt,
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(playerUiIndex: 5);
                  },
                ),
              ),
              // Player 6, top right
              Positioned(
                top: 6,
                left: MediaQuery.of(context).size.width / 2 + playersCenterOffset[6].dx,
                child: Selector<PokerGameStateProvider, int>(
                  selector: (_, pokerGameState) => pokerGameState.player6.getChangesCnt,
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(playerUiIndex: 6);
                  },
                ),
              ),
              // player 7
              Positioned(
                top: MediaQuery.of(context).size.height / 2 + playersCenterOffset[7].dy,
                left: MediaQuery.of(context).size.width / 2 + playersCenterOffset[7].dx,
                child: Selector<PokerGameStateProvider, int>(
                  selector: (_, pokerGameState) => pokerGameState.player7.getChangesCnt,
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(playerUiIndex: 7);
                  },
                ),
              ),
              // player 8
              Positioned(
                top: MediaQuery.of(context).size.height / 2 + playersCenterOffset[8].dy,
                left: MediaQuery.of(context).size.width / 2 + playersCenterOffset[8].dx,
                child: Selector<PokerGameStateProvider, int>(
                  selector: (_, pokerGameState) => pokerGameState.player8.getChangesCnt,
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(playerUiIndex: 8);
                  },
                ),
              ),
              // player 9
              Positioned(
                top: MediaQuery.of(context).size.height / 2 + playersCenterOffset[9].dy,
                left: MediaQuery.of(context).size.width / 2 + playersCenterOffset[9].dx,
                child: Selector<PokerGameStateProvider, int>(
                  selector: (_, pokerGameState) => pokerGameState.player9.getChangesCnt,
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(playerUiIndex: 9);
                  },
                ),
              ),


              Selector<PokerGameStateProvider, (bool, bool, proto.PlayerStatusType) >(
                selector: (_, pokerGameState) => (pokerGameState.playerM.showCards, pokerGameState.shouldShowButton, pokerGameState.playerM.getState),
                builder: (context, data, child) {
                  debugPrint('Show button: $data');
                  return (!data.$1 &&
                  !data.$2 &&
                  (data.$3 != proto.PlayerStatusType.Ready) &&
                  (data.$3 != proto.PlayerStatusType.Spectating) &&
                  (data.$3 != proto.PlayerStatusType.Sat_Out) &&
                  gameState.playerM.hasCards)
                  ? Positioned(
                    bottom: 110,
                    left: MediaQuery.of(context).size.width / 2 + 40,
                    child: Container(
                      height: 35,
                      width: 45, // Fixed width for the button
                      decoration: BoxDecoration(
                        color : Colors.transparent, // Adjust the color as needed
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.2), // Border color
                          width: 1.5, // Border width
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          audioController.playSfx(SfxType.btnTap);
                          _handleButtonShow(gameState.playerMainIndex);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          padding: const EdgeInsets.all(2), // Remove default padding since size is fixed
                          textStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('SHOW'),
                      ),
                    ),
                  )
                  : const SizedBox.shrink();
                },
              ),

              // Other widgets can go here
              Positioned(
                bottom: 20,  // Distance from the bottom
                right: 0,   // Distance from the right
                left: 0,
                child: ActionButtons(
                  playerIndex: gameState.playerMainIndex,
                  onButtonPress: _handleButtonPress,
                  onRaiseButtonPress: _handleRaiseButtonPress,
                )
              ),

              // Dropdown menu first
              Positioned(
                top: 0,
                right: 0,
                child: custom.DropdownMenu(),
              ),

              // Raiser menu
              Positioned(
                bottom: 60.5,
                left: MediaQuery.of(context).size.width / 2 + 150,
                child: const RaiseSliderScreen(),
              ),

              Positioned(
                top: 15,
                left: 10,
                child: SizedBox(
                  width: 80, // Fixed width for the button
                  height: buttonSizeHeight.toDouble(), // Fixed height for the button
                  child: GestureDetector(
                    onTap: () {
                      _log.info('Balance button pressed');
                      audioController.playSfx(SfxType.btnTap);
                      context.read<BalanceBoardProvider>().toggleBalanceBoardVisibility();
                    },
                    child: const Text(
                      '  Balance',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFFE0E0E0)),
                    ),
                  ),
                ),
              ),

              Center(
                child: Consumer<BalanceBoardProvider>(builder: (context, value, child) {
                    return BalanceLeaderboardDialog(entries:
                      context.read<PokerGameStateProvider>().playerBalances
                    );
                  }
                ),
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

    final setting = Provider.of<SettingsController>(context, listen: false);
    if (setting.musicOn.value == true) {
      setting.toggleMusicOn();
      _disableMusic = true;
    } else {
      _disableMusic = false;
    }

    final gameState = Provider.of<PokerGameStateProvider>(context, listen: false);
    gameState.reinit();

    _networkAgent = Provider.of<NetworkAgent>(context, listen: false);
    _networkAgent.sendMessageAsync(ClientMessageBuilder.build('sync_game_state', gameState.playerMainIndex).toProto());

    WakelockPlus.enable();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get the provider from the context and store it in the variable
    _settingsController ??= Provider.of<SettingsController>(context, listen: false);
  }

  @override
  void dispose() {
    _networkAgent.dispose();

    if (_disableMusic == true && _settingsController != null) {
      _settingsController!.toggleMusicOn();
    }

    WakelockPlus.disable();

    super.dispose();
  }

  void _handleRaiseButtonPress(int id, int amount) {
    _log.info('Raise button pressed at $id with amount $amount');
    if (amount == 0x7FFFFFFF) {
      proto.ClientMessage outgoingMessage = proto.ClientMessage();
      outgoingMessage.playerAction = proto.PlayerAction()
            ..playerId = id.toString()
            ..actionType = 'allin';
      _networkAgent.sendMessageAsync(outgoingMessage.writeToBuffer());
      return;
    }
    proto.ClientMessage outgoingMessage = proto.ClientMessage();
    outgoingMessage.playerAction = proto.PlayerAction()
          ..playerId = id.toString()
          ..actionType = proto.PlayerGameActionType.RAISE.toString().toLowerCase()
          ..raiseAmount = amount;
    _networkAgent.sendMessageAsync(outgoingMessage.writeToBuffer());
  }

  void _handleButtonShow(int mainPlayerIndex) {
    debugPrint('Show button pressed');
    _networkAgent.sendMessageAsync(ClientMessageBuilder.build('request_show_hand', mainPlayerIndex).toProto());
    return;
  }

  void _handleButtonPress(String buttonName, int id) {
    _log.info('Button pressed');

    proto.ClientMessage outgoingMessage = proto.ClientMessage();

    switch (buttonName) {
      case 'FOLD':
        outgoingMessage.playerAction = proto.PlayerAction()
          ..playerId = id.toString()
          ..actionType = proto.PlayerGameActionType.FOLD.toString().toLowerCase();
        break;
      case 'CHECK':
        outgoingMessage.playerAction = proto.PlayerAction()
          ..playerId = id.toString()
          ..actionType = proto.PlayerGameActionType.CHECK.toString().toLowerCase();
        break;
      case 'CALL':
        outgoingMessage.playerAction = proto.PlayerAction()
          ..playerId = id.toString()
          ..actionType = proto.PlayerGameActionType.CALL.toString().toLowerCase();
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
