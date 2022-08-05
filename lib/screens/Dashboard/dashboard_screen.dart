import 'dart:convert';

import 'package:date_field/date_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../Globals/globals.dart';
import 'package:http/http.dart' as http;

class DashboardScreen extends StatefulWidget {
  final String role;
  const DashboardScreen({
    Key? key,
    required this.role,
  }) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<FormState> _form = GlobalKey();
  final storage = const FlutterSecureStorage();
  final now = DateTime.now();
  late DateTime dateTime;
  late DateTime lastDayOfMonth;
  DateTime? startDate;
  DateTime? endDate;
  String user = '';
  int? userId;
  var users = [];
  List<_SalesData> weight = [];
  int minWeight = 0;
  int maxWeight = 0;
  List<_SalesData> armPain = [];
  int minArmPain = 0;
  int maxArmPain = 0;
  List<_SalesData> pDVel = [];
  int minPDVel = 0;
  int maxPDVel = 0;
  List<_SalesData> mTVel = [];
  int minMTVel = 0;
  int maxMTVel = 0;
  List<_SalesData> pD3 = [];
  int minPD3 = 0;
  int maxPD3 = 0;
  List<_SalesData> pD4 = [];
  int minPD4 = 0;
  int maxPD4 = 0;
  List<_SalesData> pD5 = [];
  int minPD5 = 0;
  int maxPD5 = 0;
  List<_SalesData> pD6 = [];
  int minPD6 = 0;
  int maxPD6 = 0;
  List<_SalesData> pD7 = [];
  int minPD7 = 0;
  int maxPD7 = 0;
  List<_SalesData> lTDis = [];
  int minLTDis = 0;
  int maxLTDis = 0;
  List<_SalesData> p7 = [];
  int minP7 = 0;
  int maxP7 = 0;
  List<_SalesData> p5 = [];
  int minP5 = 0;
  int maxP5 = 0;
  List<_SalesData> p3 = [];
  int minP3 = 0;
  int maxP3 = 0;
  List<_SalesData> bench = [];
  int minBench = 0;
  int maxBench = 0;
  List<_SalesData> squat = [];
  int minSquat = 0;
  int maxSquat = 0;
  List<_SalesData> deadLift = [];
  int minDeadLift = 0;
  int maxDeadLift = 0;
  List<_SalesData> verticalJump = [];
  int minVerticalJump = 0;
  int maxVerticalJump = 0;
  int w = 0;
  int a = 0;
  int pdv = 0;
  int mtv = 0;
  int pd3 = 0;
  int pd4 = 0;
  int pd5 = 0;
  int pd6 = 0;
  int pd7 = 0;
  int ltd = 0;
  int pylo7 = 0;
  int pylo5 = 0;
  int pylo3 = 0;
  int b = 0;
  int s = 0;
  int dl = 0;
  int vj = 0;
  List<DataRow> rowsAdd = [];
  List data = [];

// --                                                               -- //
// --                          START                                -- //
// --                                                               -- //
  Future getVelocities() async {
    await EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    var url = Uri.parse('${apiURL}velocity/graph');
    String? token = await storage.read(key: "token");
    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String?>{
        'start_date': dateTime.toString(),
        'end_date': lastDayOfMonth.toString(),
        'name': user,
      }),
    );
    if (response.statusCode == 200) {
      var jsonBody = response.body;
      var jsonData = jsonDecode(jsonBody);
      if (mounted) {
        setState(() {
          final we =
              jsonData['graphs'].where((e) => e["key"] == "weight").toList();
          w = int.parse(we[0]["status"]);
          final ar =
              jsonData['graphs'].where((e) => e["key"] == "arm_pain").toList();
          a = int.parse(ar[0]["status"]);
          final pdvel = jsonData['graphs']
              .where((e) => e["key"] == "pull_down_velocity")
              .toList();
          pdv = int.parse(pdvel[0]["status"]);
          final mtvel = jsonData['graphs']
              .where((e) => e["key"] == "mound_throws_velocity")
              .toList();
          mtv = int.parse(mtvel[0]["status"]);
          final pdo3 = jsonData['graphs']
              .where((e) => e["key"] == "pull_down_3")
              .toList();
          pd3 = int.parse(pdo3[0]["status"]);
          final pdo4 = jsonData['graphs']
              .where((e) => e["key"] == "pull_down_4")
              .toList();
          pd4 = int.parse(pdo4[0]["status"]);
          final pdo5 = jsonData['graphs']
              .where((e) => e["key"] == "pull_down_5")
              .toList();
          pd5 = int.parse(pdo5[0]["status"]);
          final pdo6 = jsonData['graphs']
              .where((e) => e["key"] == "pull_down_6")
              .toList();
          pd6 = int.parse(pdo6[0]["status"]);
          final pdo7 = jsonData['graphs']
              .where((e) => e["key"] == "pull_down_7")
              .toList();
          pd7 = int.parse(pdo7[0]["status"]);
          final ltdis = jsonData['graphs']
              .where((e) => e["key"] == "long_toss_distance")
              .toList();
          ltd = int.parse(ltdis[0]["status"]);
          final py7 =
              jsonData['graphs'].where((e) => e["key"] == "pylo_7").toList();
          pylo7 = int.parse(py7[0]["status"]);
          final py5 =
              jsonData['graphs'].where((e) => e["key"] == "pylo_5").toList();
          pylo5 = int.parse(py5[0]["status"]);
          final py3 =
              jsonData['graphs'].where((e) => e["key"] == "pylo_3").toList();
          pylo3 = int.parse(py3[0]["status"]);
          final ben =
              jsonData['graphs'].where((e) => e["key"] == "bench").toList();
          b = int.parse(ben[0]["status"]);
          final sq =
              jsonData['graphs'].where((e) => e["key"] == "squat").toList();
          s = int.parse(sq[0]["status"]);
          final dlf =
              jsonData['graphs'].where((e) => e["key"] == "deadlift").toList();
          dl = int.parse(dlf[0]["status"]);
          final vjp = jsonData['graphs']
              .where((e) => e["key"] == "vertical_jump")
              .toList();
          vj = int.parse(vjp[0]["status"]);
          weight = [];
          armPain = [];
          pDVel = [];
          mTVel = [];
          pD3 = [];
          pD4 = [];
          pD5 = [];
          pD6 = [];
          pD7 = [];
          lTDis = [];
          p7 = [];
          p5 = [];
          p3 = [];
          bench = [];
          squat = [];
          deadLift = [];
          verticalJump = [];

          dynamic min = jsonData['weight'].first;
          dynamic max = jsonData['weight'].first;
          jsonData['weight'].forEach((e) {
            if (e['weight'] < min['weight']) min = e;
          });
          jsonData['weight'].forEach((e) {
            if (e['weight'] > max['weight']) max = e;
          });
          minWeight = min['weight'];
          maxWeight = max['weight'];

          // -----------------------------------------------

          dynamic min2 = jsonData['arm_pain'].first;
          dynamic max2 = jsonData['arm_pain'].first;
          jsonData['arm_pain'].forEach((e) {
            if (e['arm_pain'] < min2['arm_pain']) min2 = e;
          });
          jsonData['arm_pain'].forEach((e) {
            if (e['arm_pain'] > max2['arm_pain']) max2 = e;
          });
          minArmPain = min2['arm_pain'];
          maxArmPain = max2['arm_pain'];

          // -----------------------------------------------

          dynamic min3 = jsonData['pull_down_velocity'].first;
          dynamic max3 = jsonData['pull_down_velocity'].first;
          jsonData['pull_down_velocity'].forEach((e) {
            if (e['pull_down_velocity'] < min3['pull_down_velocity']) min3 = e;
          });
          jsonData['pull_down_velocity'].forEach((e) {
            if (e['pull_down_velocity'] > max3['pull_down_velocity']) max3 = e;
          });
          minPDVel = min3['pull_down_velocity'];
          maxPDVel = max3['pull_down_velocity'];

          // -----------------------------------------------

          dynamic min4 = jsonData['mount_throw_velocit'].first;
          dynamic max4 = jsonData['mount_throw_velocit'].first;
          jsonData['mount_throw_velocit'].forEach((e) {
            if (e['mount_throw_velocit'] < min4['mount_throw_velocit']) {
              min4 = e;
            }
          });
          jsonData['mount_throw_velocit'].forEach((e) {
            if (e['mount_throw_velocit'] > max4['mount_throw_velocit']) {
              max4 = e;
            }
          });
          minMTVel = min4['mount_throw_velocit'];
          maxMTVel = max4['mount_throw_velocit'];

          // -----------------------------------------------

          dynamic min5 = jsonData['pull_down_3'].first;
          dynamic max5 = jsonData['pull_down_3'].first;
          jsonData['pull_down_3'].forEach((e) {
            if (e['pull_down_3'] < min5['pull_down_3']) min5 = e;
          });
          jsonData['pull_down_3'].forEach((e) {
            if (e['pull_down_3'] > max5['pull_down_3']) max5 = e;
          });
          minPD3 = min5['pull_down_3'];
          maxPD3 = max5['pull_down_3'];

          // -----------------------------------------------

          dynamic min6 = jsonData['pull_down_4'].first;
          dynamic max6 = jsonData['pull_down_4'].first;
          jsonData['pull_down_4'].forEach((e) {
            if (e['pull_down_4'] < min6['pull_down_4']) min6 = e;
          });
          jsonData['pull_down_4'].forEach((e) {
            if (e['pull_down_4'] > max6['pull_down_4']) max6 = e;
          });
          minPD4 = min6['pull_down_4'];
          maxPD4 = max6['pull_down_4'];

          // -----------------------------------------------

          dynamic min7 = jsonData['pull_down_5'].first;
          dynamic max7 = jsonData['pull_down_5'].first;
          jsonData['pull_down_5'].forEach((e) {
            if (e['pull_down_5'] < min7['pull_down_5']) min7 = e;
          });
          jsonData['pull_down_5'].forEach((e) {
            if (e['pull_down_5'] > max7['pull_down_5']) max7 = e;
          });
          minPD5 = min7['pull_down_5'];
          maxPD5 = max7['pull_down_5'];

          // -----------------------------------------------

          dynamic min8 = jsonData['pull_down_6'].first;
          dynamic max8 = jsonData['pull_down_6'].first;
          jsonData['pull_down_6'].forEach((e) {
            if (e['pull_down_6'] < min8['pull_down_6']) min8 = e;
          });
          jsonData['pull_down_6'].forEach((e) {
            if (e['pull_down_6'] > max8['pull_down_6']) max8 = e;
          });
          minPD6 = min8['pull_down_6'];
          maxPD6 = max8['pull_down_6'];

          // -----------------------------------------------

          dynamic min9 = jsonData['pull_down_7'].first;
          dynamic max9 = jsonData['pull_down_7'].first;
          jsonData['pull_down_7'].forEach((e) {
            if (e['pull_down_7'] < min9['pull_down_7']) min9 = e;
          });
          jsonData['pull_down_7'].forEach((e) {
            if (e['pull_down_7'] > max9['pull_down_7']) max9 = e;
          });
          minPD7 = min9['pull_down_7'];
          maxPD7 = max9['pull_down_7'];

          // -----------------------------------------------

          dynamic min10 = jsonData['long_toss_distance'].first;
          dynamic max10 = jsonData['long_toss_distance'].first;
          jsonData['long_toss_distance'].forEach((e) {
            if (e['long_toss_distance'] < min10['long_toss_distance']) {
              min10 = e;
            }
          });
          jsonData['long_toss_distance'].forEach((e) {
            if (e['long_toss_distance'] > max10['long_toss_distance']) {
              max10 = e;
            }
          });
          minLTDis = min10['long_toss_distance'];
          maxLTDis = max10['long_toss_distance'];

          // -----------------------------------------------

          dynamic min11 = jsonData['pylo7'].first;
          dynamic max11 = jsonData['pylo7'].first;
          jsonData['pylo7'].forEach((e) {
            if (e['pylo7'] < min11['pylo7']) min11 = e;
          });
          jsonData['pylo7'].forEach((e) {
            if (e['pylo7'] > max11['pylo7']) max11 = e;
          });
          minP7 = min11['pylo7'];
          maxP7 = max11['pylo7'];

          // -----------------------------------------------

          dynamic min12 = jsonData['pylo5'].first;
          dynamic max12 = jsonData['pylo5'].first;
          jsonData['pylo5'].forEach((e) {
            if (e['pylo5'] < min12['pylo5']) min12 = e;
          });
          jsonData['pylo5'].forEach((e) {
            if (e['pylo5'] > max12['pylo5']) max12 = e;
          });
          minP5 = min12['pylo5'];
          maxP5 = max12['pylo5'];

          // -----------------------------------------------

          dynamic min13 = jsonData['bench_all'].first;
          dynamic max13 = jsonData['bench_all'].first;
          jsonData['bench_all'].forEach((e) {
            if (e['bench'] < min13['bench']) min13 = e;
          });
          jsonData['bench_all'].forEach((e) {
            if (e['bench'] > max13['bench']) max13 = e;
          });
          minBench = min13['bench'];
          maxBench = max13['bench'];

          // -----------------------------------------------

          dynamic min14 = jsonData['pylo3'].first;
          dynamic max14 = jsonData['pylo3'].first;
          jsonData['pylo3'].forEach((e) {
            if (e['pylo3'] < min14['pylo3']) min14 = e;
          });
          jsonData['pylo3'].forEach((e) {
            if (e['pylo3'] > max14['pylo3']) max14 = e;
          });
          minP3 = min14['pylo3'];
          maxP3 = max14['pylo3'];

          // -----------------------------------------------

          dynamic min15 = jsonData['squat'].first;
          dynamic max15 = jsonData['squat'].first;
          jsonData['squat'].forEach((e) {
            if (e['squat'] < min15['squat']) min15 = e;
          });
          jsonData['squat'].forEach((e) {
            if (e['squat'] > max15['squat']) max15 = e;
          });
          minSquat = min15['squat'];
          maxSquat = max15['squat'];

          // -----------------------------------------------

          dynamic min16 = jsonData['deadlift'].first;
          dynamic max16 = jsonData['deadlift'].first;
          jsonData['deadlift'].forEach((e) {
            if (e['deadlift'] < min16['deadlift']) min16 = e;
          });
          jsonData['deadlift'].forEach((e) {
            if (e['deadlift'] > max16['deadlift']) max16 = e;
          });
          minDeadLift = min16['deadlift'];
          maxDeadLift = max16['deadlift'];

          // -----------------------------------------------

          dynamic min17 = jsonData['vertical_jump'].first;
          dynamic max17 = jsonData['vertical_jump'].first;
          jsonData['vertical_jump'].forEach((e) {
            if (e['vertical_jump'] < min17['vertical_jump']) min17 = e;
          });
          jsonData['vertical_jump'].forEach((e) {
            if (e['vertical_jump'] > max17['vertical_jump']) max17 = e;
          });
          minVerticalJump = min17['vertical_jump'];
          maxVerticalJump = max17['vertical_jump'];

          // -----------------------------------------------

          for (var i = 0; i < jsonData['weight'].length; i++) {
            weight.add(
              _SalesData(
                jsonData['weight'][i]["date"],
                jsonData['weight'][i]["weight"],
              ),
            );
          }
          for (var i = 0; i < jsonData['arm_pain'].length; i++) {
            armPain.add(
              _SalesData(
                jsonData['arm_pain'][i]["date"],
                jsonData['arm_pain'][i]["arm_pain"],
              ),
            );
          }
          for (var i = 0; i < jsonData['pull_down_velocity'].length; i++) {
            pDVel.add(
              _SalesData(
                jsonData['pull_down_velocity'][i]["date"],
                jsonData['pull_down_velocity'][i]["pull_down_velocity"],
              ),
            );
          }
          for (var i = 0; i < jsonData['mount_throw_velocit'].length; i++) {
            mTVel.add(
              _SalesData(
                jsonData['mount_throw_velocit'][i]["date"],
                jsonData['mount_throw_velocit'][i]["mount_throw_velocit"],
              ),
            );
          }
          for (var i = 0; i < jsonData['pull_down_3'].length; i++) {
            pD3.add(
              _SalesData(
                jsonData['pull_down_3'][i]["date"],
                jsonData['pull_down_3'][i]["pull_down_3"],
              ),
            );
          }
          for (var i = 0; i < jsonData['pull_down_4'].length; i++) {
            pD4.add(
              _SalesData(
                jsonData['pull_down_4'][i]["date"],
                jsonData['pull_down_4'][i]["pull_down_4"],
              ),
            );
          }
          for (var i = 0; i < jsonData['pull_down_5'].length; i++) {
            pD5.add(
              _SalesData(
                jsonData['pull_down_5'][i]["date"],
                jsonData['pull_down_5'][i]["pull_down_5"],
              ),
            );
          }
          for (var i = 0; i < jsonData['pull_down_6'].length; i++) {
            pD6.add(
              _SalesData(
                jsonData['pull_down_6'][i]["date"],
                jsonData['pull_down_6'][i]["pull_down_6"],
              ),
            );
          }
          for (var i = 0; i < jsonData['pull_down_7'].length; i++) {
            pD7.add(
              _SalesData(
                jsonData['pull_down_7'][i]["date"],
                jsonData['pull_down_7'][i]["pull_down_7"],
              ),
            );
          }
          for (var i = 0; i < jsonData['long_toss_distance'].length; i++) {
            lTDis.add(
              _SalesData(
                jsonData['long_toss_distance'][i]["date"],
                jsonData['long_toss_distance'][i]["long_toss_distance"],
              ),
            );
          }
          for (var i = 0; i < jsonData['pylo7'].length; i++) {
            p7.add(
              _SalesData(
                jsonData['pylo7'][i]["date"],
                jsonData['pylo7'][i]["pylo7"],
              ),
            );
          }
          for (var i = 0; i < jsonData['pylo5'].length; i++) {
            p5.add(
              _SalesData(
                jsonData['pylo5'][i]["date"],
                jsonData['pylo5'][i]["pylo5"],
              ),
            );
          }
          for (var i = 0; i < jsonData['pylo3'].length; i++) {
            p3.add(
              _SalesData(
                jsonData['pylo3'][i]["date"],
                jsonData['pylo3'][i]["pylo3"],
              ),
            );
          }
          for (var i = 0; i < jsonData['bench_all'].length; i++) {
            bench.add(
              _SalesData(
                jsonData['bench_all'][i]["date"],
                jsonData['bench_all'][i]["bench"],
              ),
            );
          }
          for (var i = 0; i < jsonData['squat'].length; i++) {
            squat.add(
              _SalesData(
                jsonData['squat'][i]["date"],
                jsonData['squat'][i]["squat"],
              ),
            );
          }
          for (var i = 0; i < jsonData['deadlift'].length; i++) {
            deadLift.add(
              _SalesData(
                jsonData['deadlift'][i]["date"],
                jsonData['deadlift'][i]["deadlift"],
              ),
            );
          }
          for (var i = 0; i < jsonData['vertical_jump'].length; i++) {
            verticalJump.add(
              _SalesData(
                jsonData['vertical_jump'][i]["date"],
                jsonData['vertical_jump'][i]["vertical_jump"],
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

  Future getUsers() async {
    // await EasyLoading.show(
    //   status: 'Loading...',
    //   maskType: EasyLoadingMaskType.black,
    // );
    var url = Uri.parse('${apiURL}users');
    String? token = await storage.read(key: "token");
    String? id = await storage.read(key: "id");
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
          users = jsonData['data'];
          var uId =
              jsonData['data'].where((o) => o['id'] == int.parse(id!)).toList();
          user = uId[0]['name'];
          userId = uId[0]['id'];
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

  Future getPitch() async {
    // await EasyLoading.show(
    //   status: 'Loading...',
    //   maskType: EasyLoadingMaskType.black,
    // );
    var url = Uri.parse('${apiURL}pitch');
    String? token = await storage.read(key: "token");
    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String?>{
        'user_id': userId.toString(),
      }),
    );
    if (response.statusCode == 200) {
      var jsonBody = response.body;
      var jsonData = jsonDecode(jsonBody);
      if (mounted) {
        setState(() {
          data = jsonData['data'];
          rowsAdd = [];
          if (data == []) {
            rowsAdd = [];
          } else {
            for (var i = 0; i < data.length; i++) {
              rowsAdd.add(
                DataRow(
                  cells: [
                    DataCell(Text(data[i]['date'])),
                    DataCell(Text(data[i]['time'])),
                    DataCell(Text("${data[i]['pa_of_inning']}")),
                    DataCell(Text("${data[i]['pitch_of_pa']}")),
                    DataCell(Text("${data[i]['pitcher_id']}")),
                    DataCell(Text(data[i]['pitcher_throws'])),
                    DataCell(Text(data[i]['pitcher_team'])),
                    DataCell(Text(data[i]['batter'])),
                    DataCell(Text(data[i]['batter_id'])),
                    DataCell(Text(data[i]['batter_side'])),
                    DataCell(Text(data[i]['batter_team'])),
                    DataCell(Text(data[i]['pitcher_set'])),
                    DataCell(Text(data[i]['inning'])),
                    DataCell(Text(data[i]['top_bottom'])),
                  ],
                ),
              );
            }
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
    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    dateTime = DateTime(now.year, now.month, 1);
    getVelocities();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _form,
        child: Column(
          children: [
            SizedBox(
              child: widget.role != "user"
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2.0,
                              spreadRadius: 0.4,
                            )
                          ],
                        ),
                        child: DropdownSearch<String>(
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.black),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: InputBorder.none,
                              suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                              contentPadding: EdgeInsets.only(
                                  left: 20, top: 10, bottom: 10),
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              labelText: 'Select User',
                            ),
                          ),
                          popupProps: const PopupProps.menu(
                            showSelectedItems: true,
                            // disabledItemFn: (String s) => s.startsWith('I'),
                          ),
                          items:
                              (users).map((e) => e["name"] as String).toList(),
                          selectedItem: user,
                          validator: (value) {
                            if (value == null || value == "") {
                              return "Please select user";
                            }

                            return null;
                          },
                          onChanged: (value) {
                            user = value!;
                            var uId =
                                users.where((o) => o['name'] == user).toList();
                            userId = uId[0]['id'];
                          },
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey, blurRadius: 2.0, spreadRadius: 0.4)
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
                        fontWeight: FontWeight.bold, color: Colors.black),
                    labelText: 'Start Date',
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  autovalidateMode: AutovalidateMode.always,
                  initialValue: dateTime,
                  onDateSelected: (DateTime value) {
                    dateTime = value;
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 30,
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
                      spreadRadius: 0.4,
                    )
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
                        fontWeight: FontWeight.bold, color: Colors.black),
                    labelText: 'End Date',
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  autovalidateMode: AutovalidateMode.always,
                  initialValue: lastDayOfMonth,
                  validator: (e) =>
                      (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                  onDateSelected: (DateTime value) {
                    // _date = value;
                    lastDayOfMonth = value;
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Respond to button press
                      if (!(_form.currentState?.validate() ?? true)) {
                        return;
                      }
                      getPitch();
                      getVelocities();
                    },
                    style: ElevatedButton.styleFrom(
                      maximumSize: const Size(150, 50),
                      minimumSize: const Size(150, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Text(
                      'Search',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Respond to button press
                      // print(weight);
                    },
                    style: ElevatedButton.styleFrom(
                      maximumSize: const Size(150, 50),
                      minimumSize: const Size(150, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Text(
                      'Clear',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: widget.role != "user"
                  ? DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => HexColor("#30CED9")),
                      sortColumnIndex: 0,
                      sortAscending: true,
                      columns: const [
                        // DataColumn(
                        //   label: Text("S.No"),
                        // ),
                        DataColumn(
                          label: Text("Date"),
                        ),
                        DataColumn(
                          label: Text("Time"),
                        ),
                        DataColumn(
                          label: Text("PaOfInning"),
                        ),
                        DataColumn(
                          label: Text("PitchOfPa"),
                        ),
                        DataColumn(
                          label: Text("PitcherID"),
                        ),
                        DataColumn(
                          label: Text("PitcherThrows"),
                        ),
                        DataColumn(
                          label: Text("PitcherTeam"),
                        ),
                        DataColumn(
                          label: Text("Batter"),
                        ),
                        DataColumn(
                          label: Text("BatterID"),
                        ),
                        DataColumn(
                          label: Text("BatterSide"),
                        ),
                        DataColumn(
                          label: Text("BatterTeam"),
                        ),
                        DataColumn(
                          label: Text("PitcherSet"),
                        ),
                        DataColumn(
                          label: Text("Inning"),
                        ),
                        DataColumn(
                          label: Text("Top/Bottom"),
                        ),
                      ],
                      rows: rowsAdd,
                    )
                  : null,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: w == 1 ? MediaQuery.of(context).size.height * 0.6 : null,
              child: w == 1
                  ? SfCartesianChart(
                      backgroundColor: Colors.white,
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                        minimum: maxWeight == 0 ? -1 : minWeight.toDouble(),
                        maximum: maxWeight == 0 ? 1 : maxWeight.toDouble(),
                        interval: maxWeight > 499
                            ? 100
                            : maxWeight > 399
                                ? 80
                                : maxWeight > 299
                                    ? 60
                                    : maxWeight > 199
                                        ? 40
                                        : maxWeight > 99
                                            ? 20
                                            : maxWeight > 49
                                                ? 10
                                                : maxWeight > 19
                                                    ? 4
                                                    : maxWeight > 9
                                                        ? 2
                                                        : 0.2,
                      ),
                      title: ChartTitle(text: 'Weight'),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries>[
                        // StackedLineSeries<_SalesData, String>(
                        SplineSeries<_SalesData, String>(
                          name: 'Weight',
                          color: HexColor("#30CED9"),
                          dataSource: weight,
                          // dashArray: const <double>[5, 5],
                          xValueMapper: (_SalesData weight, _) => weight.year,
                          yValueMapper: (_SalesData weight, _) => weight.weight,
                          markerSettings: const MarkerSettings(isVisible: true),
                        )
                      ],
                    )
                  : null,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: a == 1 ? MediaQuery.of(context).size.height * 0.6 : null,
              child: a == 1
                  ? SfCartesianChart(
                      backgroundColor: Colors.white,
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                        minimum: maxArmPain == 0 ? -1 : minArmPain.toDouble(),
                        maximum: maxArmPain == 0 ? 1 : maxArmPain.toDouble(),
                        interval: maxArmPain > 499
                            ? 100
                            : maxArmPain > 399
                                ? 80
                                : maxArmPain > 299
                                    ? 60
                                    : maxArmPain > 199
                                        ? 40
                                        : maxArmPain > 99
                                            ? 20
                                            : maxArmPain > 49
                                                ? 10
                                                : maxArmPain > 19
                                                    ? 4
                                                    : maxArmPain > 9
                                                        ? 2
                                                        : 0.2,
                      ),
                      title: ChartTitle(text: 'Arm Pain'),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries>[
                        SplineSeries<_SalesData, String>(
                          name: 'Arm Pain',
                          color: HexColor("#30CED9"),
                          dataSource: armPain,
                          xValueMapper: (_SalesData weight, _) => weight.year,
                          yValueMapper: (_SalesData weight, _) => weight.weight,
                          markerSettings: const MarkerSettings(isVisible: true),
                        )
                      ],
                    )
                  : null,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height:
                  pdv == 1 ? MediaQuery.of(context).size.height * 0.6 : null,
              child: pdv == 1
                  ? SfCartesianChart(
                      backgroundColor: Colors.white,
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                        minimum: maxPDVel == 0 ? -1 : minPDVel.toDouble(),
                        maximum: maxPDVel == 0 ? 1 : maxPDVel.toDouble(),
                        interval: maxPDVel > 499
                            ? 100
                            : maxPDVel > 399
                                ? 80
                                : maxPDVel > 299
                                    ? 60
                                    : maxPDVel > 199
                                        ? 40
                                        : maxPDVel > 99
                                            ? 20
                                            : maxPDVel > 49
                                                ? 10
                                                : maxPDVel > 19
                                                    ? 4
                                                    : maxPDVel > 9
                                                        ? 2
                                                        : 0.2,
                      ),
                      title: ChartTitle(text: 'Pull Down Velocity'),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries>[
                        SplineSeries<_SalesData, String>(
                          name: 'Pull Down Velocity',
                          color: HexColor("#30CED9"),
                          dataSource: pDVel,
                          xValueMapper: (_SalesData weight, _) => weight.year,
                          yValueMapper: (_SalesData weight, _) => weight.weight,
                          markerSettings: const MarkerSettings(isVisible: true),
                        )
                      ],
                    )
                  : null,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height:
                  mtv == 1 ? MediaQuery.of(context).size.height * 0.6 : null,
              child: mtv == 1
                  ? SfCartesianChart(
                      backgroundColor: Colors.white,
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                        minimum: maxMTVel == 0 ? -1 : minMTVel.toDouble(),
                        maximum: maxMTVel == 0 ? 1 : maxMTVel.toDouble(),
                        interval: maxMTVel > 499
                            ? 100
                            : maxMTVel > 399
                                ? 80
                                : maxMTVel > 299
                                    ? 60
                                    : maxMTVel > 199
                                        ? 40
                                        : maxMTVel > 99
                                            ? 20
                                            : maxMTVel > 49
                                                ? 10
                                                : maxMTVel > 19
                                                    ? 4
                                                    : maxMTVel > 9
                                                        ? 2
                                                        : 0.2,
                      ),
                      title: ChartTitle(text: 'Mount Throw Velocity'),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries>[
                        SplineSeries<_SalesData, String>(
                          name: 'Mount Throw Velocity',
                          color: HexColor("#30CED9"),
                          dataSource: mTVel,
                          xValueMapper: (_SalesData weight, _) => weight.year,
                          yValueMapper: (_SalesData weight, _) => weight.weight,
                          markerSettings: const MarkerSettings(isVisible: true),
                        )
                      ],
                    )
                  : null,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height:
                  pd3 == 1 ? MediaQuery.of(context).size.height * 0.6 : null,
              child: pd3 == 1
                  ? SfCartesianChart(
                      backgroundColor: Colors.white,
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                        minimum: maxPD3 == 0 ? -1 : minPD3.toDouble(),
                        maximum: maxPD3 == 0 ? 1 : maxPD3.toDouble(),
                        interval: maxPD3 > 499
                            ? 100
                            : maxPD3 > 399
                                ? 80
                                : maxPD3 > 299
                                    ? 60
                                    : maxPD3 > 199
                                        ? 40
                                        : maxPD3 > 99
                                            ? 20
                                            : maxPD3 > 49
                                                ? 10
                                                : maxPD3 > 19
                                                    ? 4
                                                    : maxPD3 > 9
                                                        ? 2
                                                        : 0.2,
                      ),
                      title: ChartTitle(text: 'Pull Down 3'),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries>[
                        SplineSeries<_SalesData, String>(
                          name: 'Pull Down 3',
                          color: HexColor("#30CED9"),
                          dataSource: pD3,
                          xValueMapper: (_SalesData weight, _) => weight.year,
                          yValueMapper: (_SalesData weight, _) => weight.weight,
                          markerSettings: const MarkerSettings(isVisible: true),
                        )
                      ],
                    )
                  : null,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height:
                  pd4 == 1 ? MediaQuery.of(context).size.height * 0.6 : null,
              child: pd4 == 1
                  ? SfCartesianChart(
                      backgroundColor: Colors.white,
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                        minimum: maxPD4 == 0 ? -1 : minPD4.toDouble(),
                        maximum: maxPD4 == 0 ? 1 : maxPD4.toDouble(),
                        interval: maxPD4 > 499
                            ? 100
                            : maxPD4 > 399
                                ? 80
                                : maxPD4 > 299
                                    ? 60
                                    : maxPD4 > 199
                                        ? 40
                                        : maxPD4 > 99
                                            ? 20
                                            : maxPD4 > 49
                                                ? 10
                                                : maxPD4 > 19
                                                    ? 4
                                                    : maxPD4 > 9
                                                        ? 2
                                                        : 0.2,
                      ),
                      title: ChartTitle(text: 'Pull Down 4'),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries>[
                        SplineSeries<_SalesData, String>(
                          name: 'Pull Down 4',
                          color: HexColor("#30CED9"),
                          dataSource: pD4,
                          xValueMapper: (_SalesData weight, _) => weight.year,
                          yValueMapper: (_SalesData weight, _) => weight.weight,
                          markerSettings: const MarkerSettings(isVisible: true),
                        )
                      ],
                    )
                  : null,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height:
                  pd5 == 1 ? MediaQuery.of(context).size.height * 0.6 : null,
              child: pd5 == 1
                  ? SfCartesianChart(
                      backgroundColor: Colors.white,
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                        minimum: maxPD5 == 0 ? -1 : minPD5.toDouble(),
                        maximum: maxPD5 == 0 ? 1 : maxPD5.toDouble(),
                        interval: maxPD5 > 499
                            ? 100
                            : maxPD5 > 399
                                ? 80
                                : maxPD5 > 299
                                    ? 60
                                    : maxPD5 > 199
                                        ? 40
                                        : maxPD5 > 99
                                            ? 20
                                            : maxPD5 > 49
                                                ? 10
                                                : maxPD5 > 19
                                                    ? 4
                                                    : maxPD5 > 9
                                                        ? 2
                                                        : 0.2,
                      ),
                      title: ChartTitle(text: 'Pull Down 5'),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries>[
                        SplineSeries<_SalesData, String>(
                          name: 'Pull Down 5',
                          color: HexColor("#30CED9"),
                          dataSource: pD5,
                          xValueMapper: (_SalesData weight, _) => weight.year,
                          yValueMapper: (_SalesData weight, _) => weight.weight,
                          markerSettings: const MarkerSettings(isVisible: true),
                        )
                      ],
                    )
                  : null,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height:
                  pd6 == 1 ? MediaQuery.of(context).size.height * 0.6 : null,
              child: pd6 == 1
                  ? SfCartesianChart(
                      backgroundColor: Colors.white,
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                        minimum: maxPD6 == 0 ? -1 : minPD6.toDouble(),
                        maximum: maxPD6 == 0 ? 1 : maxPD6.toDouble(),
                        interval: maxPD6 > 499
                            ? 100
                            : maxPD6 > 399
                                ? 80
                                : maxPD6 > 299
                                    ? 60
                                    : maxPD6 > 199
                                        ? 40
                                        : maxPD6 > 99
                                            ? 20
                                            : maxPD6 > 49
                                                ? 10
                                                : maxPD6 > 19
                                                    ? 4
                                                    : maxPD6 > 9
                                                        ? 2
                                                        : 0.2,
                      ),
                      title: ChartTitle(text: 'Pull Down 6'),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries>[
                        SplineSeries<_SalesData, String>(
                          name: 'Pull Down 6',
                          color: HexColor("#30CED9"),
                          dataSource: pD6,
                          xValueMapper: (_SalesData weight, _) => weight.year,
                          yValueMapper: (_SalesData weight, _) => weight.weight,
                          markerSettings: const MarkerSettings(isVisible: true),
                        )
                      ],
                    )
                  : null,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height:
                  pd7 == 1 ? MediaQuery.of(context).size.height * 0.6 : null,
              child: pd7 == 1
                  ? SfCartesianChart(
                      backgroundColor: Colors.white,
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                        minimum: maxPD7 == 0 ? -1 : minPD7.toDouble(),
                        maximum: maxPD7 == 0 ? 1 : maxPD7.toDouble(),
                        interval: maxPD7 > 499
                            ? 100
                            : maxPD7 > 399
                                ? 80
                                : maxPD7 > 299
                                    ? 60
                                    : maxPD7 > 199
                                        ? 40
                                        : maxPD7 > 99
                                            ? 20
                                            : maxPD7 > 49
                                                ? 10
                                                : maxPD7 > 19
                                                    ? 4
                                                    : maxPD7 > 9
                                                        ? 2
                                                        : 0.2,
                      ),
                      title: ChartTitle(text: 'Pull Down 7'),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries>[
                        SplineSeries<_SalesData, String>(
                          name: 'Pull Down 7',
                          color: HexColor("#30CED9"),
                          dataSource: pD7,
                          xValueMapper: (_SalesData weight, _) => weight.year,
                          yValueMapper: (_SalesData weight, _) => weight.weight,
                          markerSettings: const MarkerSettings(isVisible: true),
                        )
                      ],
                    )
                  : null,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height:
                  ltd == 1 ? MediaQuery.of(context).size.height * 0.6 : null,
              child: ltd == 1
                  ? SfCartesianChart(
                      backgroundColor: Colors.white,
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                        minimum: maxLTDis == 0 ? -1 : minLTDis.toDouble(),
                        maximum: maxLTDis == 0 ? 1 : maxLTDis.toDouble(),
                        interval: maxLTDis > 499
                            ? 100
                            : maxLTDis > 399
                                ? 80
                                : maxLTDis > 299
                                    ? 60
                                    : maxLTDis > 199
                                        ? 40
                                        : maxLTDis > 99
                                            ? 20
                                            : maxLTDis > 49
                                                ? 10
                                                : maxLTDis > 19
                                                    ? 4
                                                    : maxLTDis > 9
                                                        ? 2
                                                        : 0.2,
                      ),
                      title: ChartTitle(text: 'Long Toss Distance'),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries>[
                        SplineSeries<_SalesData, String>(
                          name: 'Long Toss Distance',
                          color: HexColor("#30CED9"),
                          dataSource: lTDis,
                          xValueMapper: (_SalesData weight, _) => weight.year,
                          yValueMapper: (_SalesData weight, _) => weight.weight,
                          markerSettings: const MarkerSettings(isVisible: true),
                        )
                      ],
                    )
                  : null,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height:
                  pylo7 == 1 ? MediaQuery.of(context).size.height * 0.6 : null,
              child: pylo7 == 1
                  ? SfCartesianChart(
                      backgroundColor: Colors.white,
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                        minimum: maxP7 == 0 ? -1 : minP7.toDouble(),
                        maximum: maxP7 == 0 ? 1 : maxP7.toDouble(),
                        interval: maxP7 > 499
                            ? 100
                            : maxP7 > 399
                                ? 80
                                : maxP7 > 299
                                    ? 60
                                    : maxP7 > 199
                                        ? 40
                                        : maxP7 > 99
                                            ? 20
                                            : maxP7 > 49
                                                ? 10
                                                : maxP7 > 19
                                                    ? 4
                                                    : maxP7 > 9
                                                        ? 2
                                                        : 0.2,
                      ),
                      title: ChartTitle(text: 'Pylo 7'),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries>[
                        SplineSeries<_SalesData, String>(
                          name: 'Pylo 7',
                          color: HexColor("#30CED9"),
                          dataSource: p7,
                          xValueMapper: (_SalesData weight, _) => weight.year,
                          yValueMapper: (_SalesData weight, _) => weight.weight,
                          markerSettings: const MarkerSettings(isVisible: true),
                        )
                      ],
                    )
                  : null,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height:
                  pylo5 == 1 ? MediaQuery.of(context).size.height * 0.6 : null,
              child: pylo5 == 1
                  ? SfCartesianChart(
                      backgroundColor: Colors.white,
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                        minimum: maxP5 == 0 ? -1 : minP5.toDouble(),
                        maximum: maxP5 == 0 ? 1 : maxP5.toDouble(),
                        interval: maxP5 > 499
                            ? 100
                            : maxP5 > 399
                                ? 80
                                : maxP5 > 299
                                    ? 60
                                    : maxP5 > 199
                                        ? 40
                                        : maxP5 > 99
                                            ? 20
                                            : maxP5 > 49
                                                ? 10
                                                : maxP5 > 19
                                                    ? 4
                                                    : maxP5 > 9
                                                        ? 2
                                                        : 0.2,
                      ),
                      title: ChartTitle(text: 'Pylo 5'),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries>[
                        SplineSeries<_SalesData, String>(
                          name: 'Pylo 5',
                          color: HexColor("#30CED9"),
                          dataSource: p5,
                          xValueMapper: (_SalesData weight, _) => weight.year,
                          yValueMapper: (_SalesData weight, _) => weight.weight,
                          markerSettings: const MarkerSettings(isVisible: true),
                        )
                      ],
                    )
                  : null,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height:
                  pylo3 == 1 ? MediaQuery.of(context).size.height * 0.6 : null,
              child: pylo3 == 1
                  ? SfCartesianChart(
                      backgroundColor: Colors.white,
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                        minimum: maxP3 == 0 ? -1 : minP3.toDouble(),
                        maximum: maxP3 == 0 ? 1 : maxP3.toDouble(),
                        interval: maxP3 > 499
                            ? 100
                            : maxP3 > 399
                                ? 80
                                : maxP3 > 299
                                    ? 60
                                    : maxP3 > 199
                                        ? 40
                                        : maxP3 > 99
                                            ? 20
                                            : maxP3 > 49
                                                ? 10
                                                : maxP3 > 19
                                                    ? 4
                                                    : maxP3 > 9
                                                        ? 2
                                                        : 0.2,
                      ),
                      title: ChartTitle(text: 'Pylo 3'),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries>[
                        SplineSeries<_SalesData, String>(
                          name: 'Pylo 3',
                          color: HexColor("#30CED9"),
                          dataSource: p3,
                          xValueMapper: (_SalesData weight, _) => weight.year,
                          yValueMapper: (_SalesData weight, _) => weight.weight,
                          markerSettings: const MarkerSettings(isVisible: true),
                        )
                      ],
                    )
                  : null,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: b == 1 ? MediaQuery.of(context).size.height * 0.6 : null,
              child: b == 1
                  ? SfCartesianChart(
                      backgroundColor: Colors.white,
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                        minimum: maxBench == 0 ? -1 : minBench.toDouble(),
                        maximum: maxBench == 0 ? 1 : maxBench.toDouble(),
                        interval: maxBench > 499
                            ? 100
                            : maxBench > 399
                                ? 80
                                : maxBench > 299
                                    ? 60
                                    : maxBench > 199
                                        ? 40
                                        : maxBench > 99
                                            ? 20
                                            : maxBench > 49
                                                ? 10
                                                : maxBench > 19
                                                    ? 4
                                                    : maxBench > 9
                                                        ? 2
                                                        : 0.2,
                      ),
                      title: ChartTitle(text: 'Bench'),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries>[
                        SplineSeries<_SalesData, String>(
                          name: 'Bench',
                          color: HexColor("#30CED9"),
                          dataSource: bench,
                          xValueMapper: (_SalesData weight, _) => weight.year,
                          yValueMapper: (_SalesData weight, _) => weight.weight,
                          markerSettings: const MarkerSettings(isVisible: true),
                        )
                      ],
                    )
                  : null,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: s == 1 ? MediaQuery.of(context).size.height * 0.6 : null,
              child: s == 1
                  ? SfCartesianChart(
                      backgroundColor: Colors.white,
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                        minimum: maxSquat == 0 ? -1 : minSquat.toDouble(),
                        maximum: maxSquat == 0 ? 1 : maxSquat.toDouble(),
                        interval: maxSquat > 499
                            ? 100
                            : maxSquat > 399
                                ? 80
                                : maxSquat > 299
                                    ? 60
                                    : maxSquat > 199
                                        ? 40
                                        : maxSquat > 99
                                            ? 20
                                            : maxSquat > 49
                                                ? 10
                                                : maxSquat > 19
                                                    ? 4
                                                    : maxSquat > 9
                                                        ? 2
                                                        : 0.2,
                      ),
                      title: ChartTitle(text: 'Squat'),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries>[
                        SplineSeries<_SalesData, String>(
                          name: 'Squat',
                          color: HexColor("#30CED9"),
                          dataSource: squat,
                          xValueMapper: (_SalesData weight, _) => weight.year,
                          yValueMapper: (_SalesData weight, _) => weight.weight,
                          markerSettings: const MarkerSettings(isVisible: true),
                        )
                      ],
                    )
                  : null,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: dl == 1 ? MediaQuery.of(context).size.height * 0.6 : null,
              child: dl == 1
                  ? SfCartesianChart(
                      backgroundColor: Colors.white,
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                        minimum: maxDeadLift == 0 ? -1 : minDeadLift.toDouble(),
                        maximum: maxDeadLift == 0 ? 1 : maxDeadLift.toDouble(),
                        interval: maxDeadLift > 499
                            ? 100
                            : maxDeadLift > 399
                                ? 80
                                : maxDeadLift > 299
                                    ? 60
                                    : maxDeadLift > 199
                                        ? 40
                                        : maxDeadLift > 99
                                            ? 20
                                            : maxDeadLift > 49
                                                ? 10
                                                : maxDeadLift > 19
                                                    ? 4
                                                    : maxDeadLift > 9
                                                        ? 2
                                                        : 0.2,
                      ),
                      title: ChartTitle(text: 'DeadLift'),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries>[
                        SplineSeries<_SalesData, String>(
                          name: 'DeadLift',
                          color: HexColor("#30CED9"),
                          dataSource: deadLift,
                          xValueMapper: (_SalesData weight, _) => weight.year,
                          yValueMapper: (_SalesData weight, _) => weight.weight,
                          markerSettings: const MarkerSettings(isVisible: true),
                        )
                      ],
                    )
                  : null,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: vj == 1 ? MediaQuery.of(context).size.height * 0.6 : null,
              child: vj == 1
                  ? SfCartesianChart(
                      backgroundColor: Colors.white,
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                        minimum: maxVerticalJump == 0
                            ? -1
                            : minVerticalJump.toDouble(),
                        maximum: maxVerticalJump == 0
                            ? 1
                            : maxVerticalJump.toDouble(),
                        interval: maxVerticalJump > 499
                            ? 100
                            : maxVerticalJump > 399
                                ? 80
                                : maxVerticalJump > 299
                                    ? 60
                                    : maxVerticalJump > 199
                                        ? 40
                                        : maxVerticalJump > 99
                                            ? 20
                                            : maxVerticalJump > 49
                                                ? 10
                                                : maxVerticalJump > 19
                                                    ? 4
                                                    : maxVerticalJump > 9
                                                        ? 2
                                                        : 0.2,
                      ),
                      title: ChartTitle(text: 'Vertical Jump'),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries>[
                        SplineSeries<_SalesData, String>(
                          name: 'Vertical Jump',
                          color: HexColor("#30CED9"),
                          dataSource: verticalJump,
                          xValueMapper: (_SalesData weight, _) => weight.year,
                          yValueMapper: (_SalesData weight, _) => weight.weight,
                          markerSettings: const MarkerSettings(isVisible: true),
                        )
                      ],
                    )
                  : null,
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.weight);

  final String year;
  final int weight;
}
