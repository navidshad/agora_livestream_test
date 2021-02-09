import 'package:agora_flutter_test/src/partials/create_form.dart';
import 'package:agora_flutter_test/src/partials/join_form.dart';
import 'package:agora_flutter_test/src/services/custom_navigator.dart';
import 'package:agora_flutter_test/src/widgets/button.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CustomNavigator navigator = CustomNavigator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
      builder: (context, constraint) {
        var totalHeight = constraint.maxHeight;
        var totalWidth = constraint.maxWidth;

        return Column(
          children: [
            Container(
              height: totalHeight * 0.6,
              width: totalWidth,
              // color: Colors.blue,
              alignment: Alignment.center,
              child: Text(
                'Agora Test'.toUpperCase(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            // Go Live Button
            Container(
              width: totalWidth * 0.6,
              child: CustomButton(
                label: 'Go live',
                onPressed: () => onGoLive(context),
              ),
            ),

            // Join Live Button
            Container(
              width: totalWidth * 0.6,
              child: CustomButton(
                label: 'Join a live',
                onPressed: () => onJoinLive(context),
              ),
            )
          ],
        );
      },
    ));
  }

  void onGoLive(BuildContext context) async {
    String token;
    String roomName;
    var allowToCreate = false;

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return SimpleDialog(
          contentPadding: EdgeInsets.all(10),
          children: [
            CreateLiveForm(
              onCreated: (generatedToken, room) {
                token = generatedToken;
                roomName = room;
                allowToCreate = true;
                Navigator.of(dialogContext).pop();
              },
            )
          ],
        );
      },
    );

    if (allowToCreate) {
      await navigator.goToCall(
        context: context,
        channelName: roomName,
        token: token,
        role: ClientRole.Broadcaster,
      );
    }
  }

  void onJoinLive(BuildContext context) async {
    String token;
    String roomName;
    var allowToJoin = false;

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return SimpleDialog(
          contentPadding: EdgeInsets.all(10),
          children: [
            JoinLiveForm(
              onFind: (generatedToken, room) {
                token = generatedToken;
                roomName = room;
                allowToJoin = true;
                Navigator.of(dialogContext).pop();
              },
            )
          ],
        );
      },
    );

    if (allowToJoin) {
      await navigator.goToCall(
        context: context,
        channelName: roomName,
        token: token,
        role: ClientRole.Audience,
      );
    }
  }
}
