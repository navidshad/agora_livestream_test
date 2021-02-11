import 'package:agora_flutter_navidshad/src/screens/home.dart';
import 'package:agora_flutter_navidshad/src/services/custom_navigator.dart';
import 'package:agora_flutter_navidshad/src/services/deep_link.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  DeepLinkService deepLinkService;
  CustomNavigator navigator = CustomNavigator();

  @override
  Widget build(BuildContext context) {
    deepLinkService = DeepLinkService();

    // Register event for deep link
    deepLinkService.state.listen(navigator.goToCallFromLink);

    return MaterialApp(
      title: 'Agora Test',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) {
          navigator.lastContext = context;
          return HomeScreen();
        }
      },
    );
  }
}
