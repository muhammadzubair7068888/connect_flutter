// ignore: file_names
import 'package:connect/screens/Assessments/mechanicalAssessments_screen.dart';
import 'package:connect/screens/Assessments/physicalAssessments_screen.dart';
import 'package:flutter/material.dart';

import '../../Globals/globals.dart';
import '../Questionieries/questionnaireWidget.dart';

class ViewUserDetailScreen extends StatefulWidget {
  final String? imgUrl;
  String name;
  String height;
  String email;
  String strWeight;
  String handedness;
  int age;
  String school;
  String lvl;
  ViewUserDetailScreen({
    Key? key,
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
  State<ViewUserDetailScreen> createState() => _ViewUserDetailScreenState();
}

class _ViewUserDetailScreenState extends State<ViewUserDetailScreen> {
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
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: widget.imgUrl == null
                        ? CircleAvatar(
                            radius: 60.0,
                            backgroundColor: Colors.grey[300],
                          )
                        : CircleAvatar(
                            radius: 60.0,
                            child: ClipOval(
                              child: Image.network(
                                '$publicUrl${widget.imgUrl}',
                                width: 120.0,
                                height: 120.0,
                                fit: BoxFit.cover,
                              ),
                            ),
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
                            enabled: false,
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
                          enabled: false,
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
                      enabled: false,
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
                            enabled: false,
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
                            enabled: false,
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
                            enabled: false,
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
                            enabled: false,
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
                      enabled: false,
                      controller: TextEditingController()
                        ..text = widget.lvl.toString(),
                      onChanged: (value) {
                        widget.lvl = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            // const PhysicalAssessments(),
            const MechanicalAssessments(),
            const QuestionnaireScreen(),
          ],
        ),
      ),
    );
  }
}
