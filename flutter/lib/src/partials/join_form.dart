import 'package:agora_flutter_test/src/services/token_generator.dart';
import 'package:agora_flutter_test/src/widgets/button.dart';
import 'package:flutter/material.dart';

class CreateLiveForm extends StatefulWidget {
  CreateLiveForm({Key key, this.onCreated}) : super(key: key);

  final Function(String token) onCreated;

  @override
  _CreateLiveFormState createState() => _CreateLiveFormState();
}

class _CreateLiveFormState extends State<CreateLiveForm> {
  final TokenGeneratorService tokenGenerator = TokenGeneratorService();
  String roomName;
  String token;
  String errorMessage;
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
            hintText: 'people can find you with this.',
          ),
          onChanged: (value) => roomName = value,
        ),
        CustomButton(
          label: 'Create Live',
          onPressed: onCreate,
          loading: pending,
        )
      ],
    );
  }

  void onCreate() {
    if (roomName.isEmpty) {
      return;
    }

    setState(() {
      pending = true;
    });

    tokenGenerator.generate(roomName).then((value) {
      token = value;
    }).catchError((error) {
      hasError = true;
      errorMessage = 'There is a problem on the server.';
    }).whenComplete(() {
      setState(() {
        pending = false;
      });

      if (token.isNotEmpty) {
        widget.onCreated(token);
      }
    });
  }
}
