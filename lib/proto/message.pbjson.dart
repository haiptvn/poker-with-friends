//
//  Generated code. Do not modify.
//  source: proto/message.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use rankTypeDescriptor instead')
const RankType$json = {
  '1': 'RankType',
  '2': [
    {'1': 'UNSPECIFIED_RANK', '2': 0},
    {'1': 'DEUCE', '2': 1},
    {'1': 'THREE', '2': 2},
    {'1': 'FOUR', '2': 3},
    {'1': 'FIVE', '2': 4},
    {'1': 'SIX', '2': 5},
    {'1': 'SEVEN', '2': 6},
    {'1': 'EIGHT', '2': 7},
    {'1': 'NINE', '2': 8},
    {'1': 'TEN', '2': 9},
    {'1': 'JACK', '2': 10},
    {'1': 'QUEEN', '2': 11},
    {'1': 'KING', '2': 12},
    {'1': 'ACE', '2': 13},
  ],
};

/// Descriptor for `RankType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List rankTypeDescriptor = $convert.base64Decode(
    'CghSYW5rVHlwZRIUChBVTlNQRUNJRklFRF9SQU5LEAASCQoFREVVQ0UQARIJCgVUSFJFRRACEg'
    'gKBEZPVVIQAxIICgRGSVZFEAQSBwoDU0lYEAUSCQoFU0VWRU4QBhIJCgVFSUdIVBAHEggKBE5J'
    'TkUQCBIHCgNURU4QCRIICgRKQUNLEAoSCQoFUVVFRU4QCxIICgRLSU5HEAwSBwoDQUNFEA0=');

@$core.Deprecated('Use suitTypeDescriptor instead')
const SuitType$json = {
  '1': 'SuitType',
  '2': [
    {'1': 'HEARTS', '2': 0},
    {'1': 'DIAMONDS', '2': 1},
    {'1': 'CLUBS', '2': 2},
    {'1': 'SPADES', '2': 3},
  ],
};

/// Descriptor for `SuitType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List suitTypeDescriptor = $convert.base64Decode(
    'CghTdWl0VHlwZRIKCgZIRUFSVFMQABIMCghESUFNT05EUxABEgkKBUNMVUJTEAISCgoGU1BBRE'
    'VTEAM=');

@$core.Deprecated('Use hankRankingTypeDescriptor instead')
const HankRankingType$json = {
  '1': 'HankRankingType',
  '2': [
    {'1': 'HIGH_CARD', '2': 0},
    {'1': 'ONE_PAIR', '2': 1},
    {'1': 'TWO_PAIR', '2': 2},
    {'1': 'THREE_OF_A_KIND', '2': 3},
    {'1': 'STRAIGHT', '2': 4},
    {'1': 'FLUSH', '2': 5},
    {'1': 'FULL_HOUSE', '2': 6},
    {'1': 'FOUR_OF_A_KIND', '2': 7},
    {'1': 'STRAIGHT_FLUSH', '2': 8},
    {'1': 'ROYAL_FLUSH', '2': 9},
  ],
};

/// Descriptor for `HankRankingType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List hankRankingTypeDescriptor = $convert.base64Decode(
    'Cg9IYW5rUmFua2luZ1R5cGUSDQoJSElHSF9DQVJEEAASDAoIT05FX1BBSVIQARIMCghUV09fUE'
    'FJUhACEhMKD1RIUkVFX09GX0FfS0lORBADEgwKCFNUUkFJR0hUEAQSCQoFRkxVU0gQBRIOCgpG'
    'VUxMX0hPVVNFEAYSEgoORk9VUl9PRl9BX0tJTkQQBxISCg5TVFJBSUdIVF9GTFVTSBAIEg8KC1'
    'JPWUFMX0ZMVVNIEAk=');

@$core.Deprecated('Use playerStatusTypeDescriptor instead')
const PlayerStatusType$json = {
  '1': 'PlayerStatusType',
  '2': [
    {'1': 'Sat_Out', '2': 0},
    {'1': 'Spectating', '2': 1},
    {'1': 'Folded', '2': 2},
    {'1': 'Ready', '2': 3},
    {'1': 'Playing', '2': 4},
    {'1': 'Wait4Act', '2': 5},
    {'1': 'Fold', '2': 6},
    {'1': 'Check', '2': 7},
    {'1': 'Call', '2': 8},
    {'1': 'Raise', '2': 9},
    {'1': 'AllIn', '2': 10},
    {'1': 'LOSER', '2': 11},
    {'1': 'WINNER', '2': 12},
    {'1': 'SB', '2': 13},
    {'1': 'BB', '2': 14},
  ],
};

