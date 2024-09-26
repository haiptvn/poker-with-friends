import 'package:flutter/foundation.dart';

import '../../proto/message.pb.dart' as $proto;

class PlayingSlot {
  String _state = '';
  String _name = '';
  int _chips = 0;
  bool _showCards = false;
  $proto.Card _card1 = $proto.Card();
  $proto.Card _card2 = $proto.Card();

  String get getState => _state;
  String get getName => _name;
  int get getChips => _chips;
  bool get showCards => _showCards;
  $proto.Card get getCard1 => _card1;
  $proto.Card get getCard2 => _card2;

  void addCard($proto.Card card1, $proto.Card card2) {
    _card1 = card1;
    _card2 = card2;
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
    _card1 = $proto.Card();
    _card2 = $proto.Card();
  }
}

class PokerGameState extends ChangeNotifier {
  final int _maxPlayers = 10;
  final List<PlayingSlot> _players = [
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

  final List<$proto.Card> _communityCards = [];
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

  int count = 0;

  void touch() {
    if (count++ < 5) {
      return;
    }

    // Try to change the state for testing
    playerMain.setState('DEALER');
    player1.setState('SMALL BLIND');
    player2.setState('BIG BLIND');

    playerMain.setName('Player 1');
    player1.setName('Player 2');
    player2.setName('Player 3');
    player3.setName('Player 4');
    player4.setName('Player 5');
    player5.setName('Player 6');
    player6.setName('Player 7');
    player7.setName('Player 8');
    player8.setName('Player 9');

    playerMain.setChips(count++);
    player1.setChips(count++);
    player2.setChips(count++);
    player3.setChips(count++);
    player4.setChips(count++);
    player5.setChips(count++);
    player6.setChips(count++);
    player7.setChips(count++);
    player8.setChips(count++);

    playerMain.addCard($proto.Card(rank: $proto.RankType.ACE, suit: $proto.SuitType.HEARTS),
     $proto.Card(rank: $proto.RankType.ACE, suit: $proto.SuitType.DIAMONDS));

    if (count > 100) {
      resetGame();
      _players.forEach((player) => player.setName(''));
      count = 0;
    }

    // This will notify all listeners
    notifyListeners();
  }

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