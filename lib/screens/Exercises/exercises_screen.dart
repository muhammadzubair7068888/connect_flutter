import 'package:connect/screens/Exercises/shareDialogWidget.dart';
import 'package:connect/screens/Exercises/view_exercise_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Track_Velocity/alertDialogWidget.dart';
import 'import_exercises.dart';
import 'new_exercise_screen.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: HexColor("#31D858"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewExercise(),
                        ),
                      );
                    },
                    child: const Text("Add New"),
                  ),
                ),
                SizedBox(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ImportExercise(),
                        ),
                      );
                    },
                    child: const Text("Import CSV"),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey, blurRadius: 2.0, spreadRadius: 0.4)
                  ],
                ),
                child: DropdownSearch<String>(
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                      contentPadding: EdgeInsets.all(10),
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      labelText: 'Exercise Type',
                    ),
                  ),
                  popupProps: const PopupProps.menu(
                    showSelectedItems: true,
                    // disabledItemFn: (String s) => s.startsWith('I'),
                  ),
                  items: const [
                    "Adam",
                    "John",
                    "Katty",
                    'Ariana',
                  ],
                  onChanged: print,
                  // selectedItem: "Brazil",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                    label: Text("   Action"),
                  ),
                ],
                rows: [
                  DataRow(
                    cells: [
                      const DataCell(
                        Text("Mound Blending"),
                      ),
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
                                color: HexColor("#30CED9"),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ViewExerciseScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: 25,
                              child: IconButton(
                                icon: const Icon(Icons.edit_outlined),
                                color: HexColor("#30CED9"),
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
                            SizedBox(
                              width: 25,
                              child: IconButton(
                                icon: const Icon(Icons.share_outlined),
                                color: HexColor("#30CED9"),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const ShareDialogWidget();
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
      ),
    );
  }
}
