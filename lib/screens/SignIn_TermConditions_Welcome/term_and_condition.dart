import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TermAndCondition extends StatefulWidget {
  const TermAndCondition({Key? key}) : super(key: key);

  @override
  State<TermAndCondition> createState() => _TermAndConditionState();
}

class _TermAndConditionState extends State<TermAndCondition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#FCFCFF"),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: HexColor("#FCFCFF"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: HexColor("#1C1C1C"),
        ),
      ),
      body: Column(
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                "Fugiat voluptate consequat cupidatat consectetur. Laborum dolor Lorem fugiat adipisicing. Et amet sunt excepteur est fugiat ipsum dolore. Anim anim cupidatat dolore pariatur pariatur laborum aliqua sint.\n Enim sint quis est officia eiusmod elit cupidatat. Elit eiusmod sunt ea aliqua in esse nostrud fugiat est fugiat officia. Consequat sunt est amet incididunt ut commodo.Ut quis excepteur voluptate exercitation nulla ut incididunt nulla do magna.\n Quis laborum mollit cupidatat qui veniam quis. Esse deserunt qui ad sunt enim. Adipisicing fugiat magna deserunt adipisicing officia exercitation labore velit fugiat nostrud nulla cillum duis adipisicing..",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: HexColor("#606060"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
