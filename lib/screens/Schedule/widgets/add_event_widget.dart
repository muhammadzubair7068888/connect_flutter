import 'dart:convert';

import 'package:calendar_view/calendar_view.dart';
import 'package:date_field/date_field.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import '../../../Globals/globals.dart';
import '../../Exercises/user_model.dart';
import '../app_colors.dart';
import '../model/event.dart';
import 'custom_button.dart';

class AddEventWidget extends StatefulWidget {
  final void Function(CalendarEventData<Event>)? onEventAdd;
  List schedule;
  AddEventWidget({
    Key? key,
    required this.schedule,
    this.onEventAdd,
  }) : super(key: key);

  @override
  _AddEventWidgetState createState() => _AddEventWidgetState();
}

class _AddEventWidgetState extends State<AddEventWidget> {
  final GlobalKey<FormState> _form = GlobalKey();
  late FocusNode _dateNode;
  late TextEditingController _startDateController;
  late FocusNode _titleNode;
  Color _color = Colors.blue;
  String exercise = "";
  List<String> exercises = [];
  List exer = [];
  int? free_id;
  DateTime dateTime = DateTime.now();
  final storage = const FlutterSecureStorage();
  int? ids;
  Future id() async {
    String? id = await storage.read(key: "id");
    setState(() {
      ids = int.parse(id!);
    });
  }

  Future addExercise() async {
    var uri = Uri.parse('${apiURL}exercises/schedule/update');
    String? token = await storage.read(key: "token");
    String? id = await storage.read(key: "id");
    setState(() {
      ids = int.parse(id!);
    });
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = widget.schedule;
    var request = http.MultipartRequest(
      'POST',
      uri,
    )..headers.addAll(headers);
    request.fields['events'] = jsonEncode(widget.schedule);
    request.fields['id'] = id.toString();
    var response = await request.send();
    // var responseDecode = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      // final result = jsonDecode(responseDecode.body);
      // final result = jsonDecode(responseDecode.body) as Map<String, dynamic>;
      FocusManager.instance.primaryFocus?.unfocus();
      _resetForm();
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

  @override
  void initState() {
    super.initState();
    id();
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
          // Container(
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(10.0),
          //     boxShadow: const [
          //       BoxShadow(
          //           color: Colors.grey, blurRadius: 2.0, spreadRadius: 0.4)
          //     ],
          //   ),
          //   child: DropdownSearch<String>(
          //     dropdownDecoratorProps: const DropDownDecoratorProps(
          //       dropdownSearchDecoration: InputDecoration(
          //         hintStyle: TextStyle(color: Colors.black),
          //         errorStyle: TextStyle(color: Colors.redAccent),
          //         border: InputBorder.none,
          //         suffixIcon: Icon(Icons.arrow_drop_down_sharp),
          //         contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          //         labelStyle: TextStyle(
          //             fontWeight: FontWeight.bold, color: Colors.black),
          //         labelText: 'Exercise Type',
          //       ),
          //     ),
          //     popupProps: const PopupProps.menu(
          //       showSelectedItems: true,
          //       // disabledItemFn: (String s) => s.startsWith('I'),
          //     ),
          //     validator: (velocity) {
          //       if (velocity == null || velocity == "") {
          //         return "Please select exercise type";
          //       }
          //       return null;
          //     },
          //     items: exercises,
          //     onChanged: (value) {
          //       exercise = value!;
          //     },
          //     // selectedItem: velocity,
          //   ),
          // ),
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
                    initialValue: dateTime,
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    onDateSelected: (DateTime value) {
                      // dt = DateTime.parse(formatted);
                      dateTime = value;
                      print(dateTime);
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
              // addExercise();
              setState(() {
                widget.schedule.add(
                  dataObject(
                    backgroundColor: "#30CED9",
                    borderColor: '#30CED9',
                    extendedProps: ExtendedProps(
                        exerciseID: free_id.toString(),
                        user_id: ids.toString()),
                    start: dateTime.toString(),
                    title: exercise,
                  ).toJson(),
                );
              });
              print("1");
              print(widget.schedule);
              addExercise();
            },
            title: "Add Event",
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

  void _resetForm() {
    _form.currentState?.reset();
    _startDateController.text = "";
    // _endTimeController.text = "";
    // _startTimeController.text = "";
  }

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
        contentPadding: EdgeInsets.all(20.0),
        children: [
          const Text(
            "Event Color",
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
            paletteType: PaletteType.rgb,
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
                  print(_color);
                  // context.pop();
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
      margin: EdgeInsets.symmetric(horizontal: 8),
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
  String user_id;
  String exerciseID;

  ExtendedProps({
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
