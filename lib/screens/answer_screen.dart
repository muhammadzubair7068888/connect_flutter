import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../Globals/globals.dart';
import 'BottomNavBar/bottomNavBar_screen.dart';

class Answer extends StatefulWidget {
  final String role;
  const Answer({
    Key? key,
    required this.role,
  }) : super(key: key);

  @override
  State<Answer> createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  final storage = const FlutterSecureStorage();
  final GlobalKey<FormState> _form = GlobalKey();
  List data = [];
  List<Widget> children = <Widget>[];
  List<String> answers = [];
  List<String> qDs = [];

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

  Future getQs() async {
    await EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    var url = Uri.parse('${apiURL}questionnaire/user');
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
        setState(
          () {
            data = jsonData["data"];
          },
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

  Future savePressed() async {
    await EasyLoading.show(
      status: 'Processing...',
      maskType: EasyLoadingMaskType.black,
    );
    var url = Uri.parse('${apiURL}questionnaire/answer/save');
    String? token = await storage.read(key: "token");
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest(
      'POST',
      url,
    )..headers.addAll(headers);
    for (String item in answers) {
      request.files.add(http.MultipartFile.fromString('answer[]', item));
    }
    for (String item in qDs) {
      request.files.add(http.MultipartFile.fromString('question_id[]', item));
    }
    var response = await request.send();
    // var responseDecode = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      await EasyLoading.dismiss();
      answers.clear();
      qDs.clear();
      _navigate();
    } else {
      // final result = jsonDecode(responseDecode.body);
      // print(result);
      await EasyLoading.dismiss();
      answers.clear();
      qDs.clear();
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
    getQs();
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
          "Answer",
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Form(
            key: _form,
            child: Column(
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: () {
                      children.clear();
                      answers.clear();
                      qDs.clear();
                      for (var i = 0; i < data.length; i++) {
                        children.add(
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30),
                              Text(
                                "${data[i]["name"]}",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
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
                                    return "Required";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  answers.add(value!);
                                  qDs.add((data[i]["parent_id"]).toString());
                                },
                              ),
                            ],
                          ),
                        );
                      }
                      return children;
                    }()),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: data.isEmpty
                      ? const Text(
                          "There are no question's to answer",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        )
                      : ElevatedButton(
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
                            savePressed();
                            // answers.clear();
                            // qDs.clear();
                          },
                          child: const Text("Save Answer"),
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
