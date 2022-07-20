import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../../Globals/globals.dart';
import '../Track_Velocity/alertDialogWidget.dart';

class PhysicalAssessments extends StatefulWidget {
  const PhysicalAssessments({
    Key? key,
  }) : super(key: key);

  @override
  State<PhysicalAssessments> createState() => _PhysicalAssessmentsState();
}

class _PhysicalAssessmentsState extends State<PhysicalAssessments> {
  final storage = const FlutterSecureStorage();
  List data = [];
  List<DataRow> rowsAdd = [];
  List<int> groupValue = [];

  Future getPhyAsses() async {
    await EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    var url = Uri.parse('${apiURL}assessment/physical/index');
    String? token = await storage.read(key: "token");
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var jsonBody = response.body;
      var jsonData = jsonDecode(jsonBody);
      if (mounted) {
        setState(() {
          data = jsonData["data"];
        });
      }
      await EasyLoading.dismiss();
    } else {
      await EasyLoading.dismiss();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            dismissDirection: DismissDirection.vertical,
            content: Text('Server Error'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getPhyAsses();
  }

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
                rowsAdd.clear();
                for (var i = 0; i < data.length; i++) {
                  String name = data[i]["name"];
                  int val = int.parse(data[i]["status"]);
                  groupValue.add(val);
                  rowsAdd.add(
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
                return rowsAdd;
              }(),
            ),
          )
        ],
      ),
    );
  }
}
