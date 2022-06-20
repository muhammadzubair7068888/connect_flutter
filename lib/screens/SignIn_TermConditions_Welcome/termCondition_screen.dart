import 'package:connect/screens/SignIn_TermConditions_Welcome/signIn_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TermCondition extends StatefulWidget {
  const TermCondition({Key? key}) : super(key: key);

  @override
  State<TermCondition> createState() => _TermConditionState();
}

class _TermConditionState extends State<TermCondition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#FCFCFF"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Terms &",
                          style: TextStyle(
                            color: HexColor("#1C1C1C"),
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                          ),
                        ),
                        TextSpan(
                          text: " Conditions",
                          style: TextStyle(
                            color: HexColor("#30CED9"),
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "Fugiat voluptate consequat cupidatat consectetur. Laborum dolor Lorem fugiat adipisicing. Et amet sunt excepteur est fugiat ipsum dolore. Anim anim cupidatat dolore pariatur pariatur laborum aliqua sint.\n Enim sint quis est officia eiusmod elit cupidatat. Elit eiusmod sunt ea aliqua in esse nostrud fugiat est fugiat officia. Consequat sunt est amet incididunt ut commodo.Ut quis excepteur voluptate exercitation nulla ut incididunt nulla do magna.\n Quis laborum mollit cupidatat qui veniam quis. Esse deserunt qui ad sunt enim. Adipisicing fugiat magna deserunt adipisicing officia exercitation labore velit fugiat nostrud nulla cillum duis adipisicing..",
                textAlign: TextAlign.center,
                style: TextStyle(color: HexColor("#606060"), wordSpacing: 2.0),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
              child: SizedBox(
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
                        builder: (context) => const SignInScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "I Agree",
                    style: TextStyle(fontSize: 20.0),
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
