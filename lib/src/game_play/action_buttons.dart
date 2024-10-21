

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:poker_with_friends/src/audio/audio_controller.dart';
import 'package:poker_with_friends/src/audio/sounds.dart';
import 'package:poker_with_friends/src/game_internals/poker_game_state.dart';
import 'package:poker_with_friends/src/game_play/raiser_menu.dart';
import 'package:poker_with_friends/proto/message.pb.dart' as proto;

enum ButtonType {
  unknown,
  fold,
  checkFold,
  check,
  call,
  raise,
}
class ButtonStateProvider extends ChangeNotifier {
  ButtonType _selectedButtonType = ButtonType.unknown;

  bool get foldEnabled => _selectedButtonType == ButtonType.fold;
  bool get checkFoldEnabled => _selectedButtonType == ButtonType.checkFold;
  bool get checkEnabled => _selectedButtonType == ButtonType.check;
  bool get callEnabled => _selectedButtonType == ButtonType.call;
  bool get raiseEnabled => _selectedButtonType == ButtonType.raise;

  void resetButtonState() {
    _selectedButtonType = ButtonType.unknown;
  }

  void toggleButtonState(ButtonType type) {
    if (_selectedButtonType == type) {
        _selectedButtonType = ButtonType.unknown; // If the same button is clicked again, deactivate it
    } else {
      _selectedButtonType = type; // Activate the clicked button
    }
    notifyListeners();
  }
}

const int buttonSizeWidth = 130;
const int buttonSizeHeight = 35;

class ActionButtons extends StatelessWidget {
  final int playerIndex;
  final void Function(String buttonName, int id) onButtonPress;
  final void Function(int id, int amount) onRaiseButtonPress;

  const ActionButtons({super.key, required this.playerIndex, required this.onButtonPress, required this.onRaiseButtonPress});