/// Descriptor for `PlayerStatusType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List playerStatusTypeDescriptor = $convert.base64Decode(
    'ChBQbGF5ZXJTdGF0dXNUeXBlEgsKB1NhdF9PdXQQABIOCgpTcGVjdGF0aW5nEAESCgoGRm9sZG'
    'VkEAISCQoFUmVhZHkQAxILCgdQbGF5aW5nEAQSDAoIV2FpdDRBY3QQBRIICgRGb2xkEAYSCQoF'
    'Q2hlY2sQBxIICgRDYWxsEAgSCQoFUmFpc2UQCRIJCgVBbGxJbhAKEgkKBUxPU0VSEAsSCgoGV0'
    'lOTkVSEAwSBgoCU0IQDRIGCgJCQhAO');

@$core.Deprecated('Use playerGameActionTypeDescriptor instead')
const PlayerGameActionType$json = {
  '1': 'PlayerGameActionType',
  '2': [
    {'1': 'FOLD', '2': 0},
    {'1': 'CHECK', '2': 1},
    {'1': 'CALL', '2': 2},
    {'1': 'RAISE', '2': 3},
    {'1': 'ALLIN', '2': 4},
  ],
};

/// Descriptor for `PlayerGameActionType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List playerGameActionTypeDescriptor = $convert.base64Decode(
    'ChRQbGF5ZXJHYW1lQWN0aW9uVHlwZRIICgRGT0xEEAASCQoFQ0hFQ0sQARIICgRDQUxMEAISCQ'
    'oFUkFJU0UQAxIJCgVBTExJThAE');

@$core.Deprecated('Use roundStateTypeDescriptor instead')
const RoundStateType$json = {
  '1': 'RoundStateType',
  '2': [
    {'1': 'INITIAL', '2': 0},
    {'1': 'PREFLOP', '2': 1},
    {'1': 'FLOP', '2': 2},
    {'1': 'TURN', '2': 3},
    {'1': 'RIVER', '2': 4},
    {'1': 'SHOWDOWN', '2': 5},
  ],
};

/// Descriptor for `RoundStateType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List roundStateTypeDescriptor = $convert.base64Decode(
    'Cg5Sb3VuZFN0YXRlVHlwZRILCgdJTklUSUFMEAASCwoHUFJFRkxPUBABEggKBEZMT1AQAhIICg'
    'RUVVJOEAMSCQoFUklWRVIQBBIMCghTSE9XRE9XThAF');

@$core.Deprecated('Use cardDescriptor instead')
const Card$json = {
  '1': 'Card',
  '2': [
    {'1': 'rank', '3': 1, '4': 1, '5': 14, '6': '.gpbmessage.RankType', '10': 'rank'},
    {'1': 'suit', '3': 2, '4': 1, '5': 14, '6': '.gpbmessage.SuitType', '10': 'suit'},
  ],
};

/// Descriptor for `Card`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cardDescriptor = $convert.base64Decode(
    'CgRDYXJkEigKBHJhbmsYASABKA4yFC5ncGJtZXNzYWdlLlJhbmtUeXBlUgRyYW5rEigKBHN1aX'
    'QYAiABKA4yFC5ncGJtZXNzYWdlLlN1aXRUeXBlUgRzdWl0');

@$core.Deprecated('Use peerStateDescriptor instead')
const PeerState$json = {
  '1': 'PeerState',
  '2': [
    {'1': 'table_pos', '3': 1, '4': 1, '5': 5, '10': 'tablePos'},
    {'1': 'is_chain_man', '3': 3, '4': 1, '5': 8, '10': 'isChainMan'},
    {'1': 'player_cards', '3': 2, '4': 3, '5': 11, '6': '.gpbmessage.Card', '10': 'playerCards'},
    {'1': 'hand_ranking', '3': 4, '4': 1, '5': 9, '10': 'handRanking'},
    {'1': 'evaluated_hand', '3': 5, '4': 3, '5': 11, '6': '.gpbmessage.Card', '10': 'evaluatedHand'},
  ],
};

