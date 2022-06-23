import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Track_Velocity/alertDialogWidget.dart';
import 'add_user_screen.dart';
import 'import_user_screen.dart';

class UserDetail extends StatefulWidget {
  const UserDetail({Key? key}) : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
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
          "User",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "User",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: HexColor("#31D858"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddUser(),
                    ),
                  );
                },
                child: const Text("Add New"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ImportUser(),
                    ),
                  );
                },
                child: const Text("Import CSV"),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.4),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
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
                  label: Text("S.No"),
                ),
                DataColumn(
                  label: Text("Name"),
                ),
                DataColumn(
                  label: Text("Role"),
                ),
                DataColumn(
                  label: Text("Added By"),
                ),
                DataColumn(
                  label: Text("Height"),
                ),
                DataColumn(
                  label: Text("Starting Weight"),
                ),
                DataColumn(
                  label: Text("Last Login"),
                ),
                DataColumn(
                  label: Text("Action"),
                ),
              ],
              rows: [
                DataRow(
                  cells: [
                    const DataCell(Text("112")),
                    const DataCell(Text("Aidan Bennett")),
                    const DataCell(Text("User")),
                    const DataCell(Text("Baldwin Wallace")),
                    const DataCell(Text("6")),
                    const DataCell(Text("215")),
                    const DataCell(Text("Date")),
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
                        ],
                      ),
                    )
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text("112")),
                    const DataCell(Text("Aidan Bennett")),
                    const DataCell(Text("User")),
                    const DataCell(Text("Baldwin Wallace")),
                    const DataCell(Text("6")),
                    const DataCell(Text("215")),
                    const DataCell(Text("Date")),
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
                        ],
                      ),
                    )
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text("112")),
                    const DataCell(Text("Aidan Bennett")),
                    const DataCell(Text("User")),
                    const DataCell(Text("Baldwin Wallace")),
                    const DataCell(Text("6")),
                    const DataCell(Text("215")),
                    const DataCell(Text("Date")),
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
                        ],
                      ),
                    )
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text("112")),
                    const DataCell(Text("Aidan Bennett")),
                    const DataCell(Text("User")),
                    const DataCell(Text("Baldwin Wallace")),
                    const DataCell(Text("6")),
                    const DataCell(Text("215")),
                    const DataCell(Text("Date")),
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
                        ],
                      ),
                    )
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text("112")),
                    const DataCell(Text("Aidan Bennett")),
                    const DataCell(Text("User")),
                    const DataCell(Text("Baldwin Wallace")),
                    const DataCell(Text("6")),
                    const DataCell(Text("215")),
                    const DataCell(Text("Date")),
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
                        ],
                      ),
                    )
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text("112")),
                    const DataCell(Text("Aidan Bennett")),
                    const DataCell(Text("User")),
                    const DataCell(Text("Baldwin Wallace")),
                    const DataCell(Text("6")),
                    const DataCell(Text("215")),
                    const DataCell(Text("Date")),
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
    );
  }
}
