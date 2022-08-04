import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:http/http.dart' as http;
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import '../../Globals/globals.dart';
import '../BottomNavBar/bottomNavBar_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String role;
  final String? imgUrl;
  final String name;
  final String height;
  final String email;
  final String strWeight;
  final String handedness;
  final int age;
  final int id;
  final String school;
  final String lvl;
  const ProfileScreen({
    Key? key,
    required this.id,
    required this.role,
    required this.imgUrl,
    required this.name,
    required this.height,
    required this.email,
    required this.strWeight,
    required this.handedness,
    required this.age,
    required this.school,
    required this.lvl,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final storage = const FlutterSecureStorage();
  List<DataRow> rowsAdd = [];
  List<DataRow> rowsAddQ = [];
  List<DataRow> rowsAddM = [];
  List data = [];
  List dataM = [];
  List<int> groupValue = [];
  List<int> groupValueM = [];

  Future getPhyAsses() async {
    await EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    var url = Uri.parse('${apiURL}users/view/${widget.id}');
    String? token = await storage.read(key: "token");
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var jsonBody = response.body;
      var jsonData = jsonDecode(jsonBody);
      // print(jsonData);
      if (mounted) {
        setState(() {
          rowsAddQ = [];
          data = jsonData["data"]["physical_assessment"];
          dataM = jsonData["data"]["mechanical_assessment"];
          for (var i = 0; i < jsonData['data']["question"].length; i++) {
            rowsAddQ.add(
              DataRow(
                cells: [
                  DataCell(
                    Wrap(
                      children: [
                        Text(jsonData['data']["question"][i]["name"]),
                      ],
                    ),
                  ),
                  DataCell(
                    Wrap(
                      children: const [
                        Text(""),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        });
        await EasyLoading.dismiss();
      }
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
    return Scaffold(
      backgroundColor: HexColor("#FFFFFF"),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              formFielf(
                formKey: _formKey,
                age: widget.age,
                email: widget.email,
                height: widget.height,
                handedness: widget.handedness,
                imgUrl: widget.imgUrl,
                lvl: widget.lvl,
                name: widget.name,
                school: widget.school,
                strWeight: widget.strWeight,
                role: widget.role,
              ),
              SingleChildScrollView(
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
                            label: Text("L"),
                          ),
                          DataColumn(
                            label: Text("R"),
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
                                      onChanged: (value) => {
                                        // setState(
                                        //   () {
                                        //     groupValue[i] = 1;
                                        //   },
                                        // ),
                                        // updatePhyAss(data[i]["id"], 1),
                                      },
                                      textPosition:
                                          RadioButtonTextPosition.right,
                                    ),
                                  ),
                                  DataCell(
                                    RadioButton(
                                      description: "",
                                      value: 2,
                                      groupValue: groupValue[i],
                                      onChanged: (value) => {
                                        // setState(
                                        //   () => groupValue[i] = 2,
                                        // ),
                                        // updatePhyAss(data[i]["id"], 2),
                                      },
                                      textPosition:
                                          RadioButtonTextPosition.right,
                                    ),
                                  ),
                                  DataCell(
                                    RadioButton(
                                      description: "",
                                      value: 3,
                                      groupValue: groupValue[i],
                                      onChanged: (value) => {
                                        // setState(
                                        //   () => groupValue[i] = 3,
                                        // ),
                                        // updatePhyAss(data[i]["id"], 3),
                                      },
                                      textPosition:
                                          RadioButtonTextPosition.right,
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: 70,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 0, 5),
                                        child: TextFormField(
                                          enabled: false,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.only(left: 10),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                            ),
                                          ),
                                          initialValue: data[i]["left"],
                                          onChanged: (value) {
                                            // data[i]["left"] = value;
                                            // updateHandsL(
                                            //   data[i]["id"],
                                            //   data[i]["left"],
                                            // );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: 70,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 0, 5),
                                        child: TextFormField(
                                          enabled: false,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.only(left: 10),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                            ),
                                          ),
                                          initialValue: data[i]["right"],
                                          onChanged: (value) {
                                            // data[i]["right"] = value;
                                            // updateHandsR(
                                            //   data[i]["id"],
                                            //   data[i]["right"],
                                            // );
                                          },
                                        ),
                                      ),
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
              ),
              SingleChildScrollView(
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
                            label: Text("L"),
                          ),
                          DataColumn(
                            label: Text("R"),
                          ),
                        ],
                        rows: () {
                          rowsAddM.clear();
                          for (var i = 0; i < dataM.length; i++) {
                            String name = dataM[i]["name"];
                            int val = int.parse(dataM[i]["status"]);
                            groupValueM.add(val);
                            rowsAddM.add(
                              DataRow(
                                cells: [
                                  DataCell(Text(name)),
                                  DataCell(
                                    RadioButton(
                                      description: "",
                                      value: 1,
                                      groupValue: groupValueM[i],
                                      onChanged: (value) => {
                                        // setState(
                                        //   () {
                                        //     groupValueM[i] = 1;
                                        //   },
                                        // ),
                                        // updateMechAss(dataM[i]["id"], 1),
                                      },
                                      textPosition:
                                          RadioButtonTextPosition.right,
                                    ),
                                  ),
                                  DataCell(
                                    RadioButton(
                                      description: "",
                                      value: 2,
                                      groupValue: groupValueM[i],
                                      onChanged: (value) => {
                                        // setState(
                                        //   () => groupValueM[i] = 2,
                                        // ),
                                        // updateMechAss(dataM[i]["id"], 2),
                                      },
                                      textPosition:
                                          RadioButtonTextPosition.right,
                                    ),
                                  ),
                                  DataCell(
                                    RadioButton(
                                      description: "",
                                      value: 3,
                                      groupValue: groupValueM[i],
                                      onChanged: (value) => {
                                        // setState(
                                        //   () => groupValueM[i] = 3,
                                        // ),
                                        // updateMechAss(dataM[i]["id"], 3),
                                      },
                                      textPosition:
                                          RadioButtonTextPosition.right,
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: 70,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 0, 5),
                                        child: TextFormField(
                                          enabled: false,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.only(left: 10),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                            ),
                                          ),
                                          initialValue: dataM[i]["left"],
                                          onChanged: (value) {
                                            // dataM[i]["left"] = value;
                                            // updateHandsML(
                                            //   dataM[i]["id"],
                                            //   dataM[i]["left"],
                                            // );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: 70,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 0, 5),
                                        child: TextFormField(
                                          enabled: false,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.only(left: 10),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                            ),
                                          ),
                                          initialValue: dataM[i]["right"],
                                          onChanged: (value) {
                                            // dataM[i]["right"] = value;
                                            // updateHandsMR(
                                            //   dataM[i]["id"],
                                            //   dataM[i]["right"],
                                            // );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return rowsAddM;
                        }(),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types, must_be_immutable
class formFielf extends StatefulWidget {
  final String role;
  final String? imgUrl;
  String name;
  String height;
  String email;
  String strWeight;
  String handedness;
  int age;
  String school;
  String lvl;
  formFielf({
    Key? key,
    required this.role,
    required this.imgUrl,
    required this.name,
    required this.height,
    required this.email,
    required this.strWeight,
    required this.handedness,
    required this.age,
    required this.school,
    required this.lvl,
    required GlobalKey<FormState> formKey,
  }) : super(key: key);

  @override
  State<formFielf> createState() => _formFielfState();
}

// ignore: camel_case_types
class _formFielfState extends State<formFielf> {
  final storage = const FlutterSecureStorage();
  File? _image;
  final picker = ImagePicker();
  Future choiceImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (mounted) {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        setState(() {});
      } else {}
    }
  }

// --                                                               -- //
// --                          START                                -- //
// --                                                               -- //
  void _navigate() {
    Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => BottomNavBar(
          role: widget.role,
          index: null,
          i: '',
          u: '',
        ),
      ),
      (route) => false,
    );
  }

  Future submit() async {
    await EasyLoading.show(
      status: 'Processing...',
      maskType: EasyLoadingMaskType.black,
    );
    String? id = await storage.read(key: "id");
    var uri = Uri.parse('${apiURL}profile/update/$id');
    String? token = await storage.read(key: "token");
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest(
      'POST',
      uri,
    )..headers.addAll(headers);
    if (_image != null) {
      request.files
          .add(await http.MultipartFile.fromPath('photo', _image!.path));
    }
    request.fields['height'] = widget.height;
    request.fields['level'] = widget.lvl;
    request.fields['starting_weight'] = widget.strWeight;
    request.fields['age'] = widget.age.toString();
    request.fields['hand_type'] = widget.handedness;
    request.fields['school'] = widget.school;
    request.fields['email'] = widget.email;
    request.fields['name'] = widget.name;
    request.fields['user_status'] = "1";
    var response = await request.send();
    // var responseDecode = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      // final result = jsonDecode(responseDecode.body);
      // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;
      _navigate();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: HexColor("#30CED9"),
            dismissDirection: DismissDirection.vertical,
            content: const Text('Updated successfully'),
            duration: const Duration(seconds: 2),
          ),
        );
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: _image == null && widget.imgUrl == null
                  ? <Widget>[
                      CircleAvatar(
                        radius: 60.0,
                        backgroundColor: Colors.grey[300],
                      ),
                      SizedBox(
                          child:
                              //  btnPress
                              // ?
                              CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white70,
                        child: IconButton(
                          onPressed: () {
                            choiceImage();
                          },
                          icon: Icon(
                            Icons.photo_camera,
                            color: HexColor("#30CED9"),
                          ),
                        ),
                      )
                          // : null,
                          ),
                    ]
                  : _image != null && widget.imgUrl == null
                      ? <Widget>[
                          CircleAvatar(
                            radius: 60.0,
                            child: ClipOval(
                              child: Image.file(
                                File(_image!.path).absolute,
                                fit: BoxFit.cover,
                                width: 120.0,
                                height: 120.0,
                              ),
                            ),
                          ),
                          SizedBox(
                              child:
                                  // btnPress
                                  // ?
                                  CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white70,
                            child: IconButton(
                              onPressed: () {
                                choiceImage();
                              },
                              icon: Icon(
                                Icons.photo_camera,
                                color: HexColor("#30CED9"),
                              ),
                            ),
                          )
                              // : null,
                              ),
                        ]
                      : _image != null && widget.imgUrl != null
                          ? <Widget>[
                              CircleAvatar(
                                radius: 60.0,
                                child: ClipOval(
                                  child: Image.file(
                                    File(_image!.path).absolute,
                                    fit: BoxFit.cover,
                                    width: 120.0,
                                    height: 120.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  child:
                                      // btnPress
                                      // ?
                                      CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.white70,
                                child: IconButton(
                                  onPressed: () {
                                    choiceImage();
                                  },
                                  icon: Icon(
                                    Icons.photo_camera,
                                    color: HexColor("#30CED9"),
                                  ),
                                ),
                              )
                                  // : null,
                                  ),
                            ]
                          : <Widget>[
                              CircleAvatar(
                                radius: 60.0,
                                child: ClipOval(
                                  child: Image.network(
                                    '${widget.imgUrl}',
                                    width: 120.0,
                                    height: 120.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  child:
                                      //  btnPress
                                      // ?
                                      CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.white70,
                                child: IconButton(
                                  onPressed: () {
                                    choiceImage();
                                  },
                                  icon: Icon(
                                    Icons.photo_camera,
                                    color: HexColor("#30CED9"),
                                  ),
                                ),
                              )
                                  // : null,
                                  ),
                            ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: SizedBox(
                  width: 120,
                  child: TextField(
                    // enabled: btnPress,
                    controller: TextEditingController()
                      ..text = widget.name.toString(),
                    onChanged: (value) {
                      widget.name = value;
                    },
                    autofocus: false,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 120,
                child: TextField(
                  keyboardType: TextInputType.number,
                  // enabled: btnPress,
                  controller: TextEditingController()
                    ..text = widget.height.toString(),
                  onChanged: (value) {
                    widget.height = value;
                  },
                  decoration: InputDecoration(
                    labelText: "Height",
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextField(
              // enabled: btnPress,
              controller: TextEditingController()
                ..text = widget.email.toString(),
              onChanged: (value) {
                widget.email = value;
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Email",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 140,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    // enabled: btnPress,
                    controller: TextEditingController()
                      ..text = widget.strWeight.toString(),
                    onChanged: (value) {
                      widget.strWeight = value;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Starting Weight",
                    ),
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: TextField(
                    // enabled: btnPress,
                    controller: TextEditingController()
                      ..text = widget.handedness.toString(),
                    onChanged: (value) {
                      widget.handedness = value;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Handedness",
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 140,
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Age",
                    ),
                    keyboardType: TextInputType.number,
                    // enabled: btnPress,
                    controller: TextEditingController()
                      ..text = widget.age.toString(),
                    onChanged: (value) {
                      widget.age = value as int;
                    },
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: TextField(
                    // enabled: btnPress,
                    controller: TextEditingController()
                      ..text = widget.school.toString(),
                    onChanged: (value) {
                      widget.school = value;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "School",
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Level",
              ),
              keyboardType: TextInputType.number,
              // enabled: btnPress,
              controller: TextEditingController()..text = widget.lvl.toString(),
              onChanged: (value) {
                widget.lvl = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
            child: SizedBox(
              width: 180,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed:
                      // btnPress
                      // ?
                      () {
                    // setState(() {
                    //   btnPress = !btnPress;
                    // });
                    submit();
                  },
                  // : () {
                  // setState(() {
                  // btnPress = !btnPress;
                  // });
                  // },
                  child:
                      // btnPress
                      // ?
                      const Text("Update")
                  // const Text("Submit")
                  // : const Text("Edit Profile"),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
