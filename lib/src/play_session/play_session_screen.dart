// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart' hide Level;
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
import '../game_internals/level_state.dart';
import '../style/confetti.dart';
import '../style/palette.dart';
import '../cards/cards.dart';

import 'positioned_player_slot.dart';

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

  // Helper function to calculate the position of players
  Positioned _buildPlayerPosition(double angle, double radius, String role, String name, String chips, String starCount, String imagePath) {
    // Convert the angle to radians
    double rad = angle * pi / 180;

    // Calculate the x and y position based on the angle and radius
    double x = radius * cos(rad);
    double y = radius * sin(rad);

    // Return a Positioned widget with the calculated coordinates
    return Positioned(
      left: x + radius, // Center horizontally (shift by radius)
      top: y + radius,  // Center vertically (shift by radius)
      child: PlayerPanel(
        role: role,
        playerName: name,
        chips: chips,
        starCount: starCount,
        imagePath: imagePath,
        showCards: false,
      ),
    );
  }

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
      ],
      child: IgnorePointer(
        ignoring: _duringCelebration,
        child: Scaffold(
          backgroundColor: palette.trueWhite,
          body: Stack(
            children: [
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
                    buildCard("assets/cards/2_14.png"), // Replace with actual card image
                    buildCard("assets/cards/2_10.png"), // Replace with actual card image
                  ],
              ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height / 1.35,
                left: MediaQuery.of(context).size.width / 2 - 110,
                child: PlayerPanel(
                  role: "DEALER", // Replace with actual role
                  playerName: "MiMi", // Replace with player's name
                  chips: "2000", // Replace with chips amount
                  starCount: "11", // Replace with player's star count
                  imagePath: "assets/images/avatar_default.png", // Replace with player image path
                  showCards: true,
                ),
              ),

              Positioned(
                top: 100,
                left: 20,
                child: PlayerPanel(
                  role: "SM. BLIND", // Replace with actual role
                  playerName: "Toan", // Replace with player's name
                  chips: "4000", // Replace with chips amount
                  starCount: "54", // Replace with player's star count
                  imagePath: "assets/images/avatar_default.png", // Replace with player image path
                  showCards: false  ,
                ),
              ),

              Positioned(
                top: 2,
                left: MediaQuery.of(context).size.width / 2 - 60,
                child: PlayerPanel(
                  role: "B. BLIND", // Replace with actual role
                  playerName: "Mo", // Replace with player's name
                  chips: "2000", // Replace with chips amount
                  starCount: "11", // Replace with player's star count
                  imagePath: "assets/images/avatar_default.png", // Replace with player image path
                  showCards: false,
                ),
              ),

              // Player slots
              // PositionedPlayerSlot(
              //   top: MediaQuery.of(context).size.height /1.25,
              //   left: MediaQuery.of(context).size.width/10-85,
              //   playerNumber: 0,
              // ),
              // const PositionedPlayerSlot(
              //   top: 100,
              //   left: 20,
              //   playerNumber: 1,
              // ),
              // PositionedPlayerSlot(
              //   top: MediaQuery.of(context).size.height / 2 - 40,
              //   left: 0,
              //   playerNumber: 2,
              // ),
              // PositionedPlayerSlot(
              //   top: MediaQuery.of(context).size.height - 150,
              //   left: 20,
              //   playerNumber: 3,
              // ),
              // PositionedPlayerSlot(
              //   top: MediaQuery.of(context).size.height - 100,
              //   left: MediaQuery.of(context).size.width / 2 - 40,
              //   playerNumber: 4,
              // ),
              // PositionedPlayerSlot(
              //   top: MediaQuery.of(context).size.height - 150,
              //   right: 20,
              //   playerNumber: 5,
              // ),
              // PositionedPlayerSlot(
              //   top: MediaQuery.of(context).size.height / 2 - 40,
              //   right: 500,
              //   playerNumber: 6,
              // ),
              // const PositionedPlayerSlot(
              //   top: 100,
              //   right: 20,
              //   playerNumber: 7,
              // ),
              // PositionedPlayerSlot(
              //   top: 50,
              //   right: MediaQuery.of(context).size.width / 2 - 40,
              //   playerNumber: 8,
              // ),
            ],


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
