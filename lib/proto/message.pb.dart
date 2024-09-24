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

import 'message.pbenum.dart';

export 'message.pbenum.dart';

/// Message to represent a card
class Card extends $pb.GeneratedMessage {
  factory Card({
    RankType? rank,
    SuitType? suit,
  }) {
    final $result = create();
    if (rank != null) {
      $result.rank = rank;
    }
    if (suit != null) {
      $result.suit = suit;
    }
    return $result;
  }
  Card._() : super();
  factory Card.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Card.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Card', package: const $pb.PackageName(_omitMessageNames ? '' : 'gpbmessage'), createEmptyInstance: create)
    ..e<RankType>(1, _omitFieldNames ? '' : 'rank', $pb.PbFieldType.OE, defaultOrMaker: RankType.UNSPECIFIED_RANK, valueOf: RankType.valueOf, enumValues: RankType.values)
    ..e<SuitType>(2, _omitFieldNames ? '' : 'suit', $pb.PbFieldType.OE, defaultOrMaker: SuitType.HEARTS, valueOf: SuitType.valueOf, enumValues: SuitType.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Card clone() => Card()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Card copyWith(void Function(Card) updates) => super.copyWith((message) => updates(message as Card)) as Card;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Card create() => Card._();
  Card createEmptyInstance() => create();
  static $pb.PbList<Card> createRepeated() => $pb.PbList<Card>();
  @$core.pragma('dart2js:noInline')
  static Card getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Card>(create);
  static Card? _defaultInstance;

  @$pb.TagNumber(1)
  RankType get rank => $_getN(0);
  @$pb.TagNumber(1)
  set rank(RankType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRank() => $_has(0);
  @$pb.TagNumber(1)
  void clearRank() => clearField(1);

  @$pb.TagNumber(2)
  SuitType get suit => $_getN(1);
  @$pb.TagNumber(2)
  set suit(SuitType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuit() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuit() => clearField(2);
}

/// Message to each player
class PeerState extends $pb.GeneratedMessage {
  factory PeerState({
    $core.int? tablePos,
    $core.Iterable<Card>? playerCards,
    $core.bool? isChainMan,
    $core.String? handRanking,
    $core.Iterable<Card>? evaluatedHand,
  }) {
    final $result = create();
    if (tablePos != null) {
      $result.tablePos = tablePos;
    }
    if (playerCards != null) {
      $result.playerCards.addAll(playerCards);
    }
    if (isChainMan != null) {
      $result.isChainMan = isChainMan;
    }
    if (handRanking != null) {
      $result.handRanking = handRanking;
    }
    if (evaluatedHand != null) {
      $result.evaluatedHand.addAll(evaluatedHand);
    }
    return $result;
  }
  PeerState._() : super();
  factory PeerState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PeerState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PeerState', package: const $pb.PackageName(_omitMessageNames ? '' : 'gpbmessage'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'tablePos', $pb.PbFieldType.O3)
    ..pc<Card>(2, _omitFieldNames ? '' : 'playerCards', $pb.PbFieldType.PM, subBuilder: Card.create)
    ..aOB(3, _omitFieldNames ? '' : 'isChainMan')
    ..aOS(4, _omitFieldNames ? '' : 'handRanking')
    ..pc<Card>(5, _omitFieldNames ? '' : 'evaluatedHand', $pb.PbFieldType.PM, subBuilder: Card.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PeerState clone() => PeerState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PeerState copyWith(void Function(PeerState) updates) => super.copyWith((message) => updates(message as PeerState)) as PeerState;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PeerState create() => PeerState._();
  PeerState createEmptyInstance() => create();
  static $pb.PbList<PeerState> createRepeated() => $pb.PbList<PeerState>();
  @$core.pragma('dart2js:noInline')
  static PeerState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PeerState>(create);
  static PeerState? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get tablePos => $_getIZ(0);
  @$pb.TagNumber(1)
  set tablePos($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTablePos() => $_has(0);
  @$pb.TagNumber(1)
  void clearTablePos() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<Card> get playerCards => $_getList(1);

  @$pb.TagNumber(3)
  $core.bool get isChainMan => $_getBF(2);
  @$pb.TagNumber(3)
  set isChainMan($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsChainMan() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsChainMan() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get handRanking => $_getSZ(3);
  @$pb.TagNumber(4)
  set handRanking($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHandRanking() => $_has(3);
  @$pb.TagNumber(4)
  void clearHandRanking() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<Card> get evaluatedHand => $_getList(4);
}

/// Message to represent a player
class PlayerState extends $pb.GeneratedMessage {
  factory PlayerState({
    $core.String? id,
    $core.String? name,
    $core.int? tablePosition,
    $core.int? chips,
    $core.bool? isActive,
    $core.bool? isDealer,
    PlayerStatusType? status,
    $core.int? currentBet,
    $core.int? changeAmount,
    $core.Iterable<PlayerGameActionType>? noActions,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (name != null) {
      $result.name = name;
    }
    if (tablePosition != null) {
      $result.tablePosition = tablePosition;
    }
    if (chips != null) {
      $result.chips = chips;
    }
    if (isActive != null) {
      $result.isActive = isActive;
    }
    if (isDealer != null) {
      $result.isDealer = isDealer;
    }
    if (status != null) {
      $result.status = status;
    }
    if (currentBet != null) {
      $result.currentBet = currentBet;
    }
    if (changeAmount != null) {
      $result.changeAmount = changeAmount;
    }
    if (noActions != null) {
      $result.noActions.addAll(noActions);
    }
    return $result;
  }
  PlayerState._() : super();
  factory PlayerState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlayerState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlayerState', package: const $pb.PackageName(_omitMessageNames ? '' : 'gpbmessage'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'tablePosition', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'chips', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'isActive')
    ..aOB(6, _omitFieldNames ? '' : 'isDealer')
    ..e<PlayerStatusType>(7, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: PlayerStatusType.Sat_Out, valueOf: PlayerStatusType.valueOf, enumValues: PlayerStatusType.values)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'currentBet', $pb.PbFieldType.O3)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'changeAmount', $pb.PbFieldType.O3)
    ..pc<PlayerGameActionType>(10, _omitFieldNames ? '' : 'noActions', $pb.PbFieldType.KE, valueOf: PlayerGameActionType.valueOf, enumValues: PlayerGameActionType.values, defaultEnumValue: PlayerGameActionType.FOLD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlayerState clone() => PlayerState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlayerState copyWith(void Function(PlayerState) updates) => super.copyWith((message) => updates(message as PlayerState)) as PlayerState;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlayerState create() => PlayerState._();
  PlayerState createEmptyInstance() => create();
  static $pb.PbList<PlayerState> createRepeated() => $pb.PbList<PlayerState>();
  @$core.pragma('dart2js:noInline')
  static PlayerState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlayerState>(create);
  static PlayerState? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get tablePosition => $_getIZ(2);
  @$pb.TagNumber(3)
  set tablePosition($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTablePosition() => $_has(2);
  @$pb.TagNumber(3)
  void clearTablePosition() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get chips => $_getIZ(3);
  @$pb.TagNumber(4)
  set chips($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasChips() => $_has(3);
  @$pb.TagNumber(4)
  void clearChips() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isActive => $_getBF(4);
  @$pb.TagNumber(5)
  set isActive($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsActive() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsActive() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isDealer => $_getBF(5);
  @$pb.TagNumber(6)
  set isDealer($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIsDealer() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsDealer() => clearField(6);

  @$pb.TagNumber(7)
  PlayerStatusType get status => $_getN(6);
  @$pb.TagNumber(7)
  set status(PlayerStatusType v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get currentBet => $_getIZ(7);
  @$pb.TagNumber(8)
  set currentBet($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCurrentBet() => $_has(7);
  @$pb.TagNumber(8)
  void clearCurrentBet() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get changeAmount => $_getIZ(8);
  @$pb.TagNumber(9)
  set changeAmount($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasChangeAmount() => $_has(8);
  @$pb.TagNumber(9)
  void clearChangeAmount() => clearField(9);

  @$pb.TagNumber(10)
  $core.List<PlayerGameActionType> get noActions => $_getList(9);
}

class Result extends $pb.GeneratedMessage {
  factory Result({
    $core.Iterable<PeerState>? showingCards,
  }) {
    final $result = create();
    if (showingCards != null) {
      $result.showingCards.addAll(showingCards);
    }
    return $result;
  }
  Result._() : super();
  factory Result.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Result.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Result', package: const $pb.PackageName(_omitMessageNames ? '' : 'gpbmessage'), createEmptyInstance: create)
    ..pc<PeerState>(3, _omitFieldNames ? '' : 'showingCards', $pb.PbFieldType.PM, subBuilder: PeerState.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Result clone() => Result()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Result copyWith(void Function(Result) updates) => super.copyWith((message) => updates(message as Result)) as Result;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Result create() => Result._();
  Result createEmptyInstance() => create();
  static $pb.PbList<Result> createRepeated() => $pb.PbList<Result>();
  @$core.pragma('dart2js:noInline')
  static Result getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Result>(create);
  static Result? _defaultInstance;

  @$pb.TagNumber(3)
  $core.List<PeerState> get showingCards => $_getList(0);
}

/// Message to represent a game state
class GameState extends $pb.GeneratedMessage {
  factory GameState({
    $core.Iterable<PlayerState>? players,
    $core.int? potSize,
    $core.int? dealerId,
    $core.Iterable<Card>? communityCards,
    $core.int? currentBet,
    RoundStateType? currentRound,
    Result? finalResult,
  }) {
    final $result = create();
    if (players != null) {
      $result.players.addAll(players);
    }
    if (potSize != null) {
      $result.potSize = potSize;
    }
    if (dealerId != null) {
      $result.dealerId = dealerId;
    }
    if (communityCards != null) {
      $result.communityCards.addAll(communityCards);
    }
    if (currentBet != null) {
      $result.currentBet = currentBet;
    }
    if (currentRound != null) {
      $result.currentRound = currentRound;
    }
    if (finalResult != null) {
      $result.finalResult = finalResult;
    }
    return $result;
  }
  GameState._() : super();
  factory GameState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GameState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GameState', package: const $pb.PackageName(_omitMessageNames ? '' : 'gpbmessage'), createEmptyInstance: create)
    ..pc<PlayerState>(1, _omitFieldNames ? '' : 'players', $pb.PbFieldType.PM, subBuilder: PlayerState.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'potSize', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'dealerId', $pb.PbFieldType.O3)
    ..pc<Card>(4, _omitFieldNames ? '' : 'communityCards', $pb.PbFieldType.PM, subBuilder: Card.create)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'currentBet', $pb.PbFieldType.O3)
    ..e<RoundStateType>(6, _omitFieldNames ? '' : 'currentRound', $pb.PbFieldType.OE, defaultOrMaker: RoundStateType.INITIAL, valueOf: RoundStateType.valueOf, enumValues: RoundStateType.values)
    ..aOM<Result>(7, _omitFieldNames ? '' : 'finalResult', subBuilder: Result.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GameState clone() => GameState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GameState copyWith(void Function(GameState) updates) => super.copyWith((message) => updates(message as GameState)) as GameState;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GameState create() => GameState._();
  GameState createEmptyInstance() => create();
  static $pb.PbList<GameState> createRepeated() => $pb.PbList<GameState>();
  @$core.pragma('dart2js:noInline')
  static GameState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GameState>(create);
  static GameState? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PlayerState> get players => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get potSize => $_getIZ(1);
  @$pb.TagNumber(2)
  set potSize($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPotSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearPotSize() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get dealerId => $_getIZ(2);
  @$pb.TagNumber(3)
  set dealerId($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDealerId() => $_has(2);
  @$pb.TagNumber(3)
  void clearDealerId() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<Card> get communityCards => $_getList(3);

  @$pb.TagNumber(5)
  $core.int get currentBet => $_getIZ(4);
  @$pb.TagNumber(5)
  set currentBet($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrentBet() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrentBet() => clearField(5);

  @$pb.TagNumber(6)
  RoundStateType get currentRound => $_getN(5);
  @$pb.TagNumber(6)
  set currentRound(RoundStateType v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCurrentRound() => $_has(5);
  @$pb.TagNumber(6)
  void clearCurrentRound() => clearField(6);

  @$pb.TagNumber(7)
  Result get finalResult => $_getN(6);
  @$pb.TagNumber(7)
  set finalResult(Result v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasFinalResult() => $_has(6);
  @$pb.TagNumber(7)
  void clearFinalResult() => clearField(7);
  @$pb.TagNumber(7)
  Result ensureFinalResult() => $_ensure(6);
}

/// Message to represent a player's action
class PlayerAction extends $pb.GeneratedMessage {
  factory PlayerAction({
    $core.String? playerId,
    $core.String? actionType,
    $core.int? raiseAmount,
  }) {
    final $result = create();
    if (playerId != null) {
      $result.playerId = playerId;
    }
    if (actionType != null) {
      $result.actionType = actionType;
    }
    if (raiseAmount != null) {
      $result.raiseAmount = raiseAmount;
    }
    return $result;
  }
  PlayerAction._() : super();
  factory PlayerAction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlayerAction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlayerAction', package: const $pb.PackageName(_omitMessageNames ? '' : 'gpbmessage'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'playerId')
    ..aOS(2, _omitFieldNames ? '' : 'actionType')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'raiseAmount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlayerAction clone() => PlayerAction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlayerAction copyWith(void Function(PlayerAction) updates) => super.copyWith((message) => updates(message as PlayerAction)) as PlayerAction;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlayerAction create() => PlayerAction._();
  PlayerAction createEmptyInstance() => create();
  static $pb.PbList<PlayerAction> createRepeated() => $pb.PbList<PlayerAction>();
  @$core.pragma('dart2js:noInline')
  static PlayerAction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlayerAction>(create);
  static PlayerAction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get playerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set playerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlayerId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayerId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get actionType => $_getSZ(1);
  @$pb.TagNumber(2)
  set actionType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasActionType() => $_has(1);
  @$pb.TagNumber(2)
  void clearActionType() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get raiseAmount => $_getIZ(2);
  @$pb.TagNumber(3)
  set raiseAmount($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRaiseAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearRaiseAmount() => clearField(3);
}

class JoinRoom extends $pb.GeneratedMessage {
  factory JoinRoom({
    $core.String? nameId,
    $core.String? room,
    $core.String? passcode,
    $core.String? sessionId,
  }) {
    final $result = create();
    if (nameId != null) {
      $result.nameId = nameId;
    }
    if (room != null) {
      $result.room = room;
    }
    if (passcode != null) {
      $result.passcode = passcode;
    }
    if (sessionId != null) {
      $result.sessionId = sessionId;
    }
    return $result;
  }
  JoinRoom._() : super();
  factory JoinRoom.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory JoinRoom.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'JoinRoom', package: const $pb.PackageName(_omitMessageNames ? '' : 'gpbmessage'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'nameId')
    ..aOS(2, _omitFieldNames ? '' : 'room')
    ..aOS(3, _omitFieldNames ? '' : 'passcode')
    ..aOS(4, _omitFieldNames ? '' : 'sessionId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  JoinRoom clone() => JoinRoom()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  JoinRoom copyWith(void Function(JoinRoom) updates) => super.copyWith((message) => updates(message as JoinRoom)) as JoinRoom;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JoinRoom create() => JoinRoom._();
  JoinRoom createEmptyInstance() => create();
  static $pb.PbList<JoinRoom> createRepeated() => $pb.PbList<JoinRoom>();
  @$core.pragma('dart2js:noInline')
  static JoinRoom getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JoinRoom>(create);
  static JoinRoom? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get nameId => $_getSZ(0);
  @$pb.TagNumber(1)
  set nameId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNameId() => $_has(0);
  @$pb.TagNumber(1)
  void clearNameId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get room => $_getSZ(1);
  @$pb.TagNumber(2)
  set room($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRoom() => $_has(1);
  @$pb.TagNumber(2)
  void clearRoom() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get passcode => $_getSZ(2);
  @$pb.TagNumber(3)
  set passcode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPasscode() => $_has(2);
  @$pb.TagNumber(3)
  void clearPasscode() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get sessionId => $_getSZ(3);
  @$pb.TagNumber(4)
  set sessionId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSessionId() => $_has(3);
  @$pb.TagNumber(4)
  void clearSessionId() => clearField(4);
}

class JoinGame extends $pb.GeneratedMessage {
  factory JoinGame({
    $core.String? nameId,
    $core.int? chooseSlot,
  }) {
    final $result = create();
    if (nameId != null) {
      $result.nameId = nameId;
    }
    if (chooseSlot != null) {
      $result.chooseSlot = chooseSlot;
    }
    return $result;
  }
  JoinGame._() : super();
  factory JoinGame.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory JoinGame.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'JoinGame', package: const $pb.PackageName(_omitMessageNames ? '' : 'gpbmessage'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'nameId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'chooseSlot', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  JoinGame clone() => JoinGame()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  JoinGame copyWith(void Function(JoinGame) updates) => super.copyWith((message) => updates(message as JoinGame)) as JoinGame;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JoinGame create() => JoinGame._();
  JoinGame createEmptyInstance() => create();
  static $pb.PbList<JoinGame> createRepeated() => $pb.PbList<JoinGame>();
  @$core.pragma('dart2js:noInline')
  static JoinGame getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JoinGame>(create);
  static JoinGame? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get nameId => $_getSZ(0);
  @$pb.TagNumber(1)
  set nameId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNameId() => $_has(0);
  @$pb.TagNumber(1)
  void clearNameId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get chooseSlot => $_getIZ(1);
  @$pb.TagNumber(2)
  set chooseSlot($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChooseSlot() => $_has(1);
  @$pb.TagNumber(2)
  void clearChooseSlot() => clearField(2);
}

class ControlAction extends $pb.GeneratedMessage {
  factory ControlAction({
    $core.String? controlType,
    $core.Iterable<$core.int>? options,
  }) {
    final $result = create();
    if (controlType != null) {
      $result.controlType = controlType;
    }
    if (options != null) {
      $result.options.addAll(options);
    }
    return $result;
  }
  ControlAction._() : super();
  factory ControlAction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ControlAction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ControlAction', package: const $pb.PackageName(_omitMessageNames ? '' : 'gpbmessage'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'controlType')
    ..p<$core.int>(2, _omitFieldNames ? '' : 'options', $pb.PbFieldType.K3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ControlAction clone() => ControlAction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ControlAction copyWith(void Function(ControlAction) updates) => super.copyWith((message) => updates(message as ControlAction)) as ControlAction;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ControlAction create() => ControlAction._();
  ControlAction createEmptyInstance() => create();
  static $pb.PbList<ControlAction> createRepeated() => $pb.PbList<ControlAction>();
  @$core.pragma('dart2js:noInline')
  static ControlAction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ControlAction>(create);
  static ControlAction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get controlType => $_getSZ(0);
  @$pb.TagNumber(1)
  set controlType($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasControlType() => $_has(0);
  @$pb.TagNumber(1)
  void clearControlType() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get options => $_getList(1);
}

/// Message to represent game settings
class GameSetting extends $pb.GeneratedMessage {
  factory GameSetting({
    $core.int? maxPlayers,
    $core.int? minPlayers,
    $core.int? minStackSize,
    $core.int? smallBlind,
    $core.int? bigBlind,
    $core.int? timePerTurn,
    $core.bool? autoNextGame,
    $core.int? autoNextTime,
  }) {
    final $result = create();
    if (maxPlayers != null) {
      $result.maxPlayers = maxPlayers;
    }
    if (minPlayers != null) {
      $result.minPlayers = minPlayers;
    }
    if (minStackSize != null) {
      $result.minStackSize = minStackSize;
    }
    if (smallBlind != null) {
      $result.smallBlind = smallBlind;
    }
    if (bigBlind != null) {
      $result.bigBlind = bigBlind;
    }
    if (timePerTurn != null) {
      $result.timePerTurn = timePerTurn;
    }
    if (autoNextGame != null) {
      $result.autoNextGame = autoNextGame;
    }
    if (autoNextTime != null) {
      $result.autoNextTime = autoNextTime;
    }
    return $result;
  }
  GameSetting._() : super();
  factory GameSetting.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GameSetting.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GameSetting', package: const $pb.PackageName(_omitMessageNames ? '' : 'gpbmessage'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'maxPlayers', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'minPlayers', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'minStackSize', $pb.PbFieldType.O3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'smallBlind', $pb.PbFieldType.O3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'bigBlind', $pb.PbFieldType.O3)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'timePerTurn', $pb.PbFieldType.O3)
    ..aOB(8, _omitFieldNames ? '' : 'autoNextGame')
    ..a<$core.int>(9, _omitFieldNames ? '' : 'autoNextTime', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GameSetting clone() => GameSetting()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GameSetting copyWith(void Function(GameSetting) updates) => super.copyWith((message) => updates(message as GameSetting)) as GameSetting;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GameSetting create() => GameSetting._();
  GameSetting createEmptyInstance() => create();
  static $pb.PbList<GameSetting> createRepeated() => $pb.PbList<GameSetting>();
  @$core.pragma('dart2js:noInline')
  static GameSetting getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GameSetting>(create);
  static GameSetting? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get maxPlayers => $_getIZ(0);
  @$pb.TagNumber(1)
  set maxPlayers($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMaxPlayers() => $_has(0);
  @$pb.TagNumber(1)
  void clearMaxPlayers() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get minPlayers => $_getIZ(1);
  @$pb.TagNumber(2)
  set minPlayers($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMinPlayers() => $_has(1);
  @$pb.TagNumber(2)
  void clearMinPlayers() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get minStackSize => $_getIZ(2);
  @$pb.TagNumber(3)
  set minStackSize($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMinStackSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinStackSize() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get smallBlind => $_getIZ(3);
  @$pb.TagNumber(4)
  set smallBlind($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSmallBlind() => $_has(3);
  @$pb.TagNumber(4)
  void clearSmallBlind() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get bigBlind => $_getIZ(4);
  @$pb.TagNumber(5)
  set bigBlind($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBigBlind() => $_has(4);
  @$pb.TagNumber(5)
  void clearBigBlind() => clearField(5);

  @$pb.TagNumber(7)
  $core.int get timePerTurn => $_getIZ(5);
  @$pb.TagNumber(7)
  set timePerTurn($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasTimePerTurn() => $_has(5);
  @$pb.TagNumber(7)
  void clearTimePerTurn() => clearField(7);

  @$pb.TagNumber(8)
  $core.bool get autoNextGame => $_getBF(6);
  @$pb.TagNumber(8)
  set autoNextGame($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasAutoNextGame() => $_has(6);
  @$pb.TagNumber(8)
  void clearAutoNextGame() => clearField(8);

  @$pb.TagNumber(9)
  $core.int get autoNextTime => $_getIZ(7);
  @$pb.TagNumber(9)
  set autoNextTime($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasAutoNextTime() => $_has(7);
  @$pb.TagNumber(9)
  void clearAutoNextTime() => clearField(9);
}

class PlayerBalance extends $pb.GeneratedMessage {
  factory PlayerBalance({
    $core.String? playerName,
    $core.int? balance,
  }) {
    final $result = create();
    if (playerName != null) {
      $result.playerName = playerName;
    }
    if (balance != null) {
      $result.balance = balance;
    }
    return $result;
  }
  PlayerBalance._() : super();
  factory PlayerBalance.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlayerBalance.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PlayerBalance', package: const $pb.PackageName(_omitMessageNames ? '' : 'gpbmessage'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'playerName')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlayerBalance clone() => PlayerBalance()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlayerBalance copyWith(void Function(PlayerBalance) updates) => super.copyWith((message) => updates(message as PlayerBalance)) as PlayerBalance;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PlayerBalance create() => PlayerBalance._();
  PlayerBalance createEmptyInstance() => create();
  static $pb.PbList<PlayerBalance> createRepeated() => $pb.PbList<PlayerBalance>();
  @$core.pragma('dart2js:noInline')
  static PlayerBalance getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlayerBalance>(create);
  static PlayerBalance? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get playerName => $_getSZ(0);
  @$pb.TagNumber(1)
  set playerName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlayerName() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayerName() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get balance => $_getIZ(1);
  @$pb.TagNumber(2)
  set balance($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearBalance() => clearField(2);
}

class BalanceInfo extends $pb.GeneratedMessage {
  factory BalanceInfo({
    $core.Iterable<PlayerBalance>? playerBalances,
  }) {
    final $result = create();
    if (playerBalances != null) {
      $result.playerBalances.addAll(playerBalances);
    }
    return $result;
  }
  BalanceInfo._() : super();
  factory BalanceInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BalanceInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BalanceInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'gpbmessage'), createEmptyInstance: create)
    ..pc<PlayerBalance>(1, _omitFieldNames ? '' : 'playerBalances', $pb.PbFieldType.PM, subBuilder: PlayerBalance.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BalanceInfo clone() => BalanceInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BalanceInfo copyWith(void Function(BalanceInfo) updates) => super.copyWith((message) => updates(message as BalanceInfo)) as BalanceInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BalanceInfo create() => BalanceInfo._();
  BalanceInfo createEmptyInstance() => create();
  static $pb.PbList<BalanceInfo> createRepeated() => $pb.PbList<BalanceInfo>();
  @$core.pragma('dart2js:noInline')
  static BalanceInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BalanceInfo>(create);
  static BalanceInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<PlayerBalance> get playerBalances => $_getList(0);
}

enum ClientMessage_Message {
  playerAction, 
  joinRoom, 
  joinGame, 
  controlAction, 
  notSet
}

/// Message sent by the client to the server
class ClientMessage extends $pb.GeneratedMessage {
  factory ClientMessage({
    PlayerAction? playerAction,
    JoinRoom? joinRoom,
    JoinGame? joinGame,
    ControlAction? controlAction,
  }) {
    final $result = create();
    if (playerAction != null) {
      $result.playerAction = playerAction;
    }
    if (joinRoom != null) {
      $result.joinRoom = joinRoom;
    }
    if (joinGame != null) {
      $result.joinGame = joinGame;
    }
    if (controlAction != null) {
      $result.controlAction = controlAction;
    }
    return $result;
  }
  ClientMessage._() : super();
  factory ClientMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClientMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, ClientMessage_Message> _ClientMessage_MessageByTag = {
    1 : ClientMessage_Message.playerAction,
    2 : ClientMessage_Message.joinRoom,
    3 : ClientMessage_Message.joinGame,
    4 : ClientMessage_Message.controlAction,
    0 : ClientMessage_Message.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ClientMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'gpbmessage'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4])
    ..aOM<PlayerAction>(1, _omitFieldNames ? '' : 'playerAction', subBuilder: PlayerAction.create)
    ..aOM<JoinRoom>(2, _omitFieldNames ? '' : 'joinRoom', subBuilder: JoinRoom.create)
    ..aOM<JoinGame>(3, _omitFieldNames ? '' : 'joinGame', subBuilder: JoinGame.create)
    ..aOM<ControlAction>(4, _omitFieldNames ? '' : 'controlAction', subBuilder: ControlAction.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClientMessage clone() => ClientMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClientMessage copyWith(void Function(ClientMessage) updates) => super.copyWith((message) => updates(message as ClientMessage)) as ClientMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClientMessage create() => ClientMessage._();
  ClientMessage createEmptyInstance() => create();
  static $pb.PbList<ClientMessage> createRepeated() => $pb.PbList<ClientMessage>();
  @$core.pragma('dart2js:noInline')
  static ClientMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClientMessage>(create);
  static ClientMessage? _defaultInstance;

  ClientMessage_Message whichMessage() => _ClientMessage_MessageByTag[$_whichOneof(0)]!;
  void clearMessage() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  PlayerAction get playerAction => $_getN(0);
  @$pb.TagNumber(1)
  set playerAction(PlayerAction v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPlayerAction() => $_has(0);
  @$pb.TagNumber(1)
  void clearPlayerAction() => clearField(1);
  @$pb.TagNumber(1)
  PlayerAction ensurePlayerAction() => $_ensure(0);

  @$pb.TagNumber(2)
  JoinRoom get joinRoom => $_getN(1);
  @$pb.TagNumber(2)
  set joinRoom(JoinRoom v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasJoinRoom() => $_has(1);
  @$pb.TagNumber(2)
  void clearJoinRoom() => clearField(2);
  @$pb.TagNumber(2)
  JoinRoom ensureJoinRoom() => $_ensure(1);

  @$pb.TagNumber(3)
  JoinGame get joinGame => $_getN(2);
  @$pb.TagNumber(3)
  set joinGame(JoinGame v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasJoinGame() => $_has(2);
  @$pb.TagNumber(3)
  void clearJoinGame() => clearField(3);
  @$pb.TagNumber(3)
  JoinGame ensureJoinGame() => $_ensure(2);

  @$pb.TagNumber(4)
  ControlAction get controlAction => $_getN(3);
  @$pb.TagNumber(4)
  set controlAction(ControlAction v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasControlAction() => $_has(3);
  @$pb.TagNumber(4)
  void clearControlAction() => clearField(4);
  @$pb.TagNumber(4)
  ControlAction ensureControlAction() => $_ensure(3);
}

enum ServerMessage_Message {
  gameState, 
  gameSetting, 
  peerState, 
  balanceInfo, 
  gameOver, 
  errorMessage, 
  welcomeMessage, 
  notSet
}

/// Message sent by the server to the client
class ServerMessage extends $pb.GeneratedMessage {
  factory ServerMessage({
    GameState? gameState,
    GameSetting? gameSetting,
    PeerState? peerState,
    BalanceInfo? balanceInfo,
    $core.String? gameOver,
    $core.String? errorMessage,
    $core.String? welcomeMessage,
  }) {
    final $result = create();
    if (gameState != null) {
      $result.gameState = gameState;
    }
    if (gameSetting != null) {
      $result.gameSetting = gameSetting;
    }
    if (peerState != null) {
      $result.peerState = peerState;
    }
    if (balanceInfo != null) {
      $result.balanceInfo = balanceInfo;
    }
    if (gameOver != null) {
      $result.gameOver = gameOver;
    }
    if (errorMessage != null) {
      $result.errorMessage = errorMessage;
    }
    if (welcomeMessage != null) {
      $result.welcomeMessage = welcomeMessage;
    }
    return $result;
  }
  ServerMessage._() : super();
  factory ServerMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ServerMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, ServerMessage_Message> _ServerMessage_MessageByTag = {
    1 : ServerMessage_Message.gameState,
    2 : ServerMessage_Message.gameSetting,
    3 : ServerMessage_Message.peerState,
    4 : ServerMessage_Message.balanceInfo,
    5 : ServerMessage_Message.gameOver,
    6 : ServerMessage_Message.errorMessage,
    7 : ServerMessage_Message.welcomeMessage,
    0 : ServerMessage_Message.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ServerMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'gpbmessage'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7])
    ..aOM<GameState>(1, _omitFieldNames ? '' : 'gameState', subBuilder: GameState.create)
    ..aOM<GameSetting>(2, _omitFieldNames ? '' : 'gameSetting', subBuilder: GameSetting.create)
    ..aOM<PeerState>(3, _omitFieldNames ? '' : 'peerState', subBuilder: PeerState.create)
    ..aOM<BalanceInfo>(4, _omitFieldNames ? '' : 'balanceInfo', subBuilder: BalanceInfo.create)
    ..aOS(5, _omitFieldNames ? '' : 'gameOver')
    ..aOS(6, _omitFieldNames ? '' : 'errorMessage')
    ..aOS(7, _omitFieldNames ? '' : 'welcomeMessage')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ServerMessage clone() => ServerMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ServerMessage copyWith(void Function(ServerMessage) updates) => super.copyWith((message) => updates(message as ServerMessage)) as ServerMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ServerMessage create() => ServerMessage._();
  ServerMessage createEmptyInstance() => create();
  static $pb.PbList<ServerMessage> createRepeated() => $pb.PbList<ServerMessage>();
  @$core.pragma('dart2js:noInline')
  static ServerMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ServerMessage>(create);
  static ServerMessage? _defaultInstance;

  ServerMessage_Message whichMessage() => _ServerMessage_MessageByTag[$_whichOneof(0)]!;
  void clearMessage() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  GameState get gameState => $_getN(0);
  @$pb.TagNumber(1)
  set gameState(GameState v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGameState() => $_has(0);
  @$pb.TagNumber(1)
  void clearGameState() => clearField(1);
  @$pb.TagNumber(1)
  GameState ensureGameState() => $_ensure(0);

  @$pb.TagNumber(2)
  GameSetting get gameSetting => $_getN(1);
  @$pb.TagNumber(2)
  set gameSetting(GameSetting v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasGameSetting() => $_has(1);
  @$pb.TagNumber(2)
  void clearGameSetting() => clearField(2);
  @$pb.TagNumber(2)
  GameSetting ensureGameSetting() => $_ensure(1);

  @$pb.TagNumber(3)
  PeerState get peerState => $_getN(2);
  @$pb.TagNumber(3)
  set peerState(PeerState v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPeerState() => $_has(2);
  @$pb.TagNumber(3)
  void clearPeerState() => clearField(3);
  @$pb.TagNumber(3)
  PeerState ensurePeerState() => $_ensure(2);

  @$pb.TagNumber(4)
  BalanceInfo get balanceInfo => $_getN(3);
  @$pb.TagNumber(4)
  set balanceInfo(BalanceInfo v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasBalanceInfo() => $_has(3);
  @$pb.TagNumber(4)
  void clearBalanceInfo() => clearField(4);
  @$pb.TagNumber(4)
  BalanceInfo ensureBalanceInfo() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get gameOver => $_getSZ(4);
  @$pb.TagNumber(5)
  set gameOver($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasGameOver() => $_has(4);
  @$pb.TagNumber(5)
  void clearGameOver() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get errorMessage => $_getSZ(5);
  @$pb.TagNumber(6)
  set errorMessage($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasErrorMessage() => $_has(5);
  @$pb.TagNumber(6)
  void clearErrorMessage() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get welcomeMessage => $_getSZ(6);
  @$pb.TagNumber(7)
  set welcomeMessage($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasWelcomeMessage() => $_has(6);
  @$pb.TagNumber(7)
  void clearWelcomeMessage() => clearField(7);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
