// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/foundation.dart';

import '../../proto/message.pb.dart' as $proto;

class PlayingSlot {
  $proto.PlayerStatusType _state = $proto.PlayerStatusType.Playing;
  String _name = '';
  int _chips = 0;
  bool _showCards = false;
  $proto.Card _card1 = $proto.Card();
  $proto.Card _card2 = $proto.Card();
  int _bet = 0;

  $proto.PlayerStatusType get getState => _state;
  String get getName => _name;
  int get getChips => _chips;
  bool get showCards => _showCards;
  $proto.Card get getCard1 => _card1;
  $proto.Card get getCard2 => _card2;
  int get getBet => _bet;

  void addCard($proto.Card card1, $proto.Card card2) {
    _card1 = card1;
    _card2 = card2;
  }
  void setState($proto.PlayerStatusType newState) {
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
  void setBet(int finalBet) {
    _bet = finalBet;
  }
  void reset() {
    _bet = 0;
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
  int _currentButtonIndex = 0;
  int _currentTurnIndex = 0;
  final List<$proto.Card> _communityCards = [];
  int _totalPot = 0;
  int _currentBet = 0;

  PlayingSlot get playerC => _players[_playerMainIndex % _maxPlayers];
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
  int get currentButtonIndex => _currentButtonIndex;
  int get currentBet => _currentBet;
  PlayingSlot getPlayerByIndex(int index) => _players[index];

  int count = 0;

  void touch() {
    if (count++ < 5) {
      return;
    }

    // Try to change the state for testing
    playerC.setState($proto.PlayerStatusType.Playing);
    player1.setState($proto.PlayerStatusType.SB);
    player2.setState($proto.PlayerStatusType.BB);
    player3.setState($proto.PlayerStatusType.Wait4Act);

    playerC.setBet(100);
    player1.setBet(100);
    player2.setBet(200);
    player3.setBet(200);
    player4.setBet(200);
    player5.setBet(200);
    player6.setBet(200);
    player7.setBet(200);
    player8.setBet(200);
    player9.setBet(200);

    _currentBet = 200;

    playerC.setName('Harry');
    player1.setName('Mie');
    player2.setName('Kane');
    player3.setName('Calie');
    player4.setName('Thierry');
    player5.setName('Hugo');
    player6.setName('Messi');
    player7.setName('Neymar');
    player8.setName('Ronaldo');
    player9.setName('Mbappe');

    playerC.setChips(count++);
    player1.setChips(count++);
    player2.setChips(count++);
    player3.setChips(count++);
    player4.setChips(count++);
    player5.setChips(count++);
    player6.setChips(count++);
    player7.setChips(count++);
    player8.setChips(count++);
    player9.setChips(count++);
    count += 1000;

    playerC.addCard($proto.Card(rank: $proto.RankType.ACE, suit: $proto.SuitType.HEARTS),
     $proto.Card(rank: $proto.RankType.ACE, suit: $proto.SuitType.DIAMONDS));
    player1.addCard($proto.Card(rank: $proto.RankType.KING, suit: $proto.SuitType.HEARTS),
      $proto.Card(rank: $proto.RankType.KING, suit: $proto.SuitType.DIAMONDS));
    player2.addCard($proto.Card(rank: $proto.RankType.QUEEN, suit: $proto.SuitType.HEARTS),
      $proto.Card(rank: $proto.RankType.QUEEN, suit: $proto.SuitType.DIAMONDS));
    player3.addCard($proto.Card(rank: $proto.RankType.JACK, suit: $proto.SuitType.HEARTS),
      $proto.Card(rank: $proto.RankType.JACK, suit: $proto.SuitType.DIAMONDS));
    player4.addCard($proto.Card(rank: $proto.RankType.TEN, suit: $proto.SuitType.HEARTS),
      $proto.Card(rank: $proto.RankType.TEN, suit: $proto.SuitType.DIAMONDS));
    player5.addCard($proto.Card(rank: $proto.RankType.NINE, suit: $proto.SuitType.HEARTS),
      $proto.Card(rank: $proto.RankType.NINE, suit: $proto.SuitType.DIAMONDS));
    player6.addCard($proto.Card(rank: $proto.RankType.EIGHT, suit: $proto.SuitType.HEARTS),
      $proto.Card(rank: $proto.RankType.EIGHT, suit: $proto.SuitType.DIAMONDS));
    player7.addCard($proto.Card(rank: $proto.RankType.SEVEN, suit: $proto.SuitType.HEARTS),
      $proto.Card(rank: $proto.RankType.SEVEN, suit: $proto.SuitType.DIAMONDS));
    player8.addCard($proto.Card(rank: $proto.RankType.SIX, suit: $proto.SuitType.HEARTS),
      $proto.Card(rank: $proto.RankType.SIX, suit: $proto.SuitType.DIAMONDS));
    player9.addCard($proto.Card(rank: $proto.RankType.FIVE, suit: $proto.SuitType.HEARTS),
      $proto.Card(rank: $proto.RankType.FIVE, suit: $proto.SuitType.DIAMONDS));


    if (count > 10000) {
      resetGame();
      _players.forEach((player) => player.setName(''));
      count = 0;
      _currentBet = 0;
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
    // _currentTurnIndex = index;
    _currentTurnIndex = (_currentTurnIndex + 1) % (_maxPlayers);
    notifyListeners();
  }

  void setCurrentButtonIndex(int index) {
    _currentButtonIndex = index;
    notifyListeners();
  }

  void setCurrentBet(int bet) {
    _currentBet = bet;
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