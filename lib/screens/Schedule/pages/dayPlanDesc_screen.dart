import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';

class DayPlanDescScreen extends StatefulWidget {
  const DayPlanDescScreen({Key? key}) : super(key: key);

  @override
  State<DayPlanDescScreen> createState() => _DayPlanDescScreenState();
}

class _DayPlanDescScreenState extends State<DayPlanDescScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Plan",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Link:",
                      style: TextStyle(
                        color: HexColor("#1C1C1C"),
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    TextSpan(
                      text: " Connection ball position",
                      style: TextStyle(
                        color: HexColor("#1777E3"),
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Notes:",
                      style: TextStyle(
                        color: HexColor("#585858"),
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    TextSpan(
                      text:
                          " For the first 5 days do 5 reps with your assigned throwing tool then 1 with just a baseball 1x through, then days 6-10 complete 3 reps with your assigned throwing tool and one with just a baseball 2x through, days 11-15 complete 2 reps with your assigned throwing tool and 1 with just a baseball 2x through, days 16+ work blend 1 and 1 with each drill 3 times through",
                      style: TextStyle(
                        color: HexColor("#707070"),
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 25),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Sets:",
                            style: TextStyle(
                              color: HexColor("#161717"),
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          TextSpan(
                            text: " n/a",
                            style: TextStyle(
                              color: HexColor("#707070"),
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 25),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Reps:",
                            style: TextStyle(
                              color: HexColor("#161717"),
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          TextSpan(
                            text: " n/a",
                            style: TextStyle(
                              color: HexColor("#707070"),
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: RichText(
                      text: TextSpan(
                        text: "Strength:",
                        style: TextStyle(
                          color: HexColor("#161717"),
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '0',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
