import 'package:connect/screens/history_screen.dart';
import 'package:connect/screens/profile_screen.dart';
import 'package:connect/screens/signIn_screen.dart';
import 'package:connect/screens/vel_and_track.dart';
import 'package:connect/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          errorColor: Colors.red,
          colorScheme:
              ThemeData().colorScheme.copyWith(primary: HexColor("#30CED9")),
        ),
        home: VelocityAndTrack());
  }
}
