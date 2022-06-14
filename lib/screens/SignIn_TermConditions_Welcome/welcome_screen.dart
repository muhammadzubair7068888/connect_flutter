import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'signIn_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#FFFFFF"),
      appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: HexColor("#FFFFFF"),
          title: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Text(
              "Welcome",
              style: TextStyle(
                  color: HexColor("#222222"),
                  fontSize: 40,
                  fontWeight: FontWeight.w600),
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 65.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                    height: 123,
                    width: 147,
                    child: Image(image: AssetImage("images/logo.png"))),
                const Padding(
                  padding: EdgeInsets.only(top: 25.0),
                  child: Text("CONNECT",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25.0,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "By",
                        style: TextStyle(
                            color: HexColor("#1C1C1C"),
                            fontWeight: FontWeight.w500,
                            fontSize: 27)),
                    TextSpan(
                        text: "  Connected Performance",
                        style: TextStyle(
                            color: HexColor("#30CED9"),
                            fontWeight: FontWeight.w700,
                            fontSize: 27)),
                  ])),
                ),
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 50.0, horizontal: 30.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        primary: HexColor("#30CED9"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
