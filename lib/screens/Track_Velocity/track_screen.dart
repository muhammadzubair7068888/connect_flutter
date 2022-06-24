import 'package:connect/screens/Track_Velocity/alertDialogWidget.dart';
import 'package:date_field/date_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen({Key? key}) : super(key: key);

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  final GlobalKey<FormState> _form = GlobalKey();
  late TextEditingController _controller;
  DateTime dateTime = DateTime.now();
  // DateFormat formatter = DateFormat('yyyy-MM-dd');
  // late String formatted = DateFormat("yyyy-MM-dd").format(dateTime);
  // late DateTime dt = DateTime.parse(DateFormat("yyyy-MM-dd").format(dateTime));
  String armPain = "1";
  String weight = "";
  bool filter = false;

  void _resetForm() {
    _form.currentState?.reset();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
          "Track",
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
                        "Track",
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
                              hintStyle: TextStyle(color: Colors.black),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: InputBorder.none,
                              suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                              contentPadding: EdgeInsets.all(20),
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              labelText: 'Date',
                            ),
                            initialValue: dateTime,
                            mode: DateTimeFieldPickerMode.date,
                            autovalidateMode: AutovalidateMode.always,
                            onDateSelected: (DateTime value) {
                              // dt = DateTime.parse(formatted);
                              value = dateTime;
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
                          child: DropdownSearch<String>(
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.black),
                                errorStyle: TextStyle(color: Colors.redAccent),
                                border: InputBorder.none,
                                suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 10, 20, 10),
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                labelText: 'Arm Pain',
                              ),
                            ),
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                              // disabledItemFn: (String s) => s.startsWith('I'),
                            ),
                            items: const [
                              "1",
                              "2",
                              "3",
                              '4',
                              '5',
                              '6',
                              '7',
                              '8',
                              '9',
                              '10',
                            ],
                            onChanged: (value) {
                              armPain = value!;
                            },
                            selectedItem: armPain,
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
                            child: Form(
                              key: _form,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Weight',
                                  contentPadding: EdgeInsets.only(left: 20),
                                  border: InputBorder.none,
                                ),
                                controller: _controller,
                                validator: (value) {
                                  if (value == null || value == "") {
                                    return "Please enter weight";
                                  }

                                  return null;
                                },
                                onChanged: (value) {
                                  weight = value;
                                },
                              ),
                            )),
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
                          onPressed: () {
                            if (!(_form.currentState?.validate() ?? true)) {
                              return;
                            }
                            print(dateTime);
                            print(armPain);
                            print(weight);
                          },
                          child: const Text("Submit"),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _resetForm();
                          },
                          child: const Text("Clear"),
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
      setState(() {});
      print(selectedValue);
    }
  }
}

// The "soruce" of the table
