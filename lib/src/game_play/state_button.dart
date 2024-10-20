import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:poker_with_friends/src/game_internals/poker_game_state.dart';
import 'package:poker_with_friends/proto/message.pb.dart' as proto;

class ToggleButton extends StatefulWidget {
  final int playerIndex;
  final VoidCallback onPressed; // The action to perform when it's the player's turn

  const ToggleButton({
    Key? key,
    required this.playerIndex,
    required this.onPressed,
  }) : super(key: key);

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool _isToggled = false; // Holds the toggle state of the button

  @override
  Widget build(BuildContext context) {
    return Consumer<PokerGameStateProvider>(
      builder: (context, gameState, child) {
        final isPlayerTurn = gameState.playerM.getState == proto.PlayerStatusType.Wait4Act;

        return ElevatedButton(
          onPressed: () {
            // Only allow toggle if it's not this player's turn
            if (!isPlayerTurn) {
              setState(() {
                _isToggled = !_isToggled; // Toggle the button state
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _isToggled ? Colors.green : Colors.grey,
          ),
          child: Text(_isToggled ? 'Toggled ON' : 'Toggled OFF'),
        );
      },
    );
  }
}
