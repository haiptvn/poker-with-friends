import 'package:flutter/foundation.dart';

class RoomLoginState extends ChangeNotifier {
  String _selectedRoom = '';
  String _playerName = '';
  String _passCode = '';


  String get selectedRoom => _selectedRoom;
  String get playerName => _playerName;
  String get passCode => _passCode;

  void setRoomLoginState(String room, String player, String code) {
    _selectedRoom = room;
    _playerName = player;
    _passCode = code;
    notifyListeners();
  }
}