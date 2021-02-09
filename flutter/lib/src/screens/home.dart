import 'package:agora_flutter_test/src/widgets/button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
      builder: (context, constraint) {
        double totalHeight = constraint.maxHeight;
        double totalWidth = constraint.maxWidth;

        return Column(
          children: [
            Container(
              height: totalHeight * 0.6,
              width: totalWidth,
              // color: Colors.blue,
              alignment: Alignment.center,
              child: Text(
                "Agora Test".toUpperCase(),
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

  void onGoLive(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return SimpleDialog(
          contentPadding: EdgeInsets.all(10),
          children: [
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Room name',
                hintText: 'people can find you with this.',
              ),
            ),
            CustomButton(
              label: 'Create Live',
              onPressed: () {},
            )
          ],
        );
      },
    );
  }

  void onJoinLive(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return SimpleDialog(
          contentPadding: EdgeInsets.all(10),
          children: [
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Room name',
                hintText: 'A unique title',
              ),
            ),
            CustomButton(
              label: 'Join',
              onPressed: () {},
            )
          ],
        );
      },
    );
  }
}