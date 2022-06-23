import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Exercises/shareDialogWidget.dart';
import '../Track_Velocity/alertDialogWidget.dart';

class PhysicalAssessments extends StatefulWidget {
  const PhysicalAssessments({Key? key}) : super(key: key);

  @override
  State<PhysicalAssessments> createState() => _PhysicalAssessmentsState();
}

class _PhysicalAssessmentsState extends State<PhysicalAssessments> {
  int _singleValue = 1;
  List<int> groupValue = [];
  final rows = <DataRow>[];
  List object = [
    {
      "name": "Gross Posture Anomalies",
      "value": 1,
    },
    {
      "name": "Shrugging",
      "value": 2,
    },
    {
      "name": "Asymmetrical Upward Rotation",
      "value": 3,
    },
    {
      "name": "Winging On Descent",
      "value": 1,
    },
    {
      "name": "Eccentric Control",
      "value": 2,
    },
    {
      "name": "Lat Activation",
      "value": 3,
    },
    {
      "name": "GIRD Deficit",
      "value": 1,
    },
    {
      "name": "Pec Quality",
      "value": 2,
    },
    {
      "name": "Flat Foot",
      "value": 3,
    },
    {
      "name": "Palms To Floor",
      "value": 1,
    },
    {
      "name": "Back Bridge",
      "value": 2,
    },
    {
      "name": "One Legged Balance Holds",
      "value": 3,
    },
    {
      "name": "Front Split",
      "value": 1,
    },
    {
      "name": "Side Split",
      "value": 2,
    },
    {
      "name": "Dead Hang",
      "value": 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
                      "Physical Assessment",
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
            child: DataTable(
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => HexColor("#30CED9")),
              sortColumnIndex: 0,
              sortAscending: true,
              columns: const [
                DataColumn(
                  label: Text("Assessments"),
                ),
                DataColumn(
                  label: Text("Acceptable"),
                ),
                DataColumn(
                  label: Text("Caution"),
                ),
                DataColumn(
                  label: Text("Opportunity"),
                ),
                DataColumn(
                  label: Text("  Action"),
                ),
              ],
              rows: () {
                rows.clear();
                for (var i = 0; i < object.length; i++) {
                  String name = object[i]["name"];
                  int val = object[i]["value"];
                  groupValue.add(val);
                  rows.add(
                    DataRow(
                      cells: [
                        DataCell(Text(name)),
                        DataCell(
                          RadioButton(
                            description: "",
                            value: 1,
                            groupValue: groupValue[i],
                            onChanged: (value) => setState(
                              () {
                                groupValue[i] = 1;
                              },
                            ),
                            textPosition: RadioButtonTextPosition.right,
                          ),
                        ),
                        DataCell(
                          RadioButton(
                            description: "",
                            value: 2,
                            groupValue: groupValue[i],
                            onChanged: (value) => setState(
                              () => groupValue[i] = 2,
                            ),
                            textPosition: RadioButtonTextPosition.right,
                          ),
                        ),
                        DataCell(
                          RadioButton(
                            description: "",
                            value: 3,
                            groupValue: groupValue[i],
                            onChanged: (value) => setState(
                              () => groupValue[i] = 3,
                            ),
                            textPosition: RadioButtonTextPosition.right,
                          ),
                        ),
                        DataCell(
                          Wrap(
                            alignment: WrapAlignment.start,
                            children: [
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
                        ),
                      ],
                    ),
                  );
                }
                return rows;
              }(),
            ),
          )
        ],
      ),
    );
  }
}
