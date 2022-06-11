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
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            color: HexColor("#1C1C1C"),
          ),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 25),
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Terms &",
                  style: TextStyle(
                      color: HexColor("#1C1C1C"),
                      fontWeight: FontWeight.w700,
                      fontSize: 25)),
              TextSpan(
                  text: "  Conditions",
                  style: TextStyle(
                      color: HexColor("#30CED9"),
                      fontWeight: FontWeight.w700,
                      fontSize: 25)),
            ])),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 10, right: 30),
            child: Text(
              "Fugiat voluptate consequat cupidatat consectetur. Laborum dolor Lorem fugiat adipisicing. Et amet sunt excepteur est fugiat ipsum dolore. Anim anim cupidatat dolore pariatur pariatur laborum aliqua sint.\n Enim sint quis est officia eiusmod elit cupidatat. Elit eiusmod sunt ea aliqua in esse nostrud fugiat est fugiat officia. Consequat sunt est amet incididunt ut commodo.Ut quis excepteur voluptate exercitation nulla ut incididunt nulla do magna.\n Quis laborum mollit cupidatat qui veniam quis. Esse deserunt qui ad sunt enim. Adipisicing fugiat magna deserunt adipisicing officia exercitation labore velit fugiat nostrud nulla cillum duis adipisicing..",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: HexColor("#606060"), wordSpacing: 3.0, fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
            child: SizedBox(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.green,
                    minimumSize: Size.fromHeight(60),
                  ),
                  onPressed: () {},
                  child: Text(
                    "I Agree",
                    style: TextStyle(fontSize: 20.0),
                  )),
            ),
          ),
        ]));
  }
}
