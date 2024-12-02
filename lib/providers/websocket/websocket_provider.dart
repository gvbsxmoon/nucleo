import 'dart:async';
import 'dart:convert';

import 'package:nucleo/core/core.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketProvider implements EventProvider {
  final String url;
  final WebSocketChannel? _channel;
  final _eventController = StreamController<EventModel>.broadcast();

  WebSocketProvider(
    this.url, {
    WebSocketChannel? channel,
  }) : _channel = channel;

  @override
  Stream<EventModel> get eventStream => _eventController.stream;

  @override
  Future<void> initialize() async {
    final channel = _channel ?? WebSocketChannel.connect(Uri.parse(url));

    channel.stream.listen((message) {
      final event = json.decode(message as String);
      _eventController.add(event);
    });
  }

  @override
  Future<void> dispose() async {
    await _eventController.close();
  }

  @override
  Future<void> handleMessage(message) {
    // TODO: implement handleMessage
    throw UnimplementedError();
  }
}
