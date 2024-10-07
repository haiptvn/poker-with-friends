import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import '../audio/audio_controller.dart';
import '../audio/sounds.dart';
// import '../player_progress/player_progress.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';
import '../network_agent/network_agent.dart';
import '../settings/settings.dart';
import '../game_internals/poker_game_state.dart';

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
  final _log = Logger('GameLobbyScreen');
  GameLobbyScreen({super.key});

  String enteredPasscode = '';

  Future<bool> _connectToServer(BuildContext context, String room, String enteredPasscode) async {
    final gameState = Provider.of<PokerGameStateProvider>(context, listen: false);
    final serverAddress = Provider.of<SettingsController>(context, listen: false).serverAddress.value;
    final playerName = Provider.of<SettingsController>(context, listen: false).playerName.value;
    final network = Provider.of<NetworkAgent>(context, listen: false);
    return network.ws_connect('wss://$serverAddress:28888/ws', playerName, gameState, room, enteredPasscode);
  }

  // This function shows the passcode dialog
  Future<void> _showPasscodeDialog(BuildContext ctx, String room) async {
    return showDialog<void>(
      context: ctx,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final mediaQuery = MediaQuery.of(context);
        final viewInsets = mediaQuery.viewInsets;
        final isKeyboardVisible = viewInsets.bottom != 0.0;
        return AlertDialog(
          content: TextField(
            obscureText: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Passcode Room $room:'),
            onChanged: (value) {
              enteredPasscode = value;
            },
          ),
          actions: <Widget>[
            if (!isKeyboardVisible)
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            if (!isKeyboardVisible)
            ElevatedButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog on confirm
                _log.info('Entered passcode: $enteredPasscode');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return Scaffold(
      backgroundColor: palette.backgroundLevelSelection,
      body: ResponsiveScreen(
        squarishMainArea: Column(
          children: [
            // if (true)
            // BackdropFilter(
            //   filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Apply blur effect
            //   child: Container(
            //     color: Colors.black.withOpacity(0.5),
            //     child: const Center(
            //       child: CircularProgressIndicator(), // Show loading indicator
            //     ),
            //   ),
            // ),
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
                        audioController.playSfx(SfxType.btnTap);

                        _showPasscodeDialog(context, room.ID.toString()).then((value) {
                          _log.info('Passcode dialog closed');
                          _connectToServer(context, room.ID.toString(), enteredPasscode).then((onValue) {
                              if (onValue) {
                                GoRouter.of(context).go('/lobby/playing');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text("Connection failed"),
                                  ));
                              }
                            });
                          },
                        );
                      }, // onTap
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
            audioController.playSfx(SfxType.btnTap);

            GoRouter.of(context).go('/');
          },
          child: const Text('Main Menu'),
          // Removed invalid constant
        ),
      ),
    );
  }
}