  void _handleCheckFold(PokerGameStateProvider gameState) {
    debugPrint('Check/Fold button pressed');
    if (gameState.currentBet == gameState.playerM.getBet) {
      onButtonPress('CHECK', playerIndex);
    } else {
      onButtonPress('FOLD', playerIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final audioController = context.read<AudioController>();
    final gameState = context.watch<PokerGameStateProvider>();
    final buttonState = context.watch<ButtonStateProvider>();

    debugPrint('ActionButtons build: playerIndex=$playerIndex, playerMainIndex=${gameState.playerMainIndex} gameState.shouldShowButton=${gameState.shouldShowButton} gameState.playerM.getState=${gameState.playerM.getState}');
    if (gameState.hasPlayerMainIndex && gameState.playerM.getState == proto.PlayerStatusType.Sat_Out) {
      return Text(
        textAlign : TextAlign.center,
        'Buy-in to play',
        style: TextStyle(
          color: Colors.white.withOpacity(0.80),
          fontSize: 18,
          fontWeight: FontWeight.w500,
          fontFamily: 'Permanent Marker',
          height: 1.6,
        ),
      );
    } else if (gameState.hasPlayerMainIndex && gameState.playerM.getState == proto.PlayerStatusType.Spectating) {
      return Text(
        textAlign : TextAlign.center,
        'Waiting for next hand',
        style: TextStyle(
          color: Colors.white.withOpacity(0.80),
          fontSize: 18,
          fontWeight: FontWeight.w500,
          fontFamily: 'Permanent Marker',
          height: 1.6,
        ),
      );
    }
    if (!(gameState.hasPlayerMainIndex && gameState.shouldShowButton && gameState.playerM.getState != proto.PlayerStatusType.Folded)) {
      return const SizedBox.shrink();
    }

    final buttonStateAvailable = (gameState.hasPlayerMainIndex && gameState.playerM.getState == proto.PlayerStatusType.Wait4Act);
    if (buttonStateAvailable) {
      if (buttonState.checkFoldEnabled) {
        _handleCheckFold(gameState);
      }
      buttonState.resetButtonState();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: buttonSizeWidth.toDouble(), // Fixed width for the button
          height: buttonSizeHeight.toDouble(), // Fixed height for the button
          child: ElevatedButton(
            onPressed: () {
              audioController.playSfx(SfxType.btnTap);
              onButtonPress('FOLD', playerIndex);
              context.read<RaiserProvider>().closeRaiser();
            },
            // onPressed: () => gameState.touch(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xfff4f3fa).withOpacity(0.85),
              padding: const EdgeInsets.all(2), // Remove default padding since size is fixed
              textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            child: const Text('FOLD'),
          ),
        ),
        const SizedBox(width: 6), // Space between buttons
        SizedBox(
          width: buttonSizeWidth.toDouble() + 10, // Fixed width for the button
          height: buttonSizeHeight.toDouble(), // Fixed height for the button
          child: ElevatedButton(
            onPressed: () {
              audioController.playSfx(SfxType.btnTap);
              if (buttonStateAvailable){
                _handleCheckFold(gameState);
              } else {
                buttonState.toggleButtonState(ButtonType.checkFold);
              }
              context.read<RaiserProvider>().closeRaiser();
            },
            // onPressed: () => gameState.touch(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xfff4f3fa).withOpacity(0.85),
              padding: const EdgeInsets.all(2), // Remove default padding since size is fixed
              textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 2.5),
                Checkbox(
                  value: buttonState.checkFoldEnabled,
                  onChanged: null,
                  activeColor: Colors.greenAccent,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                ), const Text('CHECK/FOLD'),
              ],
            ),
          ),
        ),
        const SizedBox(width: 6), // Space between buttons
        SizedBox(
          width: buttonSizeWidth.toDouble(), // Fixed width for the button
          height: buttonSizeHeight.toDouble(), // Fixed height for the button
          child: ElevatedButton(
            onPressed: () {
              audioController.playSfx(SfxType.btnTap);
              onButtonPress('CHECK', playerIndex);
              context.read<RaiserProvider>().closeRaiser();
              // // For test only - set increment each time the button is pressed from 0 to 9 for testing
              // gameState.setCurrentButtonIndex((gameState.currentButtonIndex + 1) % 10);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: gameState.currentBet == gameState.playerM.getBet ? const Color(0xfff4f3fa).withOpacity(0.85): Colors.white30,
              padding: const EdgeInsets.all(2), // Remove default padding since size is fixed
              textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            child: gameState.currentBet == gameState.playerM.getBet ? const Text('CHECK'): const SizedBox.shrink(),
          ),
        ),
        const SizedBox(width: 6), // Space between buttons
        SizedBox(
          width: buttonSizeWidth.toDouble(), // Fixed width for the button
          height: buttonSizeHeight.toDouble(), // Fixed height for the button
          child: ElevatedButton(
            onPressed: () {
              if (gameState.currentBet == gameState.playerM.getBet) {
                return;
              }
              audioController.playSfx(SfxType.btnTap);
              buttonStateAvailable ? onButtonPress('CALL', gameState.playerMainIndex): buttonState.toggleButtonState(ButtonType.call);
              context.read<RaiserProvider>().closeRaiser();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: gameState.currentBet == gameState.playerM.getBet ? Colors.white30:const Color(0xfff4f3fa).withOpacity(0.85),
              padding: const EdgeInsets.all(2), // Remove default padding since size is fixed
              textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            child: gameState.currentBet == gameState.playerM.getBet ? const SizedBox.shrink() : Text('CALL ${() {
              final callAmount = gameState.currentBet - gameState.playerM.getBet;
              if (callAmount > gameState.playerM.getChips) {
                return gameState.playerM.getChips.toString();
              }
              return (callAmount > 0 && gameState.playerM.getState == proto.PlayerStatusType.Wait4Act) ? callAmount.toString() : '';
            }()}'),
          ),
        ),
        const SizedBox(width: 6), // Space between buttons
        SizedBox(
          width: buttonSizeWidth.toDouble(), // Fixed width for the button
          height: buttonSizeHeight.toDouble(), // Fixed height for the button
          child: ElevatedButton(
            onPressed: () {
              if (gameState.playerM.getChips <= gameState.currentBet) {
                return;
              }
              audioController.playSfx(SfxType.btnTap);
              final raiserProvider = context.read<RaiserProvider>();
              if (raiserProvider.isRaiserVisible) {
                raiserProvider.isMax ? onRaiseButtonPress(gameState.playerMainIndex, 0x7FFFFFFF) :
                  onRaiseButtonPress(gameState.playerMainIndex, raiserProvider.currentRaiseAmountAsInt);
              }
              raiserProvider.setMinRaiseValue(gameState.currentBet, gameState.playerM.getChips, gameState.totalPot);
              raiserProvider.toggleRaiserVisibility();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: gameState.playerM.getChips <= gameState.currentBet ? Colors.white30 : const Color(0xfff4f3fa).withOpacity(0.85),
              padding: const EdgeInsets.all(2), // Remove default padding since size is fixed
              textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: gameState.playerM.getChips <= gameState.currentBet ? const SizedBox.shrink()
            : Text(context.watch<RaiserProvider>().isRaiserVisible ? 'CONFIRM' : gameState.currentBet == 0 ? 'BET' : 'RAISE'),
          ),
        ),
      ],
    );
  }
}