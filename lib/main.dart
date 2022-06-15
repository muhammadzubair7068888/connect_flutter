import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'screens/File/file_screen.dart';
import 'screens/Track_Velocity/track_screen.dart';
import 'screens/Track_Velocity/vel_and_track_screen.dart';
import 'screens/Track_Velocity/velocity_screen.dart';

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
      home: const FileScreen(),
    );
  }
}
