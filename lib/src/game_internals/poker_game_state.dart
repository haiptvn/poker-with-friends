import 'package:flutter/foundation.dart';

import '../../proto/message.pb.dart' as $proto;

class PlayingSlot {
  String _state = '';
  String _name = '';
  int _chips = 0;
  List<$proto.Card> _cards = [];
  bool _showCards = false;

  String get getState => _state;
  String get getName => _name;
  int get getChips => _chips;
  List<$proto.Card> get getCards => _cards;
  bool get showCards => _showCards;

  void addCard($proto.Card card) {
    _cards.add(card);
  }
  void setState(String newState) {
    _state = newState;
  }
  void setName(String newName) {
    _name = newName;
  }
  void setChips(int newChips) {
    _chips = newChips;
  }
  void setShowCards(bool show) {
    _showCards = show;
  }
  void reset() {
    _state = '';
    _cards = [];
  }
}

class PokerGameState extends ChangeNotifier {
  final int _maxPlayers = 10;
  List<PlayingSlot> _players = [
    PlayingSlot(), // 0
    PlayingSlot(), // 1
    PlayingSlot(), // 2
    PlayingSlot(), // 3
    PlayingSlot(), // 4
    PlayingSlot(), // 5
    PlayingSlot(), // 6
    PlayingSlot(), // 7
    PlayingSlot(), // 8
    PlayingSlot(), // 9
  ];
  int _playerMainIndex = 0;
  int _currentTurnIndex = 0;

  List<$proto.Card> _communityCards = [];
  int _totalPot = 0;

  PlayingSlot get playerMain => _players[_playerMainIndex % _maxPlayers];
  PlayingSlot get player1 => _players[(_playerMainIndex+ 1) % _maxPlayers];
  PlayingSlot get player2 => _players[(_playerMainIndex+ 2) % _maxPlayers];
  PlayingSlot get player3 => _players[(_playerMainIndex+ 3) % _maxPlayers];
  PlayingSlot get player4 => _players[(_playerMainIndex+ 4) % _maxPlayers];
  PlayingSlot get player5 => _players[(_playerMainIndex+ 5) % _maxPlayers];
  PlayingSlot get player6 => _players[(_playerMainIndex+ 6) % _maxPlayers];
  PlayingSlot get player7 => _players[(_playerMainIndex+ 7) % _maxPlayers];
  PlayingSlot get player8 => _players[(_playerMainIndex+ 8) % _maxPlayers];
  PlayingSlot get player9 => _players[(_playerMainIndex+ 9) % _maxPlayers];

  List<$proto.Card> get communityCards => _communityCards;
  int get totalPot => _totalPot;
  int get currentTurnIndex => _currentTurnIndex;

  void setPlayerMainIndex(int index) {
    _playerMainIndex = index;
    notifyListeners();
  }

  void dealCardToPlayer(String player, String card) {
    notifyListeners();
  }

  void dealCommunityCard($proto.Card card) {
    _communityCards.add(card);
    notifyListeners();
  }

  void setCurrentTurnIndex(int index) {
    _currentTurnIndex = index;
    notifyListeners();
  }

  void resetGame() {
    _players.forEach((player) => player.reset());
    _currentTurnIndex = 0;
    _totalPot = 0;
    _communityCards.clear();
    notifyListeners();
  }
}