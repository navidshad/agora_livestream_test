import 'dart:async';
import 'package:flutter/services.dart';

class DeepLinkService {
  DeepLinkService() {
    startUri().then(_onRedirected);
    stream.receiveBroadcastStream().listen((d) => _onRedirected(d));
  }

  static const platform = MethodChannel('initial');
  static const stream = EventChannel('eventWhileAppIsRunning');

  final StreamController<String> _stateController = StreamController();
  Stream<String> get state => _stateController.stream;
  Sink<String> get stateSink => _stateController.sink;

  void _onRedirected(String uri) {
    stateSink.add(uri);
  }

  void dispose() {
    _stateController.close();
  }

  Future<String> startUri() async {
    try {
      return platform.invokeMethod('initialLink');
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }
}
