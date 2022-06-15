import 'dart:math';

import 'package:connect/screens/Track_Velocity/alertDialogWidget.dart';
import 'package:date_field/date_field.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:intl/intl.dart';
import 'package:one_context/one_context.dart';

class VelocityScreen extends StatefulWidget {
  const VelocityScreen({Key? key}) : super(key: key);

  @override
  State<VelocityScreen> createState() => _VelocityScreenState();
}

class _VelocityScreenState extends State<VelocityScreen> {
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
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              setState(() {
                filter = !filter;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: filter,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Velocity",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: HexColor("#222222"),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
                        child: Text(
                          "Date",
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
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
                        child: Text(
                          "Weight",
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
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Weight',
                                contentPadding: EdgeInsets.only(left: 20),
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {},
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 5),
                        child: Text(
                          "Arm pain",
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
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 20, right: 15),
                              border: InputBorder.none,
                            ),
                            isExpanded: true,
                            iconEnabledColor: HexColor("#30CED9"),
                            onChanged: dropdownCallback,
                            value: _dropdownValue,
                            // underline: DropdownButtonHideUnderline(child: Container()),
                            items: const [
                              DropdownMenuItem<int>(
                                value: 1,
                                child: Text("1"),
                              ),
                              DropdownMenuItem(
                                value: 2,
                                child: Text("2"),
                              ),
                              DropdownMenuItem(
                                value: 3,
                                child: Text("3"),
                              ),
                              DropdownMenuItem(
                                value: 4,
                                child: Text("4"),
                              ),
                              DropdownMenuItem(
                                value: 5,
                                child: Text("5"),
                              ),
                              DropdownMenuItem(
                                value: 6,
                                child: Text("6"),
                              ),
                              DropdownMenuItem(
                                value: 7,
                                child: Text("7"),
                              ),
                              DropdownMenuItem(
                                value: 8,
                                child: Text("8"),
                              ),
                              DropdownMenuItem(
                                value: 9,
                                child: Text("9"),
                              ),
                              DropdownMenuItem(
                                value: 10,
                                child: Text("10"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text("Yes"),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text("No"),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "History",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: HexColor("#222222"),
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Flexible(
                        child: SizedBox(
                          height: 40,
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
                      )
                    ],
                  ),
                ],
              ),
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
                    label: Text("Date"),
                  ),
                  DataColumn(
                    label: Text("Weight"),
                  ),
                  DataColumn(
                    label: Text("Arm Pain"),
                  ),
                  DataColumn(
                    label: Text("Action"),
                  ),
                ],
                rows: [
                  DataRow(
                    cells: [
                      const DataCell(Text("2016")),
                      const DataCell(Text("11")),
                      const DataCell(Text("10")),
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
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  DataRow(
                    cells: [
                      const DataCell(Text("2017")),
                      const DataCell(Text("10")),
                      const DataCell(Text("9")),
                      DataCell(
                          const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ), onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialogWidget();
                          },
                        );
                      }),
                    ],
                  ),
                  DataRow(
                    cells: [
                      const DataCell(Text("2018")),
                      const DataCell(Text("9")),
                      const DataCell(Text("8")),
                      DataCell(
                          const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ), onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialogWidget();
                          },
                        );
                      }),
                    ],
                  ),
                  DataRow(
                    cells: [
                      const DataCell(Text("2019")),
                      const DataCell(Text("8")),
                      const DataCell(Text("7")),
                      DataCell(
                          const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ), onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialogWidget();
                          },
                        );
                      }),
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
