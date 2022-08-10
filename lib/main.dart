import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'screens/BottomNavBar/bottomNavBar_screen.dart';
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
  String? token;
  String? role;
  @override
  void initState() {
    super.initState();
    Future<void> _readToken() async {
      final t = await storage.read(key: "token");
      setState(() {
        token = t;
      });
    }

    Future<void> _readRole() async {
      final r = await storage.read(key: "role");
      setState(() {
        role = r;
      });
    }

    _readToken();
    _readRole();
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
      home: token == null || token == "" || token!.isEmpty
          ? const WelcomeScreen()
          : BottomNavBar(
              role: role!,
              index: null,
              i: '',
              u: '',
            ),
      builder: EasyLoading.init(),
    );
  }
}
// adb tcpip 5555
// adb connect 192.168.0.103:5555