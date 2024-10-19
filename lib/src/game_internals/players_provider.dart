

import 'package:flutter/material.dart';
import 'package:poker_with_friends/proto/message.pb.dart' as proto;

class Player extends ChangeNotifier {
  String? _name;
  int? _chips;
  int? _bet;

  proto.Card _card1 = proto.Card();
  proto.Card _card2 = proto.Card();
}

class PlayerProvider extends ChangeNotifier {
  final List<Player> _players = [
    Player(), // 0
    Player(), // 1
    Player(), // 2
    Player(), // 3
    Player(), // 4
    Player(), // 5
    Player(), // 6
    Player(), // 7
    Player(), // 8
    Player(), // 9
  ];

  Player? getPlayer(int idx) => _players[idx];
  List<Player> get players => _players;
}