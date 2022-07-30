// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:connect/screens/UserScreens/user_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import '../../Globals/globals.dart';

class EditUserScreen extends StatefulWidget {
  final String? imgUrl;
  String name;
  final String role;
  String height;
  String email;
  String strWeight;
  String handedness;
  int age;
  int status;
  int id;
  String school;
  String lvl;
  EditUserScreen({
    Key? key,
    required this.imgUrl,
    required this.name,
    required this.status,
    required this.role,
    required this.id,
    required this.height,
    required this.email,
    required this.strWeight,
    required this.handedness,
    required this.age,
    required this.school,
    required this.lvl,
  }) : super(key: key);

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final storage = const FlutterSecureStorage();
  final GlobalKey<FormState> _form = GlobalKey();
  File? _image;
  setGroupValue(int val) {
    setState(() {
      widget.status = val;
    });
  }

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
        builder: (BuildContext context) => UserDetail(
          role: widget.role,
          removed: true,
        ),
      ),
      (route) => false,
    );
  }

  Future updateUser() async {
    var uri = Uri.parse('${apiURL}users/update/${widget.id}');
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
    request.fields['name'] = widget.name;
    request.fields['email'] = widget.email;
    request.fields['height'] = widget.height;
    request.fields['starting_weight'] = widget.strWeight;
    request.fields['hand_type'] = widget.handedness;
    request.fields['age'] = widget.age.toString();
    request.fields['school'] = widget.school;
    request.fields['level'] = widget.lvl;
    request.fields['user_status'] = widget.status.toString();
    var response = await request.send();
    // var responseDecode = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      // final result = jsonDecode(responseDecode.body);
      // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;
      FocusManager.instance.primaryFocus?.unfocus();
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
    } else {
      // await EasyLoading.dismiss();
      FocusManager.instance.primaryFocus?.unfocus();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
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
                                            // '$publicUrl${widget.imgUrl}',
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: TextEditingController()
                              ..text = widget.name.toString(),
                            validator: (value) {
                              if (value == null || value == "") {
                                return "Please enter name";
                              }

                              return null;
                            },
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: TextEditingController()
                              ..text = widget.height.toString(),
                            validator: (value) {
                              if (value == null || value == "") {
                                return "Please enter height";
                              }

                              return null;
                            },
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
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: TextEditingController()
                        ..text = widget.email.toString(),
                      validator: (value) {
                        if (value == null || value == "") {
                          return "Please enter email";
                        }

                        return null;
                      },
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: TextEditingController()
                              ..text = widget.strWeight.toString(),
                            validator: (value) {
                              if (value == null || value == "") {
                                return "Please enter starting weight";
                              }

                              return null;
                            },
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
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: DropdownSearch<String>(
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintStyle: const TextStyle(color: Colors.black),
                                errorStyle:
                                    const TextStyle(color: Colors.redAccent),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                suffixIcon:
                                    const Icon(Icons.arrow_drop_down_sharp),
                                contentPadding: const EdgeInsets.all(10),
                                labelText: 'Handedness',
                              ),
                            ),
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                              // disabledItemFn: (String s) => s.startsWith('I'),
                            ),
                            items: const [
                              "Left",
                              "Right",
                            ],
                            validator: (value) {
                              if (value == null || value == "") {
                                return "Please select Handedness";
                              }

                              return null;
                            },
                            onChanged: (value) {
                              widget.handedness = value!;
                            },
                            // selectedItem: "Right",
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: "Age",
                            ),
                            keyboardType: TextInputType.number,
                            controller: TextEditingController()
                              ..text = widget.age.toString(),
                            validator: (value) {
                              if (value == null || value == "") {
                                return "Please enter age";
                              }

                              return null;
                            },
                            onChanged: (value) {
                              widget.age = int.parse(value);
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: TextEditingController()
                              ..text = widget.school.toString(),
                            validator: (value) {
                              if (value == null || value == "") {
                                return "Please enter school";
                              }

                              return null;
                            },
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
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Level",
                      ),
                      keyboardType: TextInputType.number,
                      controller: TextEditingController()
                        ..text = widget.lvl.toString(),
                      validator: (value) {
                        if (value == null || value == "") {
                          return "Please enter level";
                        }

                        return null;
                      },
                      onChanged: (value) {
                        widget.lvl = value;
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "User Status",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Radio(
                            activeColor: HexColor("#30CED9"),
                            value: 1,
                            groupValue: widget.status,
                            onChanged: (int? val) {
                              setGroupValue(val!);
                            },
                          ),
                          const Text(
                            "Active",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Radio(
                              activeColor: HexColor("#30CED9"),
                              value: 0,
                              groupValue: widget.status,
                              onChanged: (int? val) {
                                setGroupValue(val!);
                              },
                            ),
                            const Text(
                              "Banned",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 20),
                    child: SizedBox(
                      width: 180,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () {
                            if (!(_form.currentState?.validate() ?? true)) {
                              return;
                            }
                            updateUser();
                          },
                          child: const Text("Update")),
                    ),
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
