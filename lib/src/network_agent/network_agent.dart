import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:poker_with_friends/src/audio/audio_controller.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:poker_with_friends/proto/message.pb.dart' as proto;


// State model to be updated by the NetworkAgent
import 'package:poker_with_friends/src/game_internals/poker_game_state.dart';

// NetworkAgent class to handle WebSocket communication
class NetworkAgent {
  static final _log = Logger('NetworkAgent');

  late String? url;
  late String? playerName;
  PokerGameStateProvider? gameState;
  WebSocketChannel? _channel;
  Timer? _reconnectTimer;

  final Queue<dynamic> _messageQueue = Queue();
  bool _isSending = false;
  final int maxRetries;
  final Duration retryDelay;

  AudioController? audioController;

  NetworkAgent({this.maxRetries = 3,
          this.retryDelay = const Duration(seconds: 1)});

  void initialize() {
    _log.info('Initializing NetworkAgent');
  }

  Future<void> sendMessageAsync(dynamic message) async {
    _messageQueue.add(message);
    _processQueue();
    // _log.info('sendMessageAsync sent: $message');
  }

  Future<void> _processQueue() async {
    if (_isSending || _messageQueue.isEmpty) return;

    _isSending = true;
    while (_messageQueue.isNotEmpty) {
      final message = _messageQueue.first;
      bool success = await _sendToServer(message);
      if (success) {
        _log.info('Async message sent successfully: $message');
        _messageQueue.removeFirst();
      } else {
        // If sending failed, we'll try again later
        _log.warning('Failed to send message: $message');
        break;
      }
    }
    _isSending = false;
  }

  Future<bool> _sendToServer(dynamic message) async {
    int attempts = 0;
    while (attempts < maxRetries) {
      try {
        if (_channel != null) {
          _channel!.sink.add(message);
          return true;
        }
        _log.warning('Channel is null, cannot send message: $message');
        return false;
      } catch (e) {
        _log.warning('Error sending message: $e');
        attempts++;
        await Future.delayed(retryDelay * attempts);
      }
    }
    _log.warning('Failed to send message after $maxRetries attempts: $message');
    return false;
  }

  // wss://localhost:28888/ws
  // ignore: non_constant_identifier_names
  Future<bool> ws_connect(String url, String playerName, PokerGameStateProvider gameState, String room, String pass) async {
    _log.info('Connecting to WebSocket server at $url');
    this.gameState = gameState;
    try {
      SecurityContext context = SecurityContext(withTrustedRoots: true);
      // Load server certificate for verification
      final ByteData data = await rootBundle.load('assets/ca/cert.pem');
      context.setTrustedCertificatesBytes(data.buffer.asUint8List());

      _channel = IOWebSocketChannel.connect(
        url,
        protocols: ['wss'],
        customClient: HttpClient()
          ..badCertificateCallback = (X509Certificate cert, String host, int port) => true,
      );
      // appState.setConnectionStatus(true);

      // Listen for messages and errors
      Completer<bool> completer = Completer<bool>(); // Completer to handle async success/failure
            _channel!.stream.listen(
        (message) {
          // Check message == 'SUCCESS' to confirm successful connection
          if (!completer.isCompleted && message[0] == 200) {
            completer.complete(true);  // Connection success
            return;
          }
          _onMessage(message);  // Handle message
        },
        onError: (error) {
          _onError(error);
          if (!completer.isCompleted) completer.complete(false); // Connection failed
        },
        onDone: () {
          _onDone();
          if (!completer.isCompleted) completer.complete(false); // Connection closed unexpectedly
        },
      );

      // Send login message
      final loginMessage = proto.ClientMessage()
        ..joinRoom = proto.JoinRoom()
        ..joinRoom.room = room
        ..joinRoom.nameId = playerName
        ..joinRoom.passcode = pass;

      final encodedMessage = loginMessage.writeToBuffer();
      _channel!.sink.add(encodedMessage);
      _log.info('Sent login message: ${loginMessage.writeToJson()}');

      // Wait for login confirmation or timeout
      return completer.future.timeout(const Duration(seconds: 2), onTimeout: () {
        _log.warning('Login timed out.');
        return false;  // Timeout without a login response
      });
    } catch (e) {
      _log.warning('WebSocket connection error: $e');
      // _scheduleReconnect();
    }
    return false;
  }

  void _onMessage(dynamic message) {
    final decodedMessage = proto.ServerMessage.fromBuffer(message);
    // _log.info('Received message: $decodedMessage');
    gameState?.updateGameState(decodedMessage);
  }

  void _onError(error) {
    _log.warning('WebSocket error: $error');
    // appState.setConnectionStatus(false);
    // _scheduleReconnect();
  }

  void _onDone() {
    _log.info('WebSocket connection closed');
    // appState.setConnectionStatus(false);
    // _scheduleReconnect();
  }

  // void _scheduleReconnect() {
  //   _reconnectTimer?.cancel();
  //   _reconnectTimer = Timer(const Duration(seconds: 5), ws_connect);
  // }

  void sendMessageSync(dynamic message) {
    if (_channel != null) {
      _log.info('Sending message: $message');
      _channel!.sink.add(message);
    }
  }

  void dispose() {
    _log.info('Disposing NetworkAgent');
    _channel?.sink.close();
    _reconnectTimer?.cancel();
  }
}
