import 'package:connect/screens/BottomNavBar/bottomNavBar_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Info/info_screen.dart';
import '../Track_Velocity/alertDialogWidget.dart';
import 'add_user_screen.dart';
import 'import_user_screen.dart';

class UserDetail extends StatefulWidget {
  final String role;
  final bool removed;
  const UserDetail({
    Key? key,
    required this.role,
    required this.removed,
  }) : super(key: key);

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
          onPressed: widget.removed
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavBar(
                        role: widget.role,
                      ),
                    ),
                  );
                }
              : () {
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
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),

              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: HexColor("#31D858"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddUser(
                          role: widget.role,
                        ),
                      ),
                    );
                  },
                  child: const Text("Add New"),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
              ),
              // Expanded(
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10.0),
              //       ),
              //     ),
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => const ImportUser(),
              //         ),
              //       );
              //     },
              //     child: const Text("Import CSV"),
              //   ),
              // ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
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
                    )
                  ],
                ),
              ],
            ),
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