import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

// This class will manage the state of the selected dropdown value.
class DropdownProvider with ChangeNotifier {
  // List of dropdown items
  final List<String> _items = ['Balance Board', 'Start Game', 'Leave Game', 'Take 1 Buy-In', 'Return 1 Buy-In'];

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

  @override
  Widget build(BuildContext context) {
    // Access the provider using context.watch() or context.read()
    final dropdownProvider = context.watch<DropdownProvider>();

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
          _log.info('Selected item: $newValue');
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
