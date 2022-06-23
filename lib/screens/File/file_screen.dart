import 'package:connect/screens/Track_Velocity/alertDialogWidget.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class FileScreen extends StatefulWidget {
  const FileScreen({Key? key}) : super(key: key);

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  bool filter = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Files",
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
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Upload File"),
                        style: ElevatedButton.styleFrom(
                          primary: HexColor("#13D13F"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Uploaded Files",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: HexColor("#222222"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Stack(
                children: [
                  Container(
                    height: 56,
                    color: Colors.yellow,
                  ),
                  DataTable(
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => HexColor("#30CED9")),
                    sortColumnIndex: 0,
                    sortAscending: true,
                    columns: const [
                      DataColumn(
                        label: Text("Title"),
                      ),
                      DataColumn(
                        label: Text("Filename"),
                      ),
                      DataColumn(
                        label: Text("  Action"),
                      ),
                    ],
                    rows: [
                      DataRow(
                        cells: [
                          const DataCell(Text("Test")),
                          const DataCell(Text("schedule.webm")),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          const DataCell(Text("Test")),
                          const DataCell(Text("schedule.webm")),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          const DataCell(Text("Test")),
                          const DataCell(Text("schedule.webm")),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          const DataCell(Text("Test")),
                          const DataCell(Text("schedule.webm")),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void dropdownCallback(int? selectedValue) {
    if (selectedValue is int) {
      setState(() {});
      print(selectedValue);
    }
  }
}

// The "soruce" of the table