/// Descriptor for `PeerState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List peerStateDescriptor = $convert.base64Decode(
    'CglQZWVyU3RhdGUSGwoJdGFibGVfcG9zGAEgASgFUgh0YWJsZVBvcxIgCgxpc19jaGFpbl9tYW'
    '4YAyABKAhSCmlzQ2hhaW5NYW4SMwoMcGxheWVyX2NhcmRzGAIgAygLMhAuZ3BibWVzc2FnZS5D'
    'YXJkUgtwbGF5ZXJDYXJkcxIhCgxoYW5kX3JhbmtpbmcYBCABKAlSC2hhbmRSYW5raW5nEjcKDm'
    'V2YWx1YXRlZF9oYW5kGAUgAygLMhAuZ3BibWVzc2FnZS5DYXJkUg1ldmFsdWF0ZWRIYW5k');

@$core.Deprecated('Use playerStateDescriptor instead')
const PlayerState$json = {
  '1': 'PlayerState',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'table_position', '3': 3, '4': 1, '5': 5, '10': 'tablePosition'},
    {'1': 'chips', '3': 4, '4': 1, '5': 5, '10': 'chips'},
    {'1': 'is_active', '3': 5, '4': 1, '5': 8, '10': 'isActive'},
    {'1': 'is_dealer', '3': 6, '4': 1, '5': 8, '10': 'isDealer'},
    {'1': 'status', '3': 7, '4': 1, '5': 14, '6': '.gpbmessage.PlayerStatusType', '10': 'status'},
    {'1': 'current_bet', '3': 8, '4': 1, '5': 5, '10': 'currentBet'},
    {'1': 'change_amount', '3': 9, '4': 1, '5': 5, '10': 'changeAmount'},
    {'1': 'no_actions', '3': 10, '4': 3, '5': 14, '6': '.gpbmessage.PlayerGameActionType', '10': 'noActions'},
  ],
};

/// Descriptor for `PlayerState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playerStateDescriptor = $convert.base64Decode(
    'CgtQbGF5ZXJTdGF0ZRIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIlCg50YW'
    'JsZV9wb3NpdGlvbhgDIAEoBVINdGFibGVQb3NpdGlvbhIUCgVjaGlwcxgEIAEoBVIFY2hpcHMS'
    'GwoJaXNfYWN0aXZlGAUgASgIUghpc0FjdGl2ZRIbCglpc19kZWFsZXIYBiABKAhSCGlzRGVhbG'
    'VyEjQKBnN0YXR1cxgHIAEoDjIcLmdwYm1lc3NhZ2UuUGxheWVyU3RhdHVzVHlwZVIGc3RhdHVz'
    'Eh8KC2N1cnJlbnRfYmV0GAggASgFUgpjdXJyZW50QmV0EiMKDWNoYW5nZV9hbW91bnQYCSABKA'
    'VSDGNoYW5nZUFtb3VudBI/Cgpub19hY3Rpb25zGAogAygOMiAuZ3BibWVzc2FnZS5QbGF5ZXJH'
    'YW1lQWN0aW9uVHlwZVIJbm9BY3Rpb25z');

@$core.Deprecated('Use resultDescriptor instead')
const Result$json = {
  '1': 'Result',
  '2': [
    {'1': 'showing_cards', '3': 3, '4': 3, '5': 11, '6': '.gpbmessage.PeerState', '10': 'showingCards'},
  ],
};

/// Descriptor for `Result`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resultDescriptor = $convert.base64Decode(
    'CgZSZXN1bHQSOgoNc2hvd2luZ19jYXJkcxgDIAMoCzIVLmdwYm1lc3NhZ2UuUGVlclN0YXRlUg'
    'xzaG93aW5nQ2FyZHM=');

@$core.Deprecated('Use gameStateDescriptor instead')
const GameState$json = {
  '1': 'GameState',
  '2': [
    {'1': 'players', '3': 1, '4': 3, '5': 11, '6': '.gpbmessage.PlayerState', '10': 'players'},
    {'1': 'pot_size', '3': 2, '4': 1, '5': 5, '10': 'potSize'},
    {'1': 'dealer_id', '3': 3, '4': 1, '5': 5, '10': 'dealerId'},
    {'1': 'community_cards', '3': 4, '4': 3, '5': 11, '6': '.gpbmessage.Card', '10': 'communityCards'},
    {'1': 'current_bet', '3': 5, '4': 1, '5': 5, '10': 'currentBet'},
    {'1': 'current_round', '3': 6, '4': 1, '5': 14, '6': '.gpbmessage.RoundStateType', '10': 'currentRound'},
    {'1': 'final_result', '3': 7, '4': 1, '5': 11, '6': '.gpbmessage.Result', '10': 'finalResult'},
  ],
};

