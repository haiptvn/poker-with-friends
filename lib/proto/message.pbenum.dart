//
//  Generated code. Do not modify.
//  source: proto/message.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Enum for card rank
class RankType extends $pb.ProtobufEnum {
  static const RankType UNSPECIFIED_RANK = RankType._(0, _omitEnumNames ? '' : 'UNSPECIFIED_RANK');
  static const RankType DEUCE = RankType._(1, _omitEnumNames ? '' : 'DEUCE');
  static const RankType THREE = RankType._(2, _omitEnumNames ? '' : 'THREE');
  static const RankType FOUR = RankType._(3, _omitEnumNames ? '' : 'FOUR');
  static const RankType FIVE = RankType._(4, _omitEnumNames ? '' : 'FIVE');
  static const RankType SIX = RankType._(5, _omitEnumNames ? '' : 'SIX');
  static const RankType SEVEN = RankType._(6, _omitEnumNames ? '' : 'SEVEN');
  static const RankType EIGHT = RankType._(7, _omitEnumNames ? '' : 'EIGHT');
  static const RankType NINE = RankType._(8, _omitEnumNames ? '' : 'NINE');
  static const RankType TEN = RankType._(9, _omitEnumNames ? '' : 'TEN');
  static const RankType JACK = RankType._(10, _omitEnumNames ? '' : 'JACK');
  static const RankType QUEEN = RankType._(11, _omitEnumNames ? '' : 'QUEEN');
  static const RankType KING = RankType._(12, _omitEnumNames ? '' : 'KING');
  static const RankType ACE = RankType._(13, _omitEnumNames ? '' : 'ACE');

  static const $core.List<RankType> values = <RankType> [
    UNSPECIFIED_RANK,
    DEUCE,
    THREE,
    FOUR,
    FIVE,
    SIX,
    SEVEN,
    EIGHT,
    NINE,
    TEN,
    JACK,
    QUEEN,
    KING,
    ACE,
  ];

  static final $core.Map<$core.int, RankType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RankType? valueOf($core.int value) => _byValue[value];

  const RankType._($core.int v, $core.String n) : super(v, n);
}

class SuitType extends $pb.ProtobufEnum {
  static const SuitType HEARTS = SuitType._(0, _omitEnumNames ? '' : 'HEARTS');
  static const SuitType DIAMONDS = SuitType._(1, _omitEnumNames ? '' : 'DIAMONDS');
  static const SuitType CLUBS = SuitType._(2, _omitEnumNames ? '' : 'CLUBS');
  static const SuitType SPADES = SuitType._(3, _omitEnumNames ? '' : 'SPADES');

  static const $core.List<SuitType> values = <SuitType> [
    HEARTS,
    DIAMONDS,
    CLUBS,
    SPADES,
  ];

  static final $core.Map<$core.int, SuitType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SuitType? valueOf($core.int value) => _byValue[value];

  const SuitType._($core.int v, $core.String n) : super(v, n);
}

class HankRankingType extends $pb.ProtobufEnum {
  static const HankRankingType HIGH_CARD = HankRankingType._(0, _omitEnumNames ? '' : 'HIGH_CARD');
  static const HankRankingType ONE_PAIR = HankRankingType._(1, _omitEnumNames ? '' : 'ONE_PAIR');
  static const HankRankingType TWO_PAIR = HankRankingType._(2, _omitEnumNames ? '' : 'TWO_PAIR');
  static const HankRankingType THREE_OF_A_KIND = HankRankingType._(3, _omitEnumNames ? '' : 'THREE_OF_A_KIND');
  static const HankRankingType STRAIGHT = HankRankingType._(4, _omitEnumNames ? '' : 'STRAIGHT');
  static const HankRankingType FLUSH = HankRankingType._(5, _omitEnumNames ? '' : 'FLUSH');
  static const HankRankingType FULL_HOUSE = HankRankingType._(6, _omitEnumNames ? '' : 'FULL_HOUSE');
  static const HankRankingType FOUR_OF_A_KIND = HankRankingType._(7, _omitEnumNames ? '' : 'FOUR_OF_A_KIND');
  static const HankRankingType STRAIGH_FLUSH = HankRankingType._(8, _omitEnumNames ? '' : 'STRAIGH_FLUSH');
  static const HankRankingType ROYAL_FLUSH = HankRankingType._(9, _omitEnumNames ? '' : 'ROYAL_FLUSH');

  static const $core.List<HankRankingType> values = <HankRankingType> [
    HIGH_CARD,
    ONE_PAIR,
    TWO_PAIR,
    THREE_OF_A_KIND,
    STRAIGHT,
    FLUSH,
    FULL_HOUSE,
    FOUR_OF_A_KIND,
    STRAIGH_FLUSH,
    ROYAL_FLUSH,
  ];

