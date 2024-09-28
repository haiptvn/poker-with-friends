import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../proto/message.pb.dart' as $proto;


// State model to be updated by the NetworkAgent
import 'package:poker_with_friends/src/game_internals/poker_game_state.dart';

// NetworkAgent class to handle WebSocket communication
class NetworkAgent {
  static final _log = Logger('NetworkAgent');

  final String url;
  WebSocketChannel? _channel;
  final PokerGameState gameState;
  Timer? _reconnectTimer;

  NetworkAgent(this.url, this.gameState);

  // ignore: non_constant_identifier_names
  Future<void> ws_connect() async {
    try {
      final ws = await _secureWebSocket();
      _channel = IOWebSocketChannel(ws);
      // appState.setConnectionStatus(true);
      _channel!.stream.listen(
        _onMessage,
        onError: _onError,
        onDone: _onDone,
      );

      // Send login message
      final loginMessage = $proto.ClientMessage()
        ..joinRoom = $proto.JoinRoom()
        ..joinRoom.room = 'room1'
        ..joinRoom.nameId = 'Harry'
        ..joinRoom.passcode = '2';

      final encodedMessage = loginMessage.writeToBuffer();
      _channel!.sink.add(encodedMessage);

    } catch (e) {
      _log.warning('WebSocket connection error: $e');
      // _scheduleReconnect();
    }
  }

  Future<WebSocket> _secureWebSocket() async {
    SecurityContext context = SecurityContext(withTrustedRoots: true);

        // Load server certificate for verification
    final ByteData data = await rootBundle.load('assets/ca/cert.pem');
    context.setTrustedCertificatesBytes(data.buffer.asUint8List());

    Uri uri = Uri.parse(url);
    HttpClient client = HttpClient(context: context);
    client.badCertificateCallback = (X509Certificate cert, String host, int port) {
      // Implement certificate verification logic here if needed
      _log.warning('Warning: untrusted certificate ${cert.subject}');
      return true; // Return true to allow connection despite certificate issues
    };

    Socket socket = await SecureSocket.connect(
      uri.host,
      uri.port,
      context: context,
      onBadCertificate: (X509Certificate cert) {
        // Implement certificate verification logic here if needed
        _log.warning('Warning: untrusted certificate ${cert.subject}');
        return true; // Return true to allow connection despite certificate issues
      },
    );

    return WebSocket.fromUpgradedSocket(
      socket,
      serverSide: false,
      protocol: 'wss',
    );
  }

  void _onMessage(dynamic message) {
    final decodedMessage = json.decode(message);
    // appState.updateMessage(decodedMessage['message']);
    // Handle different message types here
    switch (decodedMessage['type']) {
      case 'update':
        // Handle update message
        break;
      case 'alert':
        // Handle alert message
        break;
      // Add more cases as needed
    }
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

  void _scheduleReconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 5), ws_connect);
  }

  void sendMessage(String message) {
    if (_channel != null) {
      _channel!.sink.add(json.encode({'message': message}));
    }
  }

  void dispose() {
    _channel?.sink.close();
    _reconnectTimer?.cancel();
  }
}
