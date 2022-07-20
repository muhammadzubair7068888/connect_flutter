import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../Globals/globals.dart';

class ViewExerciseScreen extends StatefulWidget {
  final int id;
  final String title;
  final String description;
  const ViewExerciseScreen({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  State<ViewExerciseScreen> createState() => _ViewExerciseScreenState();
}

class _ViewExerciseScreenState extends State<ViewExerciseScreen> {
  final storage = const FlutterSecureStorage();
  final rowsAdd = <Widget>[];

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
            rowsAdd.add(
              Column(
                children: [
                  const Divider(
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Link: ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        jsonData['data'][i]['title'],
                        // This is link which is to be redirected from app and apply validation also on adding it.
                        // jsonData['data']['link'],
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Notes: ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Text(
                          jsonData['data'][i]['notes'],
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Sets: ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        jsonData['data'][i]['sets'],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Reps: ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        jsonData['data'][i]['reps'],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
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

  @override
  void initState() {
    super.initState();
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
          "View",
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
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Day Plan",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text(
                    "Title: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.title,
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text(
                    "Description: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.description,
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Wrap(
                runSpacing: 20,
                children: rowsAdd,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
