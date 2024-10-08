// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:poker_with_friends/src/audio/audio_controller.dart';
import 'package:poker_with_friends/src/audio/sounds.dart';
import 'package:poker_with_friends/src/game_play/balance_board.dart';
import '../../proto/message.pb.dart' as proto;

class PlayingSlot {
  proto.PlayerStatusType _state = proto.PlayerStatusType.Playing;
  bool _isStateChanged = false;
  String _name = '';
  int _chips = 0;
  bool _showCards = false;
  proto.Card _card1 = proto.Card();
  proto.Card _card2 = proto.Card();
  int _bet = 0;
  bool _isFolded = false;
  String _handRanking = '';

  proto.PlayerStatusType get getState => _state;
  String get getName => _name;
  int get getChips => _chips;
  bool get showCards => _showCards;
  proto.Card get getCard1 => _card1;
  proto.Card get getCard2 => _card2;
  int get getBet => _bet;
  bool get isFolded => _isFolded;
  String get handRanking => _handRanking;

  bool get isStateChanged => _isStateChanged;
  bool get hasCards => _card1.rank != proto.RankType.UNSPECIFIED_RANK && _card2.rank != proto.RankType.UNSPECIFIED_RANK;

  void clearStateChanged() {
    _isStateChanged = false;
  }

  void addCard(proto.Card card1, proto.Card card2) {
    _card1 = card1;
    _card2 = card2;
  }
  void setState(proto.PlayerStatusType newState) {
    _isStateChanged = _state != newState;
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
  void setFolded() {
      _isFolded = true;
  }
  void setHandRanking(String ranking) {
    _handRanking = ranking;
  }
  void resetCards() {
    _card1 = proto.Card();
    _card2 = proto.Card();
  }
  void reset() {
    _state = proto.PlayerStatusType.Ready;
    _name = '';
    _chips = 0;
    _showCards = false;
    _bet = 0;
    _isFolded = false;
    _handRanking = '';
  }
  void reinit() {
    _state = proto.PlayerStatusType.Ready;
    _name = '';
    _chips = 0;
    _showCards = false;
    _card1 = proto.Card();
    _card2 = proto.Card();
    _bet = 0;
    _isFolded = false;
    _handRanking = '';
  }
}

class PokerGameStateProvider extends ChangeNotifier {
  static final _log = Logger('PokerGameStateProvider');
  AudioController? audioController;

  // Todo remove this temp
  bool? _isPlayWinnerSfx;

  int _rxCount = 0;
  int _internalCurrentTurn = 0;
  int _internalLastTurn = -1;
  proto.RoundStateType _internalLastRound = proto.RoundStateType.INITIAL;

  attachAudioController(AudioController audioController) {
    this.audioController = audioController;
  }

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
  bool _shouldShowButton = false;
  int _forUiDisplayIndex = 0;
  int _currentButtonIndex = 0;
  final List<proto.Card> _communityCards = [];
  int _totalPot = 0;
  int _currentBet = 0;
  List<proto.PlayerBalance> _playerBalances = [];

  // Getters
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
  bool get shouldShowButton => _shouldShowButton;
  List<proto.Card> get communityCards => _communityCards;
  int get totalPot => _totalPot;
  int get currentButtonIndex => _currentButtonIndex;
  int get currentBet => _currentBet;
  PlayingSlot getPlayerByIndex(int index) => _players[index];
  List<proto.PlayerBalance> get playerBalances => _playerBalances;


  int count = 0;

