// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart' hide Level;
import 'package:poker_with_friends/src/game_internals/poker_game_state.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../game_internals/level_state.dart';
import '../game_internals/poker_game_state.dart';
import '../style/confetti.dart';
import '../style/palette.dart';
import '../cards/cards.dart';

import 'positioned_player_slot.dart';
import '../../proto/message.pb.dart' as $proto;

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

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LevelState(
            goal: 100,
            onWin: _playerWon,
          ),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => PokerGameState(), // Provide PokerGameState
        // ),
      ],
      child: IgnorePointer(
        ignoring: _duringCelebration,
        child: Scaffold(
          backgroundColor: palette.trueWhite,
          body: Stack(
            children: <Widget>[
              // Poker table background
              Positioned.fill(
                child: Image.asset(
                  'assets/images/poker_table_2.jpg', // Add your poker table background image here
                  fit: BoxFit.cover,
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height / 2 - 30,
                left:  MediaQuery.of(context).size.width / 2 - 120,
                child: Row(
                  children: [
                    // Community cards
                    buildCard("assets/cards/3_11.png"), // Replace with actual card image
                    buildCard("assets/cards/2_12.png"), // Replace with actual card image
                    buildCard("assets/cards/1_13.png"), // Replace with actual card image
                    //buildCard("assets/cards/2_14.png"), // Replace with actual card image
                    //buildCard("assets/cards/2_10.png"), // Replace with actual card image
                  ],
              ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height / 1.32,
                left: MediaQuery.of(context).size.width / 2 - 90,
                child: Consumer<PokerGameState>(
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(
                      state: pokerGameState.playerMain.getState, // Replace with actual state
                      playerName: pokerGameState.playerMain.getName, // Replace with player's name
                      chips: pokerGameState.playerMain.getChips.toString(), // Replace with chips amount
                      card1: pokerGameState.playerMain.getCard1,
                      card2: pokerGameState.playerMain.getCard2
                    );
                  },
                ),
              ),
              Positioned(
                top: 270,
                left: 110,
                child: Consumer<PokerGameState>(
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(
                      state: pokerGameState.player1.getState, // Replace with actual state
                      playerName: pokerGameState.player1.getName, // Replace with player's name
                      chips: pokerGameState.player1.getChips.toString(), // Replace with chips amount
                      card1: pokerGameState.player1.getCard1,
                      card2: pokerGameState.player1.getCard2
                    );
                  },
                ),
              ),
              Positioned(
                top: 130,
                left: 62,
                child: Consumer<PokerGameState>(
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(
                      state: pokerGameState.player2.getState, // Replace with actual state
                      playerName: pokerGameState.player2.getName, // Replace with player's name
                      chips: pokerGameState.player2.getChips.toString(), // Replace with chips amount
                      card1: pokerGameState.player2.getCard1,
                      card2: pokerGameState.player2.getCard2
                    );
                  },
                ),
              ),
              Positioned(
                top: 15,
                left: MediaQuery.of(context).size.width / 2 - 260,
                child: Consumer<PokerGameState>(
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(
                      state: pokerGameState.player3.getState, // Replace with actual state
                      playerName: pokerGameState.player3.getName, // Replace with player's name
                      chips: pokerGameState.player3.getChips.toString(), // Replace with chips amount
                      card1: pokerGameState.player3.getCard1,
                      card2: pokerGameState.player3.getCard2
                    );
                  },
                ),
              ),
              Positioned(
                top: 5,
                left: MediaQuery.of(context).size.width / 2 - 80,
                child: Consumer<PokerGameState>(
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(
                      state: pokerGameState.player4.getState, // Replace with actual state
                      playerName: pokerGameState.player4.getName, // Replace with player's name
                      chips: pokerGameState.player4.getChips.toString(), // Replace with chips amount
                      card1: pokerGameState.player4.getCard1,
                      card2: pokerGameState.player4.getCard2
                    );
                  },
                ),
              ),
              Positioned(
                top: 5,
                left: MediaQuery.of(context).size.width / 2 + 100,
                child: Consumer<PokerGameState>(
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(
                      state: pokerGameState.player5.getState, // Replace with actual state
                      playerName: pokerGameState.player5.getName, // Replace with player's name
                      chips: pokerGameState.player5.getChips.toString(), // Replace with chips amount
                      card1: pokerGameState.player5.getCard1,
                      card2: pokerGameState.player5.getCard2
                    );
                  },
                ),
              ),
              Positioned(
                top: 80,
                left: MediaQuery.of(context).size.width / 2 + 260,
                child: Consumer<PokerGameState>(
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(
                      state: pokerGameState.player6.getState, // Replace with actual state
                      playerName: pokerGameState.player6.getName, // Replace with player's name
                      chips: pokerGameState.player6.getChips.toString(), // Replace with chips amount
                      card1: pokerGameState.player6.getCard1,
                      card2: pokerGameState.player6.getCard2
                    );
                  },
                ),
              ),
              Positioned(
                top: 220,
                left: MediaQuery.of(context).size.width / 2 + 265,
                child: Consumer<PokerGameState>(
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(
                      state: pokerGameState.player7.getState, // Replace with actual state
                      playerName: pokerGameState.player7.getName, // Replace with player's name
                      chips: pokerGameState.player7.getChips.toString(), // Replace with chips amount
                      card1: pokerGameState.player7.getCard1,
                      card2: pokerGameState.player7.getCard2
                    );
                  },
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 1.32,
                left: MediaQuery.of(context).size.width / 2 + 130,
                child: Consumer<PokerGameState>(
                  builder: (context, pokerGameState, child) {
                    return PlayerPanel(
                      state: pokerGameState.player8.getState, // Replace with actual state
                      playerName: pokerGameState.player8.getName, // Replace with player's name
                      chips: pokerGameState.player8.getChips.toString(), // Replace with chips amount
                      card1: pokerGameState.player8.getCard1,
                      card2: pokerGameState.player8.getCard2
                    );
                  },
                ),
              ),

              // Other widgets can go here
              Positioned(
                bottom: 4,  // Distance from the bottom
                right: 2,   // Distance from the right
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 80, // Fixed width for the button
                      height: 25, // Fixed height for the button
                      child: OutlinedButton(
                        onPressed: () => context.read<PokerGameState>().touch(),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.all(2), // Remove default padding since size is fixed
                          textStyle: TextStyle(fontSize: 13),
                        ),
                        child: const Text('RAISE'),
                      ),
                    ),
                    const SizedBox(height: 5), // Space between buttons
                    SizedBox(
                      width: 120, // Fixed width for the button
                      height: 25, // Fixed height for the button
                      child: OutlinedButton(
                        onPressed: () => context.read<PokerGameState>().touch(),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.all(2), // Remove default padding since size is fixed
                          textStyle: TextStyle(fontSize: 13),
                        ),
                        child: const Text('CALL'),
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
              bottom: 4,  // Distance from the bottom
              left: 2,   // Distance from the right
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                // Align buttons to left
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 80, // Fixed width for the button
                      height: 25, // Fixed height for the button
                      child: OutlinedButton(
                        onPressed: () => context.read<PokerGameState>().touch(),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.all(2), // Remove default padding since size is fixed
                          textStyle: TextStyle(fontSize: 13),
                        ),
                        child: const Text('FOLD'),
                      ),
                    ),
                    const SizedBox(height: 5), // Space between buttons
                    SizedBox(
                      width: 120, // Fixed width for the button
                      height: 25, // Fixed height for the button
                      child: OutlinedButton(
                        onPressed: () => context.read<PokerGameState>().touch(),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.all(2), // Remove default padding since size is fixed
                          textStyle: TextStyle(fontSize: 13),
                        ),
                        child: const Text('CHECK'),
                      ),
                    ),
                  ],
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

    // _startOfPlay = DateTime.now();

    // Preload ad for the win screen.
    // final adsRemoved =
    //     context.read<InAppPurchaseController?>()?.adRemoval.active ?? false;
    // if (!adsRemoved) {
    //   final adsController = context.read<AdsController?>();
    //   adsController?.preloadAd();
    // }
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
    audioController.playSfx(SfxType.congrats);

  }
}