/// Descriptor for `GameState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gameStateDescriptor = $convert.base64Decode(
    'CglHYW1lU3RhdGUSMQoHcGxheWVycxgBIAMoCzIXLmdwYm1lc3NhZ2UuUGxheWVyU3RhdGVSB3'
    'BsYXllcnMSGQoIcG90X3NpemUYAiABKAVSB3BvdFNpemUSGwoJZGVhbGVyX2lkGAMgASgFUghk'
    'ZWFsZXJJZBI5Cg9jb21tdW5pdHlfY2FyZHMYBCADKAsyEC5ncGJtZXNzYWdlLkNhcmRSDmNvbW'
    '11bml0eUNhcmRzEh8KC2N1cnJlbnRfYmV0GAUgASgFUgpjdXJyZW50QmV0Ej8KDWN1cnJlbnRf'
    'cm91bmQYBiABKA4yGi5ncGJtZXNzYWdlLlJvdW5kU3RhdGVUeXBlUgxjdXJyZW50Um91bmQSNQ'
    'oMZmluYWxfcmVzdWx0GAcgASgLMhIuZ3BibWVzc2FnZS5SZXN1bHRSC2ZpbmFsUmVzdWx0');

@$core.Deprecated('Use playerActionDescriptor instead')
const PlayerAction$json = {
  '1': 'PlayerAction',
  '2': [
    {'1': 'player_id', '3': 1, '4': 1, '5': 9, '10': 'playerId'},
    {'1': 'action_type', '3': 2, '4': 1, '5': 9, '10': 'actionType'},
    {'1': 'raise_amount', '3': 3, '4': 1, '5': 5, '10': 'raiseAmount'},
  ],
};

/// Descriptor for `PlayerAction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playerActionDescriptor = $convert.base64Decode(
    'CgxQbGF5ZXJBY3Rpb24SGwoJcGxheWVyX2lkGAEgASgJUghwbGF5ZXJJZBIfCgthY3Rpb25fdH'
    'lwZRgCIAEoCVIKYWN0aW9uVHlwZRIhCgxyYWlzZV9hbW91bnQYAyABKAVSC3JhaXNlQW1vdW50');

@$core.Deprecated('Use joinRoomDescriptor instead')
const JoinRoom$json = {
  '1': 'JoinRoom',
  '2': [
    {'1': 'name_id', '3': 1, '4': 1, '5': 9, '10': 'nameId'},
    {'1': 'room', '3': 2, '4': 1, '5': 9, '10': 'room'},
    {'1': 'passcode', '3': 3, '4': 1, '5': 9, '10': 'passcode'},
    {'1': 'session_id', '3': 4, '4': 1, '5': 9, '10': 'sessionId'},
  ],
};

/// Descriptor for `JoinRoom`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinRoomDescriptor = $convert.base64Decode(
    'CghKb2luUm9vbRIXCgduYW1lX2lkGAEgASgJUgZuYW1lSWQSEgoEcm9vbRgCIAEoCVIEcm9vbR'
    'IaCghwYXNzY29kZRgDIAEoCVIIcGFzc2NvZGUSHQoKc2Vzc2lvbl9pZBgEIAEoCVIJc2Vzc2lv'
    'bklk');

@$core.Deprecated('Use joinGameDescriptor instead')
const JoinGame$json = {
  '1': 'JoinGame',
  '2': [
    {'1': 'name_id', '3': 1, '4': 1, '5': 9, '10': 'nameId'},
    {'1': 'choose_slot', '3': 2, '4': 1, '5': 5, '10': 'chooseSlot'},
  ],
};

/// Descriptor for `JoinGame`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinGameDescriptor = $convert.base64Decode(
    'CghKb2luR2FtZRIXCgduYW1lX2lkGAEgASgJUgZuYW1lSWQSHwoLY2hvb3NlX3Nsb3QYAiABKA'
    'VSCmNob29zZVNsb3Q=');

