import 'package:connect/screens/Assessments/mechanicalAssessments_screen.dart';
import 'package:connect/screens/Assessments/physicalAssessments_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({Key? key}) : super(key: key);

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  final GlobalKey<FormState> _form = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Form(
            key: _form,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 0.4)
                      ],
                    ),
                    child: DropdownSearch<String>(
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.black),
                          errorStyle: TextStyle(color: Colors.redAccent),
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                          contentPadding: EdgeInsets.all(20),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          labelText: 'Select Type',
                        ),
                      ),
                      popupProps: const PopupProps.menu(
                        showSelectedItems: true,
                        // disabledItemFn: (String s) => s.startsWith('I'),
                      ),
                      items: const [
                        "Physical",
                        "Mechanical",
                      ],
                      selectedItem: "Physical",
                      onChanged: print,
                      // selectedItem: "Brazil",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 0.4)
                      ],
                    ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                        labelText: 'Enter label',
                      ),
                      validator: (value) {
                        if (value == null || value == "") {
                          return "Please enter label.";
                        }

                        return null;
                      },
                      onSaved: (value) {},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Respond to button press
                          if (!(_form.currentState?.validate() ?? true)) return;
                        },
                        style: ElevatedButton.styleFrom(
                          maximumSize: const Size(150, 50),
                          minimumSize: const Size(150, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Respond to button press
                          _form.currentState?.reset();
                        },
                        style: ElevatedButton.styleFrom(
                          maximumSize: const Size(150, 50),
                          minimumSize: const Size(150, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: const Text(
                          'Clear',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const PhysicalAssessments(),
          const MechanicalAssessments(),
        ],
      ),
    );
  }
}
