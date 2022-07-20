import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../../Globals/globals.dart';

class EditExercise extends StatefulWidget {
  final int id;
  late String title;
  late String description;
  late String type;
  EditExercise({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
    required this.type,
  }) : super(key: key);

  @override
  State<EditExercise> createState() => _EditExerciseState();
}

class _EditExerciseState extends State<EditExercise> {
  final GlobalKey<FormState> _form = GlobalKey();
  final storage = const FlutterSecureStorage();
  String name = "";
  String desc = "";
  String type = "";
  var items = [];
  List<String> title = [];
  List<String> link = [];
  List<String> sets = [];
  List<String> reps = [];
  List<String> notes = [];
  bool visible = false;
  final rows = <Widget>[];

  // void _resetForm() {
  //   _form.currentState?.reset();
  // }

  final _details = <Widget>[];

  void _addCardWidget() {
    setState(() {
      visible = true;
      _details.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      labelText: 'Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please enter title";
                      }

                      return null;
                    },
                    onSaved: (value) {
                      title.add(value!);
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Link",
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please enter link";
                      }

                      return null;
                    },
                    onSaved: (value) {
                      link.add(value!);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      hintText: 'Sets',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please enter sets";
                      }

                      return null;
                    },
                    onSaved: (value) {
                      sets.add(value!);
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Reps",
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please enter reps";
                      }

                      return null;
                    },
                    onSaved: (value) {
                      reps.add(value!);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Notes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
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
                  return "Please enter notes";
                }

                return null;
              },
              onSaved: (value) {
                notes.add(value!);
              },
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _details.removeLast();
                });
              },
              icon: Icon(
                Icons.delete,
                color: HexColor("#30CED9"),
                size: 30,
              ),
            ),
          ],
        ),
      );
    });
  }

// --                                                               -- //
// --                          START                                -- //
// --                                                               -- //

  Future getExDetail() async {
    await EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    var url = Uri.parse('${apiURL}exercises/detail/${widget.id}');
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
          for (var i = 0; i < jsonData['data'].length; i++) {
            rows.add(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            labelText: 'Title',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          initialValue: jsonData['data'][i]['title'],
                          validator: (value) {
                            if (value == null || value == "") {
                              return "Please enter title";
                            }

                            return null;
                          },
                          onSaved: (value) {
                            title.add(value!);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Link",
                            contentPadding: const EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          initialValue: jsonData['data'][i]['link'],
                          validator: (value) {
                            if (value == null || value == "") {
                              return "Please enter link";
                            }

                            return null;
                          },
                          onSaved: (value) {
                            link.add(value!);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            hintText: 'Sets',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          initialValue: jsonData['data'][i]['sets'],
                          validator: (value) {
                            if (value == null || value == "") {
                              return "Please enter sets";
                            }

                            return null;
                          },
                          onSaved: (value) {
                            sets.add(value!);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Reps",
                            contentPadding: const EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          initialValue: jsonData['data'][i]['reps'],
                          validator: (value) {
                            if (value == null || value == "") {
                              return "Please enter reps";
                            }

                            return null;
                          },
                          onSaved: (value) {
                            reps.add(value!);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Notes",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    initialValue: jsonData['data'][i]['notes'],
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please enter notes";
                      }

                      return null;
                    },
                    onSaved: (value) {
                      notes.add(value!);
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

  Future getTypes() async {
    var url = Uri.parse('${apiURL}exercises/types');
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
          items = jsonData['data'];
        });
      }
    } else {
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

  Future update() async {
    FocusManager.instance.primaryFocus?.unfocus();
    await EasyLoading.show(
      status: 'Processing...',
      maskType: EasyLoadingMaskType.black,
    );
    var uri = Uri.parse("${apiURL}exercises/edit/${widget.id}");
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

    request.fields['name'] = name;
    request.fields['description'] = desc;
    request.fields['ex_type'] = type;
    for (String item in title) {
      request.files.add(http.MultipartFile.fromString('title[]', item));
    }
    for (String item in link) {
      request.files.add(http.MultipartFile.fromString('link[]', item));
    }
    for (String item in sets) {
      request.files.add(http.MultipartFile.fromString('sets[]', item));
    }
    for (String item in reps) {
      request.files.add(http.MultipartFile.fromString('reps[]', item));
    }
    for (String item in notes) {
      request.files.add(http.MultipartFile.fromString('notes[]', item));
    }
    var response = await request.send();
    var responseDecode = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      await EasyLoading.dismiss();
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
      // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;
      final result = jsonDecode(responseDecode.body);
      print(result);
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
    name = widget.title;
    desc = widget.description;
    type = widget.type;
    getTypes();
    getExDetail();
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
        centerTitle: true,
        title: const Text(
          "Exercises",
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
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add New Exercises",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        initialValue: name,
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Please enter name";
                          }

                          return null;
                        },
                        onChanged: (value) {
                          name = value;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Description",
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        initialValue: desc,
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Please enter description";
                          }

                          return null;
                        },
                        onChanged: (value) {
                          desc = value;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
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
                        contentPadding: EdgeInsets.all(10),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                        labelText: 'Type',
                      ),
                    ),
                    popupProps: const PopupProps.menu(
                      showSelectedItems: true,
                      // disabledItemFn: (String s) => s.startsWith('I'),
                    ),
                    items: (items).map((e) => e["name"] as String).toList(),
                    selectedItem: type,
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please select type";
                      }

                      return null;
                    },
                    onChanged: (value) {
                      type = value!;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      "Details",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                      onPressed: () {
                        _addCardWidget();
                      },
                      icon: Icon(
                        Icons.add,
                        color: HexColor("#30CED9"),
                        size: 30,
                      ),
                    )
                  ],
                ),
                Wrap(
                  runSpacing: 20,
                  children: rows,
                ),
                Column(
                  children: _details,
                ),
                // Visibility(
                //   visible: visible,
                //   child: IconButton(
                //     onPressed: () {
                //       setState(() {
                //         _details.removeLast();
                //       });
                //     },
                //     icon: Icon(
                //       Icons.delete,
                //       color: HexColor("#30CED9"),
                //       size: 30,
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (!(_form.currentState?.validate() ?? true)) {
                        return;
                      }
                      _form.currentState!.save();
                      update();
                    },
                    child: const Text("Submit"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
