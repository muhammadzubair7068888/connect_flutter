import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../app_colors.dart';
import '../constants.dart';
import '../extension.dart';
import '../model/event.dart';
import 'custom_button.dart';
import 'date_time_selector.dart';

class EditEventWidget extends StatefulWidget {
  final void Function(CalendarEventData<Event>)? onEventAdd;
  final String title;

  const EditEventWidget({
    Key? key,
    this.onEventAdd,
    required this.title,
  }) : super(key: key);

  @override
  _EditEventWidgetState createState() => _EditEventWidgetState();
}

class _EditEventWidgetState extends State<EditEventWidget> {
  final GlobalKey<FormState> _form = GlobalKey();
  late FocusNode _dateNode;
  late TextEditingController _startDateController;
  late DateTime _startDate;
  late FocusNode _titleNode;
  String _title = "";
  Color _color = Colors.blue;
  // late DateTime _endDate;
  // DateTime? _startTime;
  // DateTime? _endTime;
  // String _description = "";
  // late FocusNode _descriptionNode;

  // late TextEditingController _startTimeController;
  // late TextEditingController _endTimeController;
  // late TextEditingController _endDateController;

  @override
  void initState() {
    super.initState();

    _titleNode = FocusNode();
    _dateNode = FocusNode();
    _startDateController = TextEditingController();
    // _descriptionNode = FocusNode();
    // _endDateController = TextEditingController();
    // _startTimeController = TextEditingController();
    // _endTimeController = TextEditingController();
  }

  @override
  void dispose() {
    _titleNode.dispose();
    _dateNode.dispose();
    _startDateController.dispose();
    // _descriptionNode.dispose();
    // _endDateController.dispose();
    // _startTimeController.dispose();
    // _endTimeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: AppConstants.inputDecoration.copyWith(
              labelText: "Event Title",
            ),
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 17.0,
            ),
            onSaved: (value) => _title = value?.trim() ?? "",
            validator: (value) {
              if (value == null || value == "") {
                return "Please enter event title.";
              }

              return null;
            },
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            initialValue: widget.title,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: DateTimeSelectorFormField(
                  displayDefault: true,
                  controller: _startDateController,
                  decoration: AppConstants.inputDecoration.copyWith(
                    labelText: "Start Date",
                  ),
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Please select date.";
                    }

                    return null;
                  },
                  textStyle: const TextStyle(
                    color: AppColors.black,
                    fontSize: 17.0,
                  ),
                  onSave: (date) => _startDate = date,
                  type: DateTimeSelectionType.date,
                ),
              ),
              // const SizedBox(width: 20.0),
              // Expanded(
              //   child: DateTimeSelectorFormField(
              //     controller: _endDateController,
              //     decoration: AppConstants.inputDecoration.copyWith(
              //       labelText: "End Date",
              //     ),
              //     validator: (value) {
              //       if (value == null || value == "") {
              //         return "Please select date.";
              //       }

              //       return null;
              //     },
              //     textStyle: const TextStyle(
              //       color: AppColors.black,
              //       fontSize: 17.0,
              //     ),
              //     onSave: (date) => _endDate = date,
              //     type: DateTimeSelectionType.date,
              //   ),
              // ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: DateTimeSelectorFormField(
          //         controller: _startTimeController,
          //         decoration: AppConstants.inputDecoration.copyWith(
          //           labelText: "Start Time",
          //         ),
          //         validator: (value) {
          //           if (value == null || value == "") {
          //             return "Please select start time.";
          //           }

          //           return null;
          //         },
          //         onSave: (date) => _startTime = date,
          //         textStyle: const TextStyle(
          //           color: AppColors.black,
          //           fontSize: 17.0,
          //         ),
          //         type: DateTimeSelectionType.time,
          //       ),
          //     ),
          //     const SizedBox(width: 20.0),
          //     Expanded(
          //       child: DateTimeSelectorFormField(
          //         controller: _endTimeController,
          //         decoration: AppConstants.inputDecoration.copyWith(
          //           labelText: "End Time",
          //         ),
          //         validator: (value) {
          //           if (value == null || value == "") {
          //             return "Please select end time.";
          //           }

          //           return null;
          //         },
          //         onSave: (date) => _endTime = date,
          //         textStyle: const TextStyle(
          //           color: AppColors.black,
          //           fontSize: 17.0,
          //         ),
          //         type: DateTimeSelectionType.time,
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 15,
          // ),
          // TextFormField(
          //   focusNode: _descriptionNode,
          //   style: const TextStyle(
          //     color: AppColors.black,
          //     fontSize: 17.0,
          //   ),
          //   keyboardType: TextInputType.multiline,
          //   textInputAction: TextInputAction.newline,
          //   selectionControls: MaterialTextSelectionControls(),
          //   minLines: 1,
          //   maxLines: 10,
          //   maxLength: 1000,
          //   validator: (value) {
          //     if (value == null || value.trim() == "") {
          //       return "Please enter event description.";
          //     }

          //     return null;
          //   },
          //   onSaved: (value) => _description = value?.trim() ?? "",
          //   decoration: AppConstants.inputDecoration.copyWith(
          //     hintText: "Event Description",
          //   ),
          // ),
          // const SizedBox(
          //   height: 15.0,
          // ),
          Row(
            children: [
              const Text(
                "Event Color: ",
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
            onTap: _createEvent,
            title: "Add Event",
          ),
        ],
      ),
    );
  }

  void _createEvent() {
    if (!(_form.currentState?.validate() ?? true)) return;

    _form.currentState?.save();

    final event = CalendarEventData<Event>(
      date: _startDate,
      color: _color,
      // endTime: _endTime,
      // startTime: _startTime,
      // description: _description,
      // endDate: _endDate,
      title: _title,
      event: Event(
        title: _title,
      ),
    );

    widget.onEventAdd?.call(event);
    _resetForm();
  }

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
}
