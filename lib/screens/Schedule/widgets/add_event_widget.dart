import 'dart:convert';

import 'package:calendar_view/calendar_view.dart';
import 'package:connect/screens/Schedule/extension.dart';
import 'package:date_field/date_field.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../Globals/globals.dart';
import '../../BottomNavBar/bottomNavBar_screen.dart';
import '../../Exercises/user_model.dart';
import '../app_colors.dart';
import '../model/event.dart';
import 'custom_button.dart';

// ignore: must_be_immutable
class AddEventWidget extends StatefulWidget {
  final void Function(CalendarEventData<Event>)? onEventAdd;
  List schedule;
  String userId;
  String username;
  final String role;
  AddEventWidget({
    Key? key,
    required this.username,
    required this.schedule,
    required this.userId,
    required this.role,
    this.onEventAdd,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddEventWidgetState createState() => _AddEventWidgetState();
}

class _AddEventWidgetState extends State<AddEventWidget> {
  final GlobalKey<FormState> _form = GlobalKey();
  late FocusNode _dateNode;
  late TextEditingController _startDateController;
  late FocusNode _titleNode;
  Color _color = const Color(0xff30CED9);
  String exercise = "";
  List<String> exercises = [];
  List exer = [];
  // ignore: non_constant_identifier_names
  int? free_id;
  String? dateTime;
  final storage = const FlutterSecureStorage();

// --                                                               -- //
// --                          START                                -- //
// --                                                               -- //
  Future addExercise() async {
    var uri = Uri.parse('${apiURL}exercises/schedule/update');
    String? token = await storage.read(key: "token");

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    // var body = widget.schedule;
    var request = http.MultipartRequest(
      'POST',
      uri,
    )..headers.addAll(headers);
    request.fields['events'] = jsonEncode(widget.schedule);
    request.fields['id'] = widget.userId;
    var response = await request.send();
    // var responseDecode = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      // final result = jsonDecode(responseDecode.body);
      // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;
      FocusManager.instance.primaryFocus?.unfocus();
      // _resetForm();
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavBar(
            role: widget.role,
            index: 3,
            i: widget.userId,
            u: widget.username,
          ),
        ),
        (Route<dynamic> route) => false,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: HexColor("#30CED9"),
            dismissDirection: DismissDirection.vertical,
            content: const Text('Added successfully'),
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
  void initState() {
    super.initState();
    _titleNode = FocusNode();
    _dateNode = FocusNode();
    _startDateController = TextEditingController();
  }

  @override
  void dispose() {
    _titleNode.dispose();
    _dateNode.dispose();
    _startDateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey, blurRadius: 2.0, spreadRadius: 0.4)
              ],
            ),
            child: DropdownSearch<UserModel>(
              onChanged: (value) {
                free_id = value!.id;
                exercise = value.name;
              },
              validator: (value) {
                if (free_id == null || exercise == "") {
                  return "Select exercise type";
                }

                return null;
              },
              dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                labelText: "Select Exercise Type",
                hintText: "Select Exercise Type",
              )),
              asyncItems: (String? filter) => getData(filter),
              popupProps: PopupPropsMultiSelection.modalBottomSheet(
                showSelectedItems: true,
                itemBuilder: _customPopupItemBuilderExample2,
                showSearchBox: true,
              ),
              compareFn: (item, sItem) => item.id == sItem.id,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
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
                      labelText: 'Select Date',
                    ),
                    // initialValue: dateTime,
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    onDateSelected: (DateTime value) {
                      // dt = DateTime.parse(formatted);
                      String formatDate = DateFormat("yyyy-MM-dd")
                          .format(DateTime.parse(value.toString()));
                      dateTime = formatDate;
                    },
                    validator: (value) {
                      if (dateTime == null || dateTime == "") {
                        return "Select date";
                      }

                      return null;
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const Text(
                "Color: ",
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 17,
                ),
              ),
              GestureDetector(
                onTap: _displayColorPicker,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: _color,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          CustomButton(
            onTap: () {
              if (!(_form.currentState?.validate() ?? true)) return;
              setState(() {
                String hello = _color.toString();
                String ello = hello.substring(10);
                var str = ello.substring(0, ello.length - 1);
                widget.schedule.add(
                  dataObject(
                    backgroundColor: "#$str",
                    borderColor: '#$str',
                    extendedProps: ExtendedProps(
                      user_id: widget.userId,
                      exerciseID: free_id.toString(),
                    ),
                    start: dateTime.toString(),
                    title: exercise,
                  ).toJson(),
                );
              });
              addExercise();
            },
            title: "Add",
          ),
        ],
      ),
    );
  }

  // void _createEvent() {
  //   if (!(_form.currentState?.validate() ?? true)) return;
  //   _form.currentState?.save();
  //   final event = CalendarEventData<Event>(
  //     date: _startDate,
  //     color: _color,
  //     // endTime: _endTime,
  //     // startTime: _startTime,
  //     // description: _description,
  //     // endDate: _endDate,
  //     title: _title,
  //     event: Event(
  //       title: _title,
  //     ),
  //   );
  //   widget.onEventAdd?.call(event);
  //   _resetForm();
  // }
  // void _resetForm() {
  //   _form.currentState?.reset();
  //   _startDateController.text = "";
  //   // _endTimeController.text = "";
  //   // _startTimeController.text = "";
  // }

  void _displayColorPicker() {
    var color = _color;
    showDialog(
      context: context,
      useSafeArea: true,
      barrierColor: Colors.black26,
      builder: (_) => SimpleDialog(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: const BorderSide(
            color: AppColors.bluishGrey,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.all(20.0),
        children: [
          const Text(
            "Color",
            style: TextStyle(
              color: AppColors.black,
              fontSize: 25.0,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            height: 1.0,
            color: AppColors.bluishGrey,
          ),
          ColorPicker(
            displayThumbColor: true,
            enableAlpha: false,
            pickerColor: _color,
            onColorChanged: (c) {
              color = c;
            },
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0, bottom: 30.0),
              child: CustomButton(
                title: "Select",
                onTap: () {
                  if (mounted) {
                    setState(() {
                      _color = color;
                    });
                  }
                  context.pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _customPopupItemBuilderExample2(
    BuildContext context,
    UserModel? item,
    bool isSelected,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListTile(
          selected: isSelected,
          title: Text(item?.name ?? ''),
        ),
      ),
    );
  }

  Future<List<UserModel>> getData(filter) async {
    String? token = await storage.read(key: "token");
    var response = await Dio().get(
      "${apiURL}exercises/index",
      queryParameters: {"filter": filter},
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
    final data = response.data["data"];
    if (data != null) {
      return UserModel.fromJsonList(data);
    }

    return [];
  }
}

// ignore: camel_case_types
class dataObject {
  String start;
  String title;
  String borderColor;
  ExtendedProps extendedProps;
  String backgroundColor;

  dataObject(
      {required this.start,
      required this.title,
      required this.borderColor,
      required this.backgroundColor,
      required this.extendedProps});

  factory dataObject.fromJson(Map<String, dynamic> json) => dataObject(
        start: json["start"],
        title: json["title"],
        borderColor: json["borderColor"],
        extendedProps: ExtendedProps.fromJson(json["extendedProps"]),
        backgroundColor: json["backgroundColor"],
      );

  Map<String, dynamic> toJson() => {
        "start": start,
        "title": title,
        "borderColor": borderColor,
        "extendedProps": extendedProps.toJson(),
        "backgroundColor": backgroundColor,
      };
}

class ExtendedProps {
  // ignore: non_constant_identifier_names
  String user_id;
  String exerciseID;

  ExtendedProps({
    // ignore: non_constant_identifier_names
    required this.user_id,
    required this.exerciseID,
  });

  factory ExtendedProps.fromJson(Map<String, dynamic> json) => ExtendedProps(
        user_id: json["user_id"],
        exerciseID: json["exerciseID"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": user_id,
        "exerciseID": exerciseID,
      };
}
