import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  final String school;
  final String lvl;
  const ProfileScreen({
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
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

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
              )
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

// --                                                               -- //
// --                          START                                -- //
// --                                                               -- //
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
          .add(await http.MultipartFile.fromPath('file', _image!.path));
    }
    request.fields['height'] = widget.height;
    request.fields['level'] = widget.lvl;
    request.fields['starting_weight'] = widget.strWeight;
    request.fields['age'] = widget.age.toString();
    request.fields['handedeness'] = widget.handedness;
    request.fields['school'] = widget.school;
    request.fields['email'] = widget.email;
    request.fields['name'] = widget.name;
    var response = await request.send();
    var responseDecode = await http.Response.fromStream(response);
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
