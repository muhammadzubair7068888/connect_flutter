import 'package:date_field/date_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../GraphWidgets/armPainWidget.dart';
import '../GraphWidgets/doubleCrowHopDistanceWidget.dart';
import '../GraphWidgets/kneelingLongTossWidget.dart';
import '../GraphWidgets/moundThrowsVelocityWidget.dart';
import '../GraphWidgets/pullDown3Widget.dart';
import '../GraphWidgets/pullDown4Widget.dart';
import '../GraphWidgets/pullDown5Widget.dart';
import '../GraphWidgets/pullDown6Widget.dart';
import '../GraphWidgets/pullDown7Widget.dart';
import '../GraphWidgets/standingLongTossWidget.dart';
import '../GraphWidgets/weightWidget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: (Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(12),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {},
          ),
          centerTitle: true,
          title: const Text(
            "Dashboard",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
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
                        labelText: 'Select User',
                      ),
                    ),
                    popupProps: const PopupProps.menu(
                      showSelectedItems: true,
                      // disabledItemFn: (String s) => s.startsWith('I'),
                    ),
                    items: const [
                      "Adam",
                      "John",
                      "Katty",
                      'Ariana',
                    ],
                    onChanged: print,
                    // selectedItem: "Brazil",
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                  child: DateTimeFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                      contentPadding: EdgeInsets.all(20),
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      labelText: 'Start Date',
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (e) =>
                        (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                    onDateSelected: (DateTime value) {
                      // _date = value;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                  child: DateTimeFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                      contentPadding: EdgeInsets.all(20),
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      labelText: 'End Date',
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (e) =>
                        (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                    onDateSelected: (DateTime value) {
                      // _date = value;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Respond to button press
                      },
                      style: ElevatedButton.styleFrom(
                        maximumSize: const Size(150, 50),
                        minimumSize: const Size(150, 50),
                      ),
                      child: const Text('Search'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Respond to button press
                      },
                      style: ElevatedButton.styleFrom(
                        maximumSize: const Size(150, 50),
                        minimumSize: const Size(150, 50),
                      ),
                      child: const Text('Clear'),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: const WeightWidget(),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: const ArmPainWidget(),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: const KneelingLongTossWidget(),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: const StandingLongTossWidget(),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: const MoundThrowsVelocityWidget(),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: const PullDown3Widget(),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: const PullDown4Widget(),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: const PullDown5Widget(),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: const PullDown6Widget(),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: const DoubleCrowHopDistanceWidget(),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: const PullDown7Widget(),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
