// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

enum SfxType {
  btnTap,
  check,
  callBet,
  raise,
  fold,
  collect,
  dealCommunity,
  yourTurn,
}


List<String> soundTypeToFilename(SfxType type) {
  switch (type) {
    case SfxType.btnTap:
      return const [
        'btn_tap.mp3',
      ];
    case SfxType.check:
      return const [
        'check.mp3',
      ];
    case SfxType.callBet:
      return const [
        'call_bet.mp3',
      ];
    case SfxType.raise:
      return const [
        'raise.mp3',
      ];
    case SfxType.fold:
      return const [
        'fold.mp3',
      ];
    case SfxType.collect:
      return const [
        'collect.mp3',
      ];
    case SfxType.dealCommunity:
      return const [
        'deal_community.mp3',
      ];
    case SfxType.yourTurn:
      return const [
        'your_turn.mp3',
      ];
  }
}

/// Allows control over loudness of different SFX types.
double soundTypeToVolume(SfxType type) {
  switch (type) {
    case SfxType.btnTap:
    case SfxType.check:
    case SfxType.callBet:
    case SfxType.raise:
    case SfxType.fold:
    case SfxType.collect:
    case SfxType.dealCommunity:
    case SfxType.yourTurn:
      return 0.5;
  }
}
