import 'package:connect/screens/Track_Velocity/alertDialogWidget.dart';
import 'package:date_field/date_field.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:intl/intl.dart';
import 'package:one_context/one_context.dart';

class FileScreen extends StatefulWidget {
  const FileScreen({Key? key}) : super(key: key);

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  int? _dropdownValue = 1;
  bool filter = false;
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: HexColor("#F6F6F6"),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios),
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
      setState(() {
        _dropdownValue = selectedValue;
      });
      print(selectedValue);
    }
  }
}

// The "soruce" of the table