@$core.Deprecated('Use controlActionDescriptor instead')
const ControlAction$json = {
  '1': 'ControlAction',
  '2': [
    {'1': 'control_type', '3': 1, '4': 1, '5': 9, '10': 'controlType'},
    {'1': 'options', '3': 2, '4': 3, '5': 5, '10': 'options'},
  ],
};

/// Descriptor for `ControlAction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List controlActionDescriptor = $convert.base64Decode(
    'Cg1Db250cm9sQWN0aW9uEiEKDGNvbnRyb2xfdHlwZRgBIAEoCVILY29udHJvbFR5cGUSGAoHb3'
    'B0aW9ucxgCIAMoBVIHb3B0aW9ucw==');

@$core.Deprecated('Use gameSettingDescriptor instead')
const GameSetting$json = {
  '1': 'GameSetting',
  '2': [
    {'1': 'max_players', '3': 1, '4': 1, '5': 5, '10': 'maxPlayers'},
    {'1': 'min_players', '3': 2, '4': 1, '5': 5, '10': 'minPlayers'},
    {'1': 'min_stack_size', '3': 3, '4': 1, '5': 5, '10': 'minStackSize'},
    {'1': 'small_blind', '3': 4, '4': 1, '5': 5, '10': 'smallBlind'},
    {'1': 'big_blind', '3': 5, '4': 1, '5': 5, '10': 'bigBlind'},
    {'1': 'time_per_turn', '3': 7, '4': 1, '5': 5, '10': 'timePerTurn'},
    {'1': 'auto_next_game', '3': 8, '4': 1, '5': 8, '10': 'autoNextGame'},
    {'1': 'auto_next_time', '3': 9, '4': 1, '5': 5, '10': 'autoNextTime'},
  ],
};

/// Descriptor for `GameSetting`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gameSettingDescriptor = $convert.base64Decode(
    'CgtHYW1lU2V0dGluZxIfCgttYXhfcGxheWVycxgBIAEoBVIKbWF4UGxheWVycxIfCgttaW5fcG'
    'xheWVycxgCIAEoBVIKbWluUGxheWVycxIkCg5taW5fc3RhY2tfc2l6ZRgDIAEoBVIMbWluU3Rh'
    'Y2tTaXplEh8KC3NtYWxsX2JsaW5kGAQgASgFUgpzbWFsbEJsaW5kEhsKCWJpZ19ibGluZBgFIA'
    'EoBVIIYmlnQmxpbmQSIgoNdGltZV9wZXJfdHVybhgHIAEoBVILdGltZVBlclR1cm4SJAoOYXV0'
    'b19uZXh0X2dhbWUYCCABKAhSDGF1dG9OZXh0R2FtZRIkCg5hdXRvX25leHRfdGltZRgJIAEoBV'
    'IMYXV0b05leHRUaW1l');

@$core.Deprecated('Use playerBalanceDescriptor instead')
const PlayerBalance$json = {
  '1': 'PlayerBalance',
  '2': [
    {'1': 'player_name', '3': 1, '4': 1, '5': 9, '10': 'playerName'},
    {'1': 'balance', '3': 2, '4': 1, '5': 5, '10': 'balance'},
  ],
};

/// Descriptor for `PlayerBalance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List playerBalanceDescriptor = $convert.base64Decode(
    'Cg1QbGF5ZXJCYWxhbmNlEh8KC3BsYXllcl9uYW1lGAEgASgJUgpwbGF5ZXJOYW1lEhgKB2JhbG'
    'FuY2UYAiABKAVSB2JhbGFuY2U=');

@$core.Deprecated('Use balanceInfoDescriptor instead')
const BalanceInfo$json = {
  '1': 'BalanceInfo',
  '2': [
    {'1': 'player_balances', '3': 1, '4': 3, '5': 11, '6': '.gpbmessage.PlayerBalance', '10': 'playerBalances'},
  ],
};

/// Descriptor for `BalanceInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List balanceInfoDescriptor = $convert.base64Decode(
    'CgtCYWxhbmNlSW5mbxJCCg9wbGF5ZXJfYmFsYW5jZXMYASADKAsyGS5ncGJtZXNzYWdlLlBsYX'
    'llckJhbGFuY2VSDnBsYXllckJhbGFuY2Vz');

