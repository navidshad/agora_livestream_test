import 'package:agora_flutter_navidshad/src/services/token_generator.dart';
import 'package:agora_flutter_navidshad/src/widgets/button.dart';
import 'package:flutter/material.dart';

class JoinLiveForm extends StatefulWidget {
  JoinLiveForm({Key key, this.onFind}) : super(key: key);

  final Function(String token, String room) onFind;

  @override
  _JoinLiveFormState createState() => _JoinLiveFormState();
}

class _JoinLiveFormState extends State<JoinLiveForm> {
  final TokenGeneratorService tokenGenerator = TokenGeneratorService();
  String roomName = '';
  String token = '';
  String errorMessage = '';
  bool hasError = false;
  bool pending = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'Room name',
            hintText: 'A unique title',
            errorText: hasError ? errorMessage : null,
          ),
          onChanged: (value) => roomName = value,
        ),
        CustomButton(
          label: 'Join',
          onPressed: onJoin,
          loading: pending,
        )
      ],
    );
  }

  void onJoin() {
    if (roomName.isEmpty) {
      return;
    }

    setState(() {
      pending = true;
    });

    tokenGenerator.findRoom(roomName).then((value) {
      token = value;
    }).catchError((error) {
      hasError = true;
      errorMessage = 'There is a problem on the server.';
    }).whenComplete(() {
      setState(() {
        pending = false;
      });

      if (token.isNotEmpty) {
        widget.onFind(token, roomName);
      }
    });
  }
}
