import 'package:connect/screens/BottomNavBar/bottomNavBar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  final storage = const FlutterSecureStorage();
  late String token;
  late String role;
  @override
  void initState() {
    super.initState();
    token = storage.read(key: "token").toString();
    role = storage.read(key: "role").toString();
    print("welcome");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: HexColor("#30CED9"),
        splashColor: HexColor("#30CED9"),
        scaffoldBackgroundColor: HexColor("#FFFFFF"),
        errorColor: Colors.redAccent,
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: HexColor("#30CED9"),
            ),
      ),
      // ignore: unnecessary_null_comparison
      home: token == null || token == "" || token.isEmpty
          ? const WelcomeScreen()
          : BottomNavBar(role: role),
      builder: EasyLoading.init(),
    );
  }
}
