import 'package:connect/Info/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Track_Velocity/alertDialogWidget.dart';

class ExerciseType extends StatefulWidget {
  const ExerciseType({Key? key}) : super(key: key);

  @override
  State<ExerciseType> createState() => _ExerciseTypeState();
}

class _ExerciseTypeState extends State<ExerciseType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Exercises",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
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
                          child: const Text("Add New")),
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
                        child: const Text("Import CSV")),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text(
                    "Exercise Type",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(left: 8.0),
                      height: 30,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2.0,
                              spreadRadius: 0.4)
                        ],
                        color: HexColor("#FFFFFF"),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "All Type",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
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
              ],
            ),
            const SizedBox(
              height: 10,
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
                    label: Text("Type"),
                  ),
                  DataColumn(
                    label: Text("Description"),
                  ),
                  DataColumn(
                    label: Text("Action"),
                  ),
                ],
                rows: [
                  DataRow(
                    cells: [
                      const DataCell(Text("Mound Blending")),
                      const DataCell(Text("Throwing")),
                      const DataCell(Text("Mound Work")),
                      DataCell(
                        Wrap(
                          alignment: WrapAlignment.start,
                          children: [
                            SizedBox(
                              width: 25,
                              child: IconButton(
                                icon: const Icon(Icons.remove_red_eye),
                                color: Colors.black,
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(
                              width: 25,
                              child: IconButton(
                                icon: const Icon(Icons.edit),
                                color: Colors.black,
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(
                              width: 15,
                              child: IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const AlertDialogWidget();
                                    },
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SizedBox(
                                width: 30,
                                child: IconButton(
                                    icon: const Icon(Icons.file_copy),
                                    color: Colors.black,
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const AlertDialogueCopy();
                                        },
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  DataRow(
                    cells: [
                      const DataCell(Text("Mound Blending")),
                      const DataCell(Text("Throwing")),
                      const DataCell(Text("Mound Work")),
                      DataCell(
                        Wrap(
                          alignment: WrapAlignment.start,
                          children: [
                            SizedBox(
                              width: 25,
                              child: IconButton(
                                icon: const Icon(Icons.remove_red_eye),
                                color: Colors.black,
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(
                              width: 25,
                              child: IconButton(
                                icon: const Icon(Icons.edit),
                                color: Colors.black,
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(
                              width: 15,
                              child: IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const AlertDialogWidget();
                                    },
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SizedBox(
                                width: 30,
                                child: IconButton(
                                  icon: const Icon(Icons.file_copy),
                                  color: Colors.black,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialogueCopy();
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  DataRow(
                    cells: [
                      const DataCell(Text("Mound Blending")),
                      const DataCell(Text("Throwing")),
                      const DataCell(Text("Mound Work")),
                      DataCell(
                        Wrap(
                          alignment: WrapAlignment.start,
                          children: [
                            SizedBox(
                              width: 25,
                              child: IconButton(
                                icon: const Icon(Icons.remove_red_eye),
                                color: Colors.black,
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(
                              width: 25,
                              child: IconButton(
                                icon: const Icon(Icons.edit),
                                color: Colors.black,
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(
                              width: 15,
                              child: IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const AlertDialogWidget();
                                    },
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SizedBox(
                                width: 30,
                                child: IconButton(
                                  icon: const Icon(Icons.file_copy),
                                  color: Colors.black,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialogueCopy();
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  DataRow(
                    cells: [
                      const DataCell(Text("Mound Blending")),
                      const DataCell(Text("Throwing")),
                      const DataCell(Text("Mound Work")),
                      DataCell(
                        Wrap(
                          alignment: WrapAlignment.start,
                          children: [
                            SizedBox(
                              width: 25,
                              child: IconButton(
                                icon: const Icon(Icons.remove_red_eye),
                                color: Colors.black,
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(
                              width: 25,
                              child: IconButton(
                                icon: const Icon(Icons.edit),
                                color: Colors.black,
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(
                              width: 15,
                              child: IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const AlertDialogWidget();
                                    },
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SizedBox(
                                width: 30,
                                child: IconButton(
                                  icon: const Icon(Icons.file_copy),
                                  color: Colors.black,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialogueCopy();
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  DataRow(
                    cells: [
                      const DataCell(Text("Mound Blending")),
                      const DataCell(Text("Throwing")),
                      const DataCell(Text("Mound Work")),
                      DataCell(
                        Wrap(
                          alignment: WrapAlignment.start,
                          children: [
                            SizedBox(
                              width: 25,
                              child: IconButton(
                                icon: const Icon(Icons.remove_red_eye),
                                color: Colors.black,
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(
                              width: 25,
                              child: IconButton(
                                icon: const Icon(Icons.edit),
                                color: Colors.black,
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(
                              width: 15,
                              child: IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const AlertDialogWidget();
                                    },
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SizedBox(
                                width: 30,
                                child: IconButton(
                                  icon: const Icon(Icons.file_copy),
                                  color: Colors.black,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialogueCopy();
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigaion(),
    );
  }
}
