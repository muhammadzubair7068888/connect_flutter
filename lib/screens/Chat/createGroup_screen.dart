import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiselect/multiselect.dart';
import 'package:http/http.dart' as http;
import '../../Globals/globals.dart';
import 'chatList_screen.dart';

class CreateGroupScreen extends StatefulWidget {
  final String? urC;
  final String currentName;
  final String imgUrl;
  final String role;
  final int? index;
  final String? i;
  final String? u;
  final String? token;
  final String? id;
  const CreateGroupScreen({
    Key? key,
    required this.urC,
    required this.currentName,
    required this.imgUrl,
    required this.role,
    required this.index,
    required this.i,
    required this.u,
    required this.token,
    required this.id,
  }) : super(key: key);

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final storage = const FlutterSecureStorage();
  final GlobalKey<FormState> _form = GlobalKey();
  final picker = ImagePicker();
  File? _image;
  Future choiceImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (mounted) {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
        setState(() {});
      } else {}
    }
  }

  String gName = "";
  String gDesc = "";
  String type = "1";
  String privacy = "1";
  var ids = [];
  bool load = false;

  void _navigate() {
    Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => ChatListScreen(
          id: widget.id,
          token: widget.token,
          currentName: widget.currentName,
          urC: widget.urC,
          i: widget.i,
          index: widget.index,
          role: widget.role,
          u: widget.u,
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
    var uri = Uri.parse('${apiURL}groups');
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
    request.fields['id'] = "";
    request.fields['name'] = gName;
    request.fields['group_type'] = type;
    request.fields['privacy'] = privacy;
    request.fields['description'] = gDesc;
    for (int item in ids) {
      request.files
          .add(http.MultipartFile.fromString('users[]', item.toString()));
    }
    var response = await request.send();
    var responseDecode = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      // final result = jsonDecode(responseDecode.body);
      // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: HexColor("#30CED9"),
            dismissDirection: DismissDirection.vertical,
            content: const Text('Created successfully'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
      await EasyLoading.dismiss();
      _navigate();
    } else {
      await EasyLoading.dismiss();
      final result = jsonDecode(responseDecode.body);
      print(result);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: load
          ? Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                const Center(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Group Icon : ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: _image != null
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
                                    const CircleAvatar(
                                      radius: 60.0,
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
                      ],
                    ),
                    Form(
                      key: _form,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Group Name",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: 'Group Name',
                            ),
                            validator: (value) {
                              if (value == null || value == "") {
                                return "required*";
                              }

                              return null;
                            },
                            onChanged: (value) {
                              gName = value;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Description",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            maxLines: 5,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value == "") {
                                return "required*";
                              }

                              return null;
                            },
                            onChanged: (value) {
                              gDesc = value;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Group Type : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Row(
                                children: [
                                  RadioButton(
                                    description: "Open",
                                    value: "1",
                                    groupValue: type,
                                    onChanged: (value) => setState(
                                      () => type = value.toString(),
                                    ),
                                    textPosition: RadioButtonTextPosition.right,
                                  ),
                                  RadioButton(
                                    description: "Close",
                                    value: "0",
                                    groupValue: type,
                                    onChanged: (value) => setState(
                                      () => type = value.toString(),
                                    ),
                                    textPosition: RadioButtonTextPosition.right,
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Privacy : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Row(
                                children: [
                                  RadioButton(
                                    description: "Open",
                                    value: "1",
                                    groupValue: privacy,
                                    onChanged: (value) => setState(
                                      () => privacy = value.toString(),
                                    ),
                                    textPosition: RadioButtonTextPosition.right,
                                  ),
                                  RadioButton(
                                    description: "Close",
                                    value: "0",
                                    groupValue: privacy,
                                    onChanged: (value) => setState(
                                      () => privacy = value.toString(),
                                    ),
                                    textPosition: RadioButtonTextPosition.right,
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DropdownSearch<UserModel>.multiSelection(
                            onChanged: (value) {
                              for (var i = 0; i < value.length; i++) {
                                ids.add(value[i].id);
                              }
                            },
                            validator: (value) {
                              if (value == null || value == []) {
                                return "required*";
                              }

                              return null;
                            },
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                                    dropdownSearchDecoration:
                                        InputDecoration(labelText: "Search")),
                            asyncItems: (String? filter) => getData(filter),
                            popupProps:
                                PopupPropsMultiSelection.modalBottomSheet(
                              showSelectedItems: true,
                              itemBuilder: _customPopupItemBuilderExample2,
                              showSearchBox: true,
                            ),
                            compareFn: (item, sItem) => item.id == sItem.id,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: SizedBox(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(50),
                                  primary: HexColor("#30CED9"),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                                onPressed: () {
                                  if (!(_form.currentState?.validate() ??
                                      true)) {
                                    return;
                                  }
                                  submit();
                                },
                                child: const Text(
                                  "Save",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _customPopupItemBuilderExample2(
    BuildContext context,
    UserModel? item,
    bool isSelected,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        tileColor: HexColor("#30CED9"),
        selected: isSelected,
        title: Text(item?.name ?? ''),
        subtitle: Text(item?.id.toString() ?? ''),
        leading: item!.avatar != null
            ? CircleAvatar(
                radius: 60.0,
                backgroundColor: Colors.grey,
                child: ClipOval(
                  child: Image.network(
                    "http://192.168.1.30/connect_laravel/public/assets/chat/images/group-img.png",
                    width: 60,
                    height: 60,
                    fit: BoxFit.fill,
                  ),
                ),
              )
            : const CircleAvatar(
                radius: 60.0,
                backgroundColor: Colors.grey,
              ),
      ),
    );
  }

  Future<List<UserModel>> getData(filter) async {
    String? token = await storage.read(key: "token");
    var response = await Dio().get(
      "${apiURL}users-list",
      queryParameters: {"filter": filter},
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    final data = response.data["data"]["users"];
    if (data != null) {
      return UserModel.fromJsonList(data);
    }

    return [];
  }
}

class UserModel {
  final int id;
  final String name;
  final String? avatar;

  UserModel({required this.id, required this.name, this.avatar});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      avatar: json["avatar"],
    );
  }

  static List<UserModel> fromJsonList(List list) {
    return list.map((item) => UserModel.fromJson(item)).toList();
  }

  String userAsString() {
    return '#$id $name';
  }

  bool isEqual(UserModel model) {
    return id == model.id;
  }

  @override
  String toString() => name;
}
