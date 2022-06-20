import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'termCondition_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Center(
                child: Text(
                  "Welcome",
                  style: TextStyle(
                      color: HexColor("#222222"),
                      fontSize: 40,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: const SizedBox(
                height: 123,
                width: 147,
                child: Image(
                  image: AssetImage("images/logo.png"),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                children: [
                  const Text(
                    "CONNECT",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25.0,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "By",
                          style: TextStyle(
                              color: HexColor("#1C1C1C"),
                              fontWeight: FontWeight.w500,
                              fontSize: 27),
                        ),
                        TextSpan(
                          text: "  Connected Performance",
                          style: TextStyle(
                              color: HexColor("#30CED9"),
                              fontWeight: FontWeight.w700,
                              fontSize: 27),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  primary: HexColor("#30CED9"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TermCondition(),
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
    );
  }
}