  void touch() {
    if (count++ < 5) {
      return;
    }

    // Try to change the state for testing
    playerC.setState(proto.PlayerStatusType.Playing);
    player1.setState(proto.PlayerStatusType.SB);
    player2.setState(proto.PlayerStatusType.BB);
    player3.setState(proto.PlayerStatusType.Wait4Act);

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

    playerC.addCard(proto.Card(rank: proto.RankType.ACE, suit: proto.SuitType.HEARTS),
     proto.Card(rank: proto.RankType.ACE, suit: proto.SuitType.DIAMONDS));
    player1.addCard(proto.Card(rank: proto.RankType.KING, suit: proto.SuitType.HEARTS),
      proto.Card(rank: proto.RankType.KING, suit: proto.SuitType.DIAMONDS));
    player2.addCard(proto.Card(rank: proto.RankType.QUEEN, suit: proto.SuitType.HEARTS),
      proto.Card(rank: proto.RankType.QUEEN, suit: proto.SuitType.DIAMONDS));
    player3.addCard(proto.Card(rank: proto.RankType.JACK, suit: proto.SuitType.HEARTS),
      proto.Card(rank: proto.RankType.JACK, suit: proto.SuitType.DIAMONDS));
    player4.addCard(proto.Card(rank: proto.RankType.TEN, suit: proto.SuitType.HEARTS),
      proto.Card(rank: proto.RankType.TEN, suit: proto.SuitType.DIAMONDS));
    player5.addCard(proto.Card(rank: proto.RankType.NINE, suit: proto.SuitType.HEARTS),
      proto.Card(rank: proto.RankType.NINE, suit: proto.SuitType.DIAMONDS));
    player6.addCard(proto.Card(rank: proto.RankType.EIGHT, suit: proto.SuitType.HEARTS),
      proto.Card(rank: proto.RankType.EIGHT, suit: proto.SuitType.DIAMONDS));
    player7.addCard(proto.Card(rank: proto.RankType.SEVEN, suit: proto.SuitType.HEARTS),
      proto.Card(rank: proto.RankType.SEVEN, suit: proto.SuitType.DIAMONDS));
    player8.addCard(proto.Card(rank: proto.RankType.SIX, suit: proto.SuitType.HEARTS),
      proto.Card(rank: proto.RankType.SIX, suit: proto.SuitType.DIAMONDS));
    player9.addCard(proto.Card(rank: proto.RankType.FIVE, suit: proto.SuitType.HEARTS),
      proto.Card(rank: proto.RankType.FIVE, suit: proto.SuitType.DIAMONDS));

    communityCards.clear();
    communityCards.add(proto.Card(rank: proto.RankType.ACE, suit: proto.SuitType.CLUBS));
    communityCards.add(proto.Card(rank: proto.RankType.KING, suit: proto.SuitType.CLUBS));
    communityCards.add(proto.Card(rank: proto.RankType.QUEEN, suit: proto.SuitType.CLUBS));
    communityCards.add(proto.Card(rank: proto.RankType.JACK, suit: proto.SuitType.CLUBS));
    communityCards.add(proto.Card(rank: proto.RankType.TEN, suit: proto.SuitType.CLUBS));

    playerC.setHandRanking('Royal Flush');

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

  void dealCommunityCard(proto.Card card) {
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

  void updateGameState(proto.ServerMessage message) {
    _log.info('============================== : $_rxCount ==============================');
    _rxCount++;
    if (message.hasGameState()) {
      _players.forEach((player) => player.reset());
      if (_forUiDisplayIndex != _playerMainIndex) {
        _forUiDisplayIndex = _playerMainIndex;
      }

      final prevNumOfCards = _communityCards.length;
      _communityCards.clear();
      message.gameState.communityCards.forEach((card) {
        _communityCards.add(card);
      });
      final newNumOfCards = _communityCards.length - prevNumOfCards;
      if ( newNumOfCards == 3 || newNumOfCards == 1) {
        audioController?.playSfx(SfxType.dealCommunity);
      }

      _currentButtonIndex = (_maxPlayers - _forUiDisplayIndex +  message.gameState.dealerId) % _maxPlayers;
      _currentBet = message.gameState.currentBet;
      _totalPot = message.gameState.potSize;
      _log.info('Current button index: $_currentButtonIndex, current bet: $_currentBet, total pot: $_totalPot');

      _shouldShowButton = true;
      switch (message.gameState.currentRound) {
        case proto.RoundStateType.SHOWDOWN:
          if (message.gameState.hasFinalResult()) {
            message.gameState.finalResult.showingCards.forEach((showingCard) {
              final index = (_maxPlayers - _forUiDisplayIndex + showingCard.tablePos) % _maxPlayers;
              if (showingCard.playerCards.isNotEmpty) {
                _log.info('Showing card: $showingCard, UX index: $index');
                _players[index].addCard(showingCard.playerCards[0], showingCard.playerCards[1]);
              }
            });
          }
          _shouldShowButton = false;
          break;
        case proto.RoundStateType.INITIAL:
          resetGame();
          _players.forEach((player) => player.reinit());
          _shouldShowButton = false;
          break;
        case proto.RoundStateType.PREFLOP:
          for (var i = 1; i < _maxPlayers; i++) { _players[i].resetCards(); }
        default:
        _log.info('Not process this current round: ${message.gameState.currentRound}');
      }

      if (_internalLastRound != message.gameState.currentRound) {
        _log.info('New round detected: from $_internalLastRound to ${message.gameState.currentRound}');
        _internalLastRound = message.gameState.currentRound;
        _internalLastTurn = -1;
        _players.forEach((player) {
          if (player._state == proto.PlayerStatusType.Fold) {
            player.setFolded();
          }
        });
      }
      // To remove the hand ranking after show down to ready for the next game
      // if (message.gameState.currentRound == proto.RoundStateType.PREFLOP ||
      //     message.gameState.currentRound == proto.RoundStateType.INITIAL) {
      //   _handRanking = '';
      // }

      _internalCurrentTurn = -1; // Invalidate current turn index every time we receive a new game state about players
      message.gameState.players.forEach((player) {
        final index = (_maxPlayers - _forUiDisplayIndex + player.tablePosition) % _maxPlayers;
        _players[index].setState(player.status);
        _players[index].setName(player.name);
        _players[index].setChips(player.chips);
        _players[index].setBet(player.currentBet);
        _log.info('Player: ${player.name}, status: ${player.status}, chips: ${player.chips}, bet: ${player.currentBet}, ui index: $index');

        if (player.status == proto.PlayerStatusType.Wait4Act) { // To track the current turn index
          _internalCurrentTurn = index;
          _log.info('Store current turn index: $index');
        }
      });

      if (_internalCurrentTurn == 0 &&
          _players[_internalCurrentTurn]._state == proto.PlayerStatusType.Wait4Act) {
          audioController?.playSfx(SfxType.yourTurn);
      }
      if (message.gameState.currentRound == proto.RoundStateType.SHOWDOWN) {
        if (message.gameState.hasFinalResult() && message.gameState.finalResult.showingCards.isNotEmpty) {
          message.gameState.finalResult.showingCards.forEach((showingCard) {
            final index = (_maxPlayers - _forUiDisplayIndex + showingCard.tablePos) % _maxPlayers;
            if (showingCard.playerCards.isNotEmpty) {
              _players[index].setShowCards(true);
              _players[index].setHandRanking(showingCard.handRanking);
              _log.info('Showing hand ranking card player: ${_players[index]._name}, ranking: ${showingCard.handRanking}');
              // Todo: Find another way to replace this just not play sound for the main player when rx multiple show
              if (_players[index].getState != proto.PlayerStatusType.Ready) {
                audioController?.playSfx(SfxType.dealCommunity);
              }
            }
          });
        }
        if (_players[0]._state == proto.PlayerStatusType.WINNER) {
          if (_isPlayWinnerSfx == null || _isPlayWinnerSfx == false) {
            audioController?.playSfx(SfxType.collect);
            _isPlayWinnerSfx = true;
          }
        } else if (_players[0]._state == proto.PlayerStatusType.Playing ) {
          _communityCards.clear();
          _players.forEach((player) {
            if (player._state == proto.PlayerStatusType.Playing) {
              player.resetCards();
              // _handRanking = '';
            }
          });
        }
      }
    }

    if (message.hasBalanceInfo()) {
      message.balanceInfo.playerBalances.forEach((playerBalance) {
        _log.info('Player: ${playerBalance.playerName}, balance: ${playerBalance.balance}');
      });
      _playerBalances = message.balanceInfo.playerBalances;
    }

    _log.info('Last turn index: $_internalLastTurn');
    if (_internalLastTurn >= 0) {
      _log.info('Playing sound for ${_players[_internalLastTurn]._name} status: ${_players[_internalLastTurn]._state}');
      switch (_players[_internalLastTurn]._state) {
        case proto.PlayerStatusType.Check:
          _log.info('Playing check sound');
          audioController?.playSfx(SfxType.check);
          break;
        case proto.PlayerStatusType.Call:
        case proto.PlayerStatusType.SB:
        case proto.PlayerStatusType.BB:
          audioController?.playSfx(SfxType.callBet);
          break;
        case proto.PlayerStatusType.Raise:
        case proto.PlayerStatusType.AllIn:
          audioController?.playSfx(SfxType.raise);
          break;
        case proto.PlayerStatusType.Fold:
          audioController?.playSfx(SfxType.fold);
          break;
        default:
          _log.info('Unknown player status to play sound: ${_players[_internalLastTurn]._name}');
          break;
      }
    }
    _internalLastTurn = _internalCurrentTurn;
    _log.info('Store last turn index: $_internalLastTurn');

    if (message.hasPeerState()) {
      _log.info('Peer state detected');
      if (_hasPlayerMainIndex && message.peerState.playerCards.isNotEmpty) {
        _log.info('Peer cards detected: ${message.peerState.playerCards[0].rank}, ${message.peerState.playerCards[1].rank}');
        _players[0].addCard(message.peerState.playerCards[0], message.peerState.playerCards[1]);
        audioController?.playSfx(SfxType.dealCommunity);
      }
    }

    notifyListeners();
  }

  void resetGame() {
    _players.forEach((player) => player.reset());
    _currentBet = 0;
    _totalPot = 0;
    _communityCards.clear();

    // internal states
    _isPlayWinnerSfx = false;

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
    _playerBalances.clear();

    // internal states
    _rxCount = 0;
  }

  // Future<List<LeaderboardPlayer>> fetchLeaderboardData() async {
  //   await Future.delayed(Duration(seconds: 2));

  //   // Simulated leaderboard data from server
  //   return [
  //     LeaderboardPlayer(rank: 1, name: 'Player A', score: 1200),
  //     LeaderboardPlayer(rank: 2, name: 'Player B', score: 1150),
  //     LeaderboardPlayer(rank: 3, name: 'Player C', score: 1100),
  //     LeaderboardPlayer(rank: 4, name: 'Player D', score: 1050),
  //   ];
  // }
}

