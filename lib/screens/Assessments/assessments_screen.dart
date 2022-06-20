import 'package:connect/screens/Assessments/mechanicalAssessments_screen.dart';
import 'package:connect/screens/Assessments/physicalAssessments_screen.dart';
import 'package:flutter/material.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({Key? key}) : super(key: key);

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const <Widget>[
          PhysicalAssessments(),
          MechanicalAssessments(),
        ],
      ),
    );
  }
}
