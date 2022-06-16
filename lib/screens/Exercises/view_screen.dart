import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({Key? key}) : super(key: key);

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: HexColor("#F6F6F6"),
        title: const Text(
          "View",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Day Plan",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Title: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    " Connection Program",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Description ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    " Throwing Routine",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Link:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    " Split-Stance Throw",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Text(
                "Notes: For the first 5 days do 5 reps with your assigned throwing tool then one with just a base ball 1x throw, then day 6-10 complete 3reps with your assigned throwing tool and one with just a base ball 2x through. ")
          ],
        ),
      ),
    );
  }
}
