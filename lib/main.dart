import 'package:connect/screens/Exercises/exercises_type_screen.dart';
import 'package:connect/screens/Questionieries/questioneries_screen.dart';
import 'package:connect/screens/Track_Velocity/track_screen.dart';
import 'package:connect/screens/Track_Velocity/velocity_screen.dart';
import 'package:connect/screens/UserScreens/user_detail_screen.dart';
import 'package:connect/screens/leaderboard/leader_board_screen.dart';
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
      home: const Questioneries(),
    );
  }
}
