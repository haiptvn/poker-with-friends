import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
// import '../player_progress/player_progress.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class RoomAvailable {
  final int? number;
  final int? ID;

  final String? passCode;

  const RoomAvailable({
    required this.number,
    required this.ID,
    required this.passCode,
  });
}

const roomList = [
  RoomAvailable(number: 1, ID: 2, passCode: '1'),
  RoomAvailable(number: 2, ID: 3, passCode: '2'),
  RoomAvailable(number: 3, ID: 4, passCode: '3'),
];

class GameLobbyScreen extends StatelessWidget {
  const GameLobbyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    // final playerProgress = context.watch<PlayerProgress>();

    return Scaffold(
      backgroundColor: palette.backgroundLevelSelection,
      body: ResponsiveScreen(
        squarishMainArea: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Text(
                  'Select room to join',
                  style:
                      TextStyle(fontFamily: 'Permanent Marker', fontSize: 26),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: ListView(
                children: [
                  for (final room in roomList)
                    ListTile(
                      enabled: true,
                      onTap: () {
                        final audioController = context.read<AudioController>();
                        audioController.playSfx(SfxType.buttonTap);

                        GoRouter.of(context)
                            .go('/lobby/playing');
                      },
                      leading: Text(room.number.toString()),
                      title: Text('Room #${room.ID}'),
                    )
                ],
              ),
            ),
          ],
        ),
        rectangularMenuArea: FilledButton(
          onPressed: () {
            final audioController = context.read<AudioController>();
            audioController.playSfx(SfxType.buttonTap);

            GoRouter.of(context).go('/');
          },
          child: const Text('Main Menu'),
          // Removed invalid constant
        ),
      ),
    );
  }
}