import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:poker_with_friends/src/audio/audio_controller.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:poker_with_friends/proto/message.pb.dart' as proto;
// State model to be updated by the NetworkAgent
import 'package:poker_with_friends/src/game_internals/poker_game_state.dart';

class NetworkStatusProvider extends ChangeNotifier {
  bool _isConnected = false;
  bool _showRetry = false;
  bool get isConnected => _isConnected;
  bool get showRetry => _showRetry;

  void setConnectionStatus(bool isConnected) {
    debugPrint('NetworkStatusProvider: setConnectionStatus($isConnected)');
    _isConnected = isConnected;
    notifyListeners();
  }

  void setShowRetry(bool showRetry) {
    debugPrint('NetworkStatusProvider: setShowRetry($showRetry)');
    _showRetry = showRetry;
    notifyListeners();
  }

  void resetShowRetry() {
    debugPrint('NetworkStatusProvider: resetShowRetry()');
    _showRetry = false;
  }
}

// NetworkAgent class to handle WebSocket communication
class NetworkAgent {
  static final _log = Logger('NetworkAgent');

  late String? url;
  late String? playerName;
  late String? room;
  late String? pass;
  late String? sessionId;
  final Duration pingInterval = const Duration(seconds: 10);  // Interval for pings
  WebSocketChannel? _channel;
  Timer? _reconnectTimer;
  Timer? _pingTimer;

  final Queue<dynamic> _messageQueue = Queue();
  bool _isSending = false;
  bool _hasReconnected = false; // Flag to track if reconnection has been attempted
  final int maxRetries;
  final Duration retryDelay;

  AudioController? audioController;
  PokerGameStateProvider? gameState;
  NetworkStatusProvider? connectionStatus;

  NetworkAgent({this.maxRetries = 3,
          this.retryDelay = const Duration(seconds: 1)});

  void initialize() {
    _log.info('Initializing NetworkAgent');
    sessionId = '';
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

  // Reconnect
  wsReconnect() {
    _log.info('UI requests retry...');
    connectionStatus?.resetShowRetry();
    _hasReconnected = false;
    _attemptReconnect();
  }

  // Connect
  // wss://localhost:28888/ws
  Future<bool> wsConnect(String url, String playerName, String room, String pass, PokerGameStateProvider gameState, NetworkStatusProvider connectionStatus) async {
    _log.info('Connecting to WebSocket server at $url');
    this.url = url;
    this.playerName = playerName;
    this.room = room;
    this.pass = pass;
    this.gameState = gameState;
    this.connectionStatus = connectionStatus;

    try {
      Completer<bool> completer = Completer<bool>(); // Completer to handle async success/failure

      // Load server certificate for verification
      SecurityContext context = SecurityContext(withTrustedRoots: true);
      final ByteData data = await rootBundle.load('assets/ca/cert.pem');
      context.setTrustedCertificatesBytes(data.buffer.asUint8List());

      // Wrap the connection attempt in a timeout
      try {
        _channel = await Future.sync(() => IOWebSocketChannel.connect(
          url,
          protocols: ['wss'],
          pingInterval: pingInterval,
          connectTimeout: const Duration(seconds: 5),
          customClient: HttpClient()
            ..badCertificateCallback =
                (X509Certificate cert, String host, int port) => true,
        ));
      } catch (e) {
        _log.severe('Failed to establish WebSocket connection: $e');
        _cleanup();
        _attemptReconnect();
        return false;
      }

      debugPrint('WebSocket connection established');
      // Listen for messages and errors
      _channel!.stream.listen(
        (message) {
          _hasReconnected = false;
          debugPrint('Received message: $message');
          // Check message == 'SUCCESS' to confirm successful connection
          if (!completer.isCompleted && message.length == 17 ) {
            completer.complete(true);  // Connection success
            this.connectionStatus?.setConnectionStatus(true);
            final newSession = sessionId != message.toString();
            sessionId = newSession ? message.toString() : sessionId;
            newSession? _log.info('Received new sessionId: $sessionId'): _log.info('Received old sessionId: $sessionId');
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
        cancelOnError: true,
      );

      try {
        debugPrint('Sending login message...');
        // Send login message
        final loginMessage = proto.ClientMessage()
          ..joinRoom = proto.JoinRoom()
          ..joinRoom.nameId = playerName
          ..joinRoom.room = room
          ..joinRoom.passcode = pass
          ..joinRoom.sessionId = sessionId??'';

        final encodedMessage = loginMessage.writeToBuffer();
        _channel!.sink.add(encodedMessage);

        if (sessionId != null && sessionId!.isEmpty) {
          _log.info('Sent login message: ${loginMessage.writeToJson()}');
        } else {
          _log.warning('Send re-login message ${loginMessage.writeToJson()}');
        }
      } catch (e) {
        _log.warning('Failed to send login message: $e');
        // timeoutTimer.cancel();
        return completer.future;
      }

      if (_hasReconnected) {
        _log.info('Reconnection successful');
          _hasReconnected = false;
      }

      return completer.future.timeout(const Duration(seconds: 2), onTimeout: () {
        _log.warning('Login timed out.');
        _cleanup();
        return false;  // Timeout without a login response
      });
    } catch (e) {
      _log.severe('Unexpected error during connection: $e');
      _attemptReconnect();
      return false;
    }
  }

  void _onMessage(dynamic message) {
    try {
      final decodedMessage = proto.ServerMessage.fromBuffer(message);
      if (decodedMessage.hasJoinedAck()) {
        gameState?.updateAfterReconnect(decodedMessage);
      } else {
        gameState?.updateGameState(decodedMessage);
      }
    } catch (e) {
      _log.warning('Failed to decode message: $e');
    }
  }

  void _onError(error) {
    _log.warning('WebSocket error: $error');
    _attemptReconnect();
    connectionStatus?.setShowRetry(true);
  }

  void _onDone() {
    _log.info('WebSocket connection closed');
    connectionStatus?.setConnectionStatus(false);
    connectionStatus?.setShowRetry(true);
  }

  void _attemptReconnect() {
    if (!_hasReconnected) {
      connectionStatus?.setConnectionStatus(false);
      _log.info('Attempting first and only reconnect...');
      _hasReconnected = true; // Mark reconnection as attempted
      _channel?.sink.close();
      _reconnectTimer = Timer(const Duration(seconds: 1), () {
        wsConnect(url!, playerName!, room!, pass!, gameState!, connectionStatus!);
      });
    } else {
      _log.info('Reconnection attempt already made. No further reconnect attempts.');
    }
  }

  void sendMessageSync(dynamic message) {
    if (_channel != null) {
      _log.info('Sending message: $message');
      _channel!.sink.add(message);
    }
  }

  void _cleanup() {
    _log.info('Cleaning up NetworkAgent');
    _pingTimer?.cancel();
    _reconnectTimer?.cancel();
    if (_channel != null) {
      try {
        _channel!.sink.close();
      } catch (e) {
        _log.warning('Error closing channel: $e');
      }
      _channel = null;
    }
  }

  void dispose() {
    _cleanup();
    _log.info('Disposing NetworkAgent');
    sessionId = '';
  }
}