@$core.Deprecated('Use clientMessageDescriptor instead')
const ClientMessage$json = {
  '1': 'ClientMessage',
  '2': [
    {'1': 'player_action', '3': 1, '4': 1, '5': 11, '6': '.gpbmessage.PlayerAction', '9': 0, '10': 'playerAction'},
    {'1': 'join_room', '3': 2, '4': 1, '5': 11, '6': '.gpbmessage.JoinRoom', '9': 0, '10': 'joinRoom'},
    {'1': 'join_game', '3': 3, '4': 1, '5': 11, '6': '.gpbmessage.JoinGame', '9': 0, '10': 'joinGame'},
    {'1': 'control_action', '3': 4, '4': 1, '5': 11, '6': '.gpbmessage.ControlAction', '9': 0, '10': 'controlAction'},
  ],
  '8': [
    {'1': 'message'},
  ],
};

/// Descriptor for `ClientMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clientMessageDescriptor = $convert.base64Decode(
    'Cg1DbGllbnRNZXNzYWdlEj8KDXBsYXllcl9hY3Rpb24YASABKAsyGC5ncGJtZXNzYWdlLlBsYX'
    'llckFjdGlvbkgAUgxwbGF5ZXJBY3Rpb24SMwoJam9pbl9yb29tGAIgASgLMhQuZ3BibWVzc2Fn'
    'ZS5Kb2luUm9vbUgAUghqb2luUm9vbRIzCglqb2luX2dhbWUYAyABKAsyFC5ncGJtZXNzYWdlLk'
    'pvaW5HYW1lSABSCGpvaW5HYW1lEkIKDmNvbnRyb2xfYWN0aW9uGAQgASgLMhkuZ3BibWVzc2Fn'
    'ZS5Db250cm9sQWN0aW9uSABSDWNvbnRyb2xBY3Rpb25CCQoHbWVzc2FnZQ==');

@$core.Deprecated('Use serverMessageDescriptor instead')
const ServerMessage$json = {
  '1': 'ServerMessage',
  '2': [
    {'1': 'game_state', '3': 1, '4': 1, '5': 11, '6': '.gpbmessage.GameState', '9': 0, '10': 'gameState'},
    {'1': 'game_setting', '3': 2, '4': 1, '5': 11, '6': '.gpbmessage.GameSetting', '9': 0, '10': 'gameSetting'},
    {'1': 'peer_state', '3': 3, '4': 1, '5': 11, '6': '.gpbmessage.PeerState', '9': 0, '10': 'peerState'},
    {'1': 'balance_info', '3': 4, '4': 1, '5': 11, '6': '.gpbmessage.BalanceInfo', '9': 0, '10': 'balanceInfo'},
    {'1': 'game_over', '3': 5, '4': 1, '5': 9, '9': 0, '10': 'gameOver'},
    {'1': 'error_message', '3': 6, '4': 1, '5': 9, '9': 0, '10': 'errorMessage'},
    {'1': 'welcome_message', '3': 7, '4': 1, '5': 9, '9': 0, '10': 'welcomeMessage'},
  ],
  '8': [
    {'1': 'message'},
  ],
};

/// Descriptor for `ServerMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serverMessageDescriptor = $convert.base64Decode(
    'Cg1TZXJ2ZXJNZXNzYWdlEjYKCmdhbWVfc3RhdGUYASABKAsyFS5ncGJtZXNzYWdlLkdhbWVTdG'
    'F0ZUgAUglnYW1lU3RhdGUSPAoMZ2FtZV9zZXR0aW5nGAIgASgLMhcuZ3BibWVzc2FnZS5HYW1l'
    'U2V0dGluZ0gAUgtnYW1lU2V0dGluZxI2CgpwZWVyX3N0YXRlGAMgASgLMhUuZ3BibWVzc2FnZS'
    '5QZWVyU3RhdGVIAFIJcGVlclN0YXRlEjwKDGJhbGFuY2VfaW5mbxgEIAEoCzIXLmdwYm1lc3Nh'
    'Z2UuQmFsYW5jZUluZm9IAFILYmFsYW5jZUluZm8SHQoJZ2FtZV9vdmVyGAUgASgJSABSCGdhbW'
    'VPdmVyEiUKDWVycm9yX21lc3NhZ2UYBiABKAlIAFIMZXJyb3JNZXNzYWdlEikKD3dlbGNvbWVf'
    'bWVzc2FnZRgHIAEoCUgAUg53ZWxjb21lTWVzc2FnZUIJCgdtZXNzYWdl');

