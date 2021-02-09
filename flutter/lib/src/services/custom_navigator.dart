import 'package:agora_flutter_test/src/screens/call.dart';
import 'package:agora_flutter_test/src/services/token_generator.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class CustomNavigator {
  static final CustomNavigator _instance = CustomNavigator._internal();
  BuildContext lastContext;

  factory CustomNavigator() {
    return _instance;
  }
  CustomNavigator._internal();

  Future<dynamic> goToCall({
    BuildContext context,
    String channelName,
    String token,
    ClientRole role,
  }) {
    lastContext = context;

    return Navigator.of(context).push(
      MaterialPageRoute(builder: (newPageContext) {
        return CallScreen(
          channelName: channelName,
          token: token,
          role: role,
        );
      }),
    );
  }

  void goToHome(BuildContext context) {
    lastContext = context;
    Navigator.of(context).pop();
  }

  Future<dynamic> goToCallFromLink(String link) async {
    var roomName = Uri.parse(link).queryParameters['channel'];

    return TokenGeneratorService().findRoom(roomName).then((token) {
      return goToCall(
        context: lastContext,
        channelName: roomName,
        token: token,
        role: ClientRole.Audience,
      );
    });
  }
}
