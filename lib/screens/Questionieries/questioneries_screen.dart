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
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Questionnaire",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: HexColor("#FFFFFF"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: HexColor("#02010E"),
          ),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Question",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Question"),
                  // onChanged: searchBook,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 35,
                      width: 107,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: HexColor("#31D858"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          onPressed: () {},
                          child: const Text("Submit")),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 35,
                    width: 107,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: HexColor("#EEEEF2"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Clear",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, right: 8.0),
                  child: SizedBox(
                    height: 35,
                    width: 170,
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
            ), SingleChildScrollView(
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
                rows: const [
                  DataRow(
                    cells: [
                      DataCell(
                        Text("What are your biggest fear regard to training"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text("Aidan benette"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text("Aidan benette"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text("Aidan benette"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text("Aidan benette"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      DataCell(
                        Text("Aidan benette"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
                      ),
                      DataCell(
                        Text("0"),
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
