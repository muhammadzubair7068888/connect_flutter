import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'screens/Chat/chatList_screen.dart';
import 'screens/Chat/chat_screen.dart';
import 'screens/SignIn_TermConditions_Welcome/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: HexColor("#30CED9"),
        splashColor: HexColor("#30CED9"),
        scaffoldBackgroundColor: HexColor("#FFFFFF"),
        errorColor: Colors.red,
        colorScheme:
            ThemeData().colorScheme.copyWith(primary: HexColor("#30CED9")),
      ),
      home: const WelcomeScreen(),
    );
  }
}
