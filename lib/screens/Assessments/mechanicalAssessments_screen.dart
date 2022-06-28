import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Track_Velocity/alertDialogWidget.dart';

class MechanicalAssessments extends StatefulWidget {
  const MechanicalAssessments({Key? key}) : super(key: key);

  @override
  State<MechanicalAssessments> createState() => _MechanicalAssessmentsState();
}

class _MechanicalAssessmentsState extends State<MechanicalAssessments> {
  // int _singleValue = 1;
  List<int> groupValue = [];
  final rows = <DataRow>[];
  List object = [
    {
      "name": "Back leg co-contraction",
      "value": 1,
    },
    {
      "name": "Does Not Counter Rotate",
      "value": 2,
    },
    {
      "name": "Shifts to Ball of Foot on Time	",
      "value": 3,
    },
    {
      "name": "Quality of Pelvic Tilt	",
      "value": 1,
    },
    {
      "name": "Inverted W	",
      "value": 2,
    },
    {
      "name": "Direction of Load",
      "value": 3,
    },
    {
      "name": "Butt Behind Heel",
      "value": 1,
    },
    {
      "name": "Back Knee Not Forward of Toes",
      "value": 2,
    },
    {
      "name": "Foot Plant From Above",
      "value": 3,
    },
    {
      "name": "Lead Leg Co-Contraction",
      "value": 1,
    },
    {
      "name": "Front Knee Does Not Leak Forward",
      "value": 2,
    },
    {
      "name": "Front Knee Does Not Wiggle Laterally",
      "value": 3,
    },
    {
      "name": "Shoulder Rotates in Plane",
      "value": 1,
    },
    {
      "name": "Pronated Takeaway",
      "value": 2,
    },
    {
      "name": "Elevated Distal Humerus",
      "value": 3,
    },
    {
      "name": "Forearm Flyout",
      "value": 1,
    },
    {
      "name": "Forearm Play",
      "value": 2,
    },
    {
      "name": "Scap Retracts to Spine",
      "value": 3,
    },
    {
      "name": "Glove Side Co-Contracts",
      "value": 1,
    },
    {
      "name": "Hips Rotate Before Shoulders",
      "value": 2,
    },
    {
      "name": "Does Not Disconnect Posture Laterally",
      "value": 3,
    },
    {
      "name": "Rotate to Back Foot",
      "value": 1,
    },
    {
      "name": "Trail Hip Parallel to Lead Hip",
      "value": 2,
    },
    {
      "name": "Gets to Late Launch",
      "value": 3,
    },
    {
      "name": "Shoulder Internally Rotates, Forearm Pronates",
      "value": 1,
    },
    {
      "name": "Elbow Stays Loose and Bent",
      "value": 2,
    },
    {
      "name": "Shoulders Trade Places",
      "value": 3,
    },
    {
      "name": "Rotates Around Front Hip",
      "value": 1,
    },
    {
      "name": "Elbow Does Not Cross Midline",
      "value": 2,
    },
    {
      "name": "Avoids Late Bang on Posterior Shoulder",
      "value": 3,
    },
    {
      "name": "Side Split",
      "value": 2,
    },
    {
      "name": "Lead Leg Does Not Open Early",
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
                      "Mechanical Assessments",
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