  static final $core.Map<$core.int, HankRankingType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static HankRankingType? valueOf($core.int value) => _byValue[value];

  const HankRankingType._($core.int v, $core.String n) : super(v, n);
}

class PlayerStatusType extends $pb.ProtobufEnum {
  static const PlayerStatusType Sat_Out = PlayerStatusType._(0, _omitEnumNames ? '' : 'Sat_Out');
  static const PlayerStatusType Spectating = PlayerStatusType._(1, _omitEnumNames ? '' : 'Spectating');
  static const PlayerStatusType Playing = PlayerStatusType._(2, _omitEnumNames ? '' : 'Playing');
  static const PlayerStatusType Wait4Act = PlayerStatusType._(3, _omitEnumNames ? '' : 'Wait4Act');
  static const PlayerStatusType Fold = PlayerStatusType._(4, _omitEnumNames ? '' : 'Fold');
  static const PlayerStatusType Check = PlayerStatusType._(5, _omitEnumNames ? '' : 'Check');
  static const PlayerStatusType Call = PlayerStatusType._(6, _omitEnumNames ? '' : 'Call');
  static const PlayerStatusType Raise = PlayerStatusType._(7, _omitEnumNames ? '' : 'Raise');
  static const PlayerStatusType AllIn = PlayerStatusType._(8, _omitEnumNames ? '' : 'AllIn');
  static const PlayerStatusType LOSER = PlayerStatusType._(9, _omitEnumNames ? '' : 'LOSER');
  static const PlayerStatusType WINNER = PlayerStatusType._(10, _omitEnumNames ? '' : 'WINNER');
  static const PlayerStatusType SB = PlayerStatusType._(11, _omitEnumNames ? '' : 'SB');
  static const PlayerStatusType BB = PlayerStatusType._(12, _omitEnumNames ? '' : 'BB');

  static const $core.List<PlayerStatusType> values = <PlayerStatusType> [
    Sat_Out,
    Spectating,
    Playing,
    Wait4Act,
    Fold,
    Check,
    Call,
    Raise,
    AllIn,
    LOSER,
    WINNER,
    SB,
    BB,
  ];

  static final $core.Map<$core.int, PlayerStatusType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PlayerStatusType? valueOf($core.int value) => _byValue[value];

  const PlayerStatusType._($core.int v, $core.String n) : super(v, n);
}

class PlayerGameActionType extends $pb.ProtobufEnum {
  static const PlayerGameActionType FOLD = PlayerGameActionType._(0, _omitEnumNames ? '' : 'FOLD');
  static const PlayerGameActionType CHECK = PlayerGameActionType._(1, _omitEnumNames ? '' : 'CHECK');
  static const PlayerGameActionType CALL = PlayerGameActionType._(2, _omitEnumNames ? '' : 'CALL');
  static const PlayerGameActionType RAISE = PlayerGameActionType._(3, _omitEnumNames ? '' : 'RAISE');
  static const PlayerGameActionType ALLIN = PlayerGameActionType._(4, _omitEnumNames ? '' : 'ALLIN');

  static const $core.List<PlayerGameActionType> values = <PlayerGameActionType> [
    FOLD,
    CHECK,
    CALL,
    RAISE,
    ALLIN,
  ];

  static final $core.Map<$core.int, PlayerGameActionType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PlayerGameActionType? valueOf($core.int value) => _byValue[value];

  const PlayerGameActionType._($core.int v, $core.String n) : super(v, n);
}

class RoundStateType extends $pb.ProtobufEnum {
  static const RoundStateType INITIAL = RoundStateType._(0, _omitEnumNames ? '' : 'INITIAL');
  static const RoundStateType PREFLOP = RoundStateType._(1, _omitEnumNames ? '' : 'PREFLOP');
  static const RoundStateType FLOP = RoundStateType._(2, _omitEnumNames ? '' : 'FLOP');
  static const RoundStateType TURN = RoundStateType._(3, _omitEnumNames ? '' : 'TURN');
  static const RoundStateType RIVER = RoundStateType._(4, _omitEnumNames ? '' : 'RIVER');
  static const RoundStateType SHOWDOWN = RoundStateType._(5, _omitEnumNames ? '' : 'SHOWDOWN');

  static const $core.List<RoundStateType> values = <RoundStateType> [
    INITIAL,
    PREFLOP,
    FLOP,
    TURN,
    RIVER,
    SHOWDOWN,
  ];

  static final $core.Map<$core.int, RoundStateType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static RoundStateType? valueOf($core.int value) => _byValue[value];

  const RoundStateType._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
