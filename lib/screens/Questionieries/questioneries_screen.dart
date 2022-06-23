// ignore_for_file: unnecessary_const

import 'package:connect/screens/Track_Velocity/alertDialogWidget.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Questioneries extends StatefulWidget {
  const Questioneries({Key? key}) : super(key: key);

  @override
  State<Questioneries> createState() => _QuestioneriesState();
}

class _QuestioneriesState extends State<Questioneries> {
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
          "Questionnaire",
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Question",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Question",
                ),
                // onChanged: searchBook,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: HexColor("#31D858"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Submit"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: HexColor("#EEEEF2"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Clear",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.4),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, right: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: const Text("Search"),
                      ),
                      // onChanged: searchBook,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => HexColor("#30CED9")),
                sortColumnIndex: 0,
                sortAscending: true,
                columns: const [
                  DataColumn(
                    label: Text("Question"),
                  ),
                  DataColumn(
                    label: Text("Action"),
                  ),
                ],
                rows: [
                  DataRow(
                    cells: [
                      const DataCell(
                        Text(
                            "What are your biggest fears in regarding to training ?"),
                      ),
                      DataCell(
                        const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialogWidget();
                              });
                        },
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      const DataCell(
                        Text("Walk me through a typical day for you ?"),
                      ),
                      DataCell(
                        const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialogWidget();
                              });
                        },
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      const DataCell(
                        Text(
                            "If you were to throw a complete game, were would"),
                      ),
                      DataCell(
                        const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialogWidget();
                              });
                        },
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      const DataCell(
                        Text(
                            "Have you had any injuries that cause you to miss 2"),
                      ),
                      DataCell(
                        const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialogWidget();
                              });
                        },
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      const DataCell(
                        Text(
                            "Do you have pre practice, pre outing, or pre pitch"),
                      ),
                      DataCell(
                        const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialogWidget();
                              });
                        },
                      )
                    ],
                  ),
                  DataRow(
                    cells: [
                      const DataCell(
                        Text("test Question"),
                      ),
                      DataCell(
                        const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialogWidget();
                              });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
