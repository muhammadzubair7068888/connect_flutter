import 'dart:convert';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../Globals/globals.dart';
import 'user_screen.dart';

class AddUser extends StatefulWidget {
  final String role;
  const AddUser({
    Key? key,
    required this.role,
  }) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final storage = const FlutterSecureStorage();
  final GlobalKey<FormState> _form = GlobalKey();
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

  String name = "";
  String email = "";
  String password = "";
  bool _isObscureP = true;
  String cPassword = "";
  bool _isObscureCp = true;
  String height = "";
  String startingWeight = "";
  String handedness = "";
  String age = "";
  String school = "";
  String level = "";
  int groupvalue = 1;
  setGroupValue(int val) {
    setState(() {
      groupvalue = val;
    });
  }

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

// --                                                               -- //
// --                          START                                -- //
// --                                                               -- //
  Future addUser() async {
    await EasyLoading.show(
      status: 'Processing...',
      maskType: EasyLoadingMaskType.black,
    );
    var uri = Uri.parse('${apiURL}users/add');
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
    request.fields['name'] = name;
    request.fields['email'] = email;
    request.fields['height'] = height;
    request.fields['starting_weight'] = startingWeight;
    request.fields['hand_type'] = handedness;
    request.fields['age'] = age;
    request.fields['school'] = school;
    request.fields['level'] = level;
    request.fields['password'] = password;
    request.fields['password_confirmation'] = cPassword;
    request.fields['user_status'] = groupvalue.toString();

    var response = await request.send();
    var responseDecode = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;
      // final result = jsonDecode(responseDecode.body);
      FocusManager.instance.primaryFocus?.unfocus();
      _navigate();
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
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Add New User",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  // ignore: unnecessary_null_comparison
                  children: _image == null
                      ? <Widget>[
                          CircleAvatar(
                            radius: 60.0,
                            backgroundColor: Colors.grey[300],
                          ),
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
                          ),
                        ]
                      : <Widget>[
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
                          ),
                        ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: _form,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            autofocus: false,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              labelText: 'Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value == "") {
                                return "Please enter Name";
                              }

                              return null;
                            },
                            onChanged: (value) {
                              name = value;
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Email",
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value == "") {
                                return "Please enter Email";
                              }

                              return null;
                            },
                            onChanged: (value) {
                              email = value;
                            },
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
                            obscureText: _isObscureP,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: 'Password',
                              // prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscureP
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscureP = !_isObscureP;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value == "") {
                                return "Please enter Password";
                              }

                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            obscureText: _isObscureCp,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: 'Confirm Password',
                              // prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscureCp
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscureCp = !_isObscureCp;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value == "") {
                                return "Please Confirm Password";
                              }

                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                cPassword = value;
                              });
                            },
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
                            keyboardType: TextInputType.number,
                            autofocus: false,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              labelText: 'Height',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value == "") {
                                return "Please enter Height";
                              }

                              return null;
                            },
                            onChanged: (value) {
                              height = value;
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Starting Weight",
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value == "") {
                                return "Please enter Starting Weight";
                              }

                              return null;
                            },
                            onChanged: (value) {
                              startingWeight = value;
                            },
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
                              handedness = value!;
                            },
                            // selectedItem: "Right",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Age",
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value == "") {
                                return "Please enter Age";
                              }

                              return null;
                            },
                            onChanged: (value) {
                              age = value;
                            },
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
                            autofocus: false,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              labelText: 'School',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value == "") {
                                return "Please enter School";
                              }

                              return null;
                            },
                            onChanged: (value) {
                              school = value;
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Level",
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value == "") {
                                return "Please enter Level";
                              }

                              return null;
                            },
                            onChanged: (value) {
                              level = value;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "User Status",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
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
                      groupValue: groupvalue,
                      onChanged: (int? val) {
                        setGroupValue(val!);
                      },
                    ),
                    const Text(
                      "Active",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
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
                        groupValue: groupvalue,
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
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      if (!(_form.currentState?.validate() ?? true)) {
                        return;
                      }
                      addUser();
                    },
                    child: const Text("Submit"),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
