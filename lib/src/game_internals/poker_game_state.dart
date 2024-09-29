// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
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
  bool hasCards() {
    return _card1.rank != $proto.RankType.UNSPECIFIED_RANK && _card2.rank != $proto.RankType.UNSPECIFIED_RANK;
  }
  void resetCards() {
    _card1 = $proto.Card();
    _card2 = $proto.Card();
  }
  void reset() {
    _state = $proto.PlayerStatusType.Playing;
    _name = '';
    _chips = 0;
    _showCards = false;
    _bet = 0;
  }
  void reinit() {
    _state = $proto.PlayerStatusType.Playing;
    _name = '';
    _chips = 0;
    _showCards = false;
    _card1 = $proto.Card();
    _card2 = $proto.Card();
    _bet = 0;
  }
}

class PokerGameState extends ChangeNotifier {
  static final _log = Logger('PokerGameState');
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
  bool _hasPlayerMainIndex = false;
  int _playerMainIndex = 0;
  int _forUiDisplayIndex = 0;
  int _currentButtonIndex = 0;
  final List<$proto.Card> _communityCards = [];
  int _totalPot = 0;
  int _currentBet = 0;

  PlayingSlot get playerC => _players[0];
  PlayingSlot get player1 => _players[1];
  PlayingSlot get player2 => _players[2];
  PlayingSlot get player3 => _players[3];
  PlayingSlot get player4 => _players[4];
  PlayingSlot get player5 => _players[5];
  PlayingSlot get player6 => _players[6];
  PlayingSlot get player7 => _players[7];
  PlayingSlot get player8 => _players[8];
  PlayingSlot get player9 => _players[9];

  bool get hasPlayerMainIndex => _hasPlayerMainIndex;
  int get playerMainIndex => _playerMainIndex;
  int get maxPlayers => _maxPlayers;
  int get forUiDisplayIndex => _forUiDisplayIndex;
  List<$proto.Card> get communityCards => _communityCards;
  int get totalPot => _totalPot;
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
    _hasPlayerMainIndex = true;
    notifyListeners();
  }

  void dealCardToPlayer(String player, String card) {
    notifyListeners();
  }

  void dealCommunityCard($proto.Card card) {
    _communityCards.add(card);
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

  void updateGameState($proto.ServerMessage message) {
    if (message.hasGameState()) {
      _players.forEach((player) => player.reset());
      if (_forUiDisplayIndex != _playerMainIndex) {
        _forUiDisplayIndex = _playerMainIndex;
      }

      _communityCards.clear();
      message.gameState.communityCards.forEach((card) {
        _communityCards.add(card);
      });

      _currentButtonIndex = (_maxPlayers - _forUiDisplayIndex +  message.gameState.dealerId) % _maxPlayers;
      _currentBet = message.gameState.currentBet;
      _totalPot = message.gameState.potSize;

      if (message.gameState.currentRound == $proto.RoundStateType.SHOWDOWN &&
          message.gameState.hasFinalResult()) {
          message.gameState.finalResult.showingCards.forEach((showingCard) {
          final index = (_maxPlayers - _forUiDisplayIndex + showingCard.tablePos) % _maxPlayers;
          if (showingCard.playerCards.isNotEmpty) {
            _log.info('Showing card: $showingCard, UX index: $index');
            _players[index].addCard(showingCard.playerCards[0], showingCard.playerCards[1]);
          }
        });
      } else if (message.gameState.currentRound == $proto.RoundStateType.INITIAL) {
        resetGame();
        _players.forEach((player) => player.reinit());
      } else if (message.gameState.currentRound == $proto.RoundStateType.PREFLOP) {
        for (var i = 1; i < _maxPlayers; i++) { _players[i].resetCards(); }
      }

      message.gameState.players.forEach((player) {
        final index = (_maxPlayers - _forUiDisplayIndex + player.tablePosition) % _maxPlayers;
        _players[index].setState(player.status);
        _players[index].setName(player.name);
        _players[index].setChips(player.chips);
        _players[index].setBet(player.currentBet);
      });
    }

    if (message.hasPeerState()) {
      if (_hasPlayerMainIndex && message.peerState.playerCards.isNotEmpty) {
        _players[0].addCard(message.peerState.playerCards[0], message.peerState.playerCards[1]);
      }
    }

    notifyListeners();
  }

  void resetGame() {
    _players.forEach((player) => player.reset());
    _currentBet = 0;
    _totalPot = 0;
    _communityCards.clear();
    notifyListeners();
  }

  void mainPlayerLeave() {
    _players[_playerMainIndex].reset();
    _hasPlayerMainIndex = false;
    notifyListeners();
  }

  void reinit() {
    _log.info('Reinitializing game state');
    _players.forEach((player) => player.reinit());
    _totalPot = 0;
    _communityCards.clear();
    _currentButtonIndex = 0;
    _currentBet = 0;
    _hasPlayerMainIndex = false;
    _forUiDisplayIndex = 0;
  }
}
