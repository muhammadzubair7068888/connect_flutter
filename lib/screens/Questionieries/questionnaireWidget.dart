// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../../Globals/globals.dart';
import '../Track_Velocity/alertDialogWidget.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final storage = const FlutterSecureStorage();
  List<DataRow> rowsAdd = [];

// --                                                               -- //
// --                          START                                -- //
// --                                                               -- //
  Future getQs() async {
    // await EasyLoading.show(
    //   status: 'Loading...',
    //   maskType: EasyLoadingMaskType.black,
    // );
    var url = Uri.parse('${apiURL}questionnaire/index');
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
          rowsAdd = [];
          for (var i = 0; i < jsonData['data'].length; i++) {
            rowsAdd.add(
              DataRow(
                cells: [
                  DataCell(
                    Wrap(
                      children: const [
                        Text(
                          "What are your biggest fears in regarding to training ?",
                        ),
                      ],
                    ),
                  ),
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
                          });
                    },
                  ),
                ],
              ),
            );
          }
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
// --                                                               -- //
// --                           END                                 -- //
// --                                                               -- //

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    "Questionnaire",
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
        SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          child: DataTable(
            headingRowColor:
                MaterialStateColor.resolveWith((states) => HexColor("#30CED9")),
            sortColumnIndex: 0,
            sortAscending: true,
            columns: const [
              DataColumn(
                label: Text("Question"),
              ),
              DataColumn(
                label: Text("Action"),
              ),
            ],
            rows: rowsAdd,
          ),
        ),
      ],
    );
  }
}
