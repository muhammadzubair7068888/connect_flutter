import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  bool _filter = false;
  @override
  // ignore: dead_code
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
          "Leaderboard",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.filter_list,
              size: 28,
            ),
            onPressed: () {
              setState(() {
                _filter = !_filter;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: _filter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                    child: Text(
                      "Date",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2.0,
                              spreadRadius: 0.4)
                        ],
                      ),
                      child: DateTimeFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                          contentPadding: EdgeInsets.all(20),
                          hintText: 'Date',
                        ),
                        mode: DateTimeFieldPickerMode.date,
                        autovalidateMode: AutovalidateMode.always,
                        validator: (e) => (e?.day ?? 0) == 1
                            ? 'Please not the first day'
                            : null,
                        onDateSelected: (DateTime value) {
                          // _date = value;
                        },
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                    child: Text(
                      "Last Date",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2.0,
                              spreadRadius: 0.4)
                        ],
                      ),
                      child: DateTimeFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                          contentPadding: EdgeInsets.all(20),
                          hintText: ' Last Date',
                        ),
                        mode: DateTimeFieldPickerMode.date,
                        autovalidateMode: AutovalidateMode.always,
                        validator: (e) => (e?.day ?? 0) == 1
                            ? 'Please not the first day'
                            : null,
                        onDateSelected: (DateTime value) {
                          // _date = value;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                ),
                                onPressed: () {},
                                child: const Text("Search")),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 35,
                          width: 107,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                              onPressed: () {},
                              child: const Text("Clear")),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.4),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 10, 0),
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
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => HexColor("#30CED9")),
                sortColumnIndex: 0,
                sortAscending: true,
                columns: const [
                  DataColumn(
                    label: Text("Name"),
                  ),
                  DataColumn(
                    label: Text("Weight"),
                  ),
                  DataColumn(
                    label: Text("Arm Pain"),
                  ),
                  DataColumn(
                    label: Text("Pull Downs"),
                  ),
                  DataColumn(
                    label: Text("Pull Downs 3"),
                  ),
                  DataColumn(
                    label: Text("Pull Downs 4"),
                  ),
                  DataColumn(
                    label: Text("Pull Downs 5"),
                  ),
                  DataColumn(
                    label: Text("Pull Downs 6"),
                  ),
                  DataColumn(
                    label: Text("Pull Downs 7"),
                  ),
                  DataColumn(
                    label: Text("Name"),
                  ),
                  DataColumn(
                    label: Text("Name"),
                  ),
                  DataColumn(
                    label: Text("Name"),
                  ),
                  DataColumn(
                    label: Text("Name"),
                  ),
                  DataColumn(
                    label: Text("Name"),
                  ),
                  DataColumn(
                    label: Text("Name"),
                  ),
                ],
                rows: const [
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
