import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import '../network_agent/network_agent.dart';
import '../message_format/client_message_builder.dart';
import '../game_internals/poker_game_state.dart';
import '../audio/audio_controller.dart';
import '../audio/sounds.dart';

// This class will manage the state of the selected dropdown value.
class DropdownProvider with ChangeNotifier {
  // List of dropdown items
  final List<String> _items = ['Balance Board', 'Start Game', '+1 Buy-In', '-1 Buy-In', 'Stand Up'];

  late String _selectedItem;

  DropdownProvider() {
    _selectedItem = _items[0]; // Initialize with the first option
  }

  // Getter for the list of items
  List<String> get items => _items;

  // Getter for the currently selected item
  String get selectedItem => _selectedItem;

  // Method to update the selected item and notify listeners
  void updateSelectedItem(String newItem) {
    _selectedItem = newItem;
    notifyListeners(); // Notify listeners to rebuild the UI
  }
}

class DropdownMenu extends StatelessWidget {
  final _log = Logger('DropdownMenu');
  DropdownMenu({super.key});

  void _handleMenu(String command, NetworkAgent networkAgent, PokerGameState gameState) {
     _log.info('Selected item: $command, main player index: ${gameState.playerMainIndex}');
    switch (command) {
      case 'Balance Board':
        networkAgent.sendMessageAsync(ClientMessageBuilder.build('balance_board', gameState.playerMainIndex).toProto());
        return ;
      case 'Start Game':
        networkAgent.sendMessageAsync(ClientMessageBuilder.build('start_game', gameState.playerMainIndex).toProto());
        return ;
      case 'Stand Up':
        if (gameState.hasPlayerMainIndex) {
          gameState.mainPlayerLeave();
          networkAgent.sendMessageAsync(ClientMessageBuilder.build('leave_game', gameState.playerMainIndex).toProto());
        }
        break;
      case '+1 Buy-In':
        networkAgent.sendMessageAsync(ClientMessageBuilder.build('request_buyin', gameState.playerMainIndex).toProto());
        break;
      case '-1 Buy-In':
        networkAgent.sendMessageAsync(ClientMessageBuilder.build('payback_buyin', gameState.playerMainIndex).toProto());
        break;
      default:
        return ;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access the provider using context.watch() or context.read()
    final dropdownProvider = context.watch<DropdownProvider>();
    final networkAgent = context.read<NetworkAgent>();
    final gameState = context.read<PokerGameState>();
    final audioControler = context.read<AudioController>();

    return DropdownButton<String>(
      //value: dropdownProvider.selectedItem, // Bind selected item to the provider's state
      items: dropdownProvider.items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (String? newValue) {
        // Update selected item in the provider
        if (newValue != null) {
          audioControler.playSfx(SfxType.btnTap);
          _handleMenu(newValue, networkAgent, gameState);
          dropdownProvider.updateSelectedItem(newValue);
        }
      },
      // Optional styling
      menuWidth: 150,

      hint: const Row(children: [
          SizedBox(width: 80),
          Text('Menu',
            style: TextStyle(
              color: Color(0xFFE0E0E0),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      dropdownColor: const Color(0xFFE0E0E0),
      icon: const Icon(Icons.arrow_drop_down),
      // iconSize: 5,
      underline: Container(
        color: Colors.blueAccent,
      ),
    );
  }
}
