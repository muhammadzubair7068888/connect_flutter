// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:calendar_view/calendar_view.dart';
import 'package:connect/screens/Schedule/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import '../../../Globals/globals.dart';
import '../../BottomNavBar/bottomNavBar_screen.dart';
import '../edit_event_page.dart';
import '../model/event.dart';
import '../pages/dayPlan_screen.dart';

class MonthViewWidget extends StatefulWidget {
  final GlobalKey<MonthViewState>? state;
  final double? width;
  final List schedule;
  final String userId;
  final String username;
  final String role;
  const MonthViewWidget({
    Key? key,
    this.state,
    this.width,
    required this.schedule,
    required this.username,
    required this.role,
    required this.userId,
  }) : super(key: key);

  @override
  State<MonthViewWidget> createState() => _MonthViewWidgetState();
}

class _MonthViewWidgetState extends State<MonthViewWidget> {
  int id = 0;
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
            content: const Text('Deleted successfully'),
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
  Widget build(BuildContext context) {
    return MonthView<Event>(
      key: widget.state,
      width: widget.width,
      onEventTap: widget.role != 'user'
          ? (event, date) {
              setState(() {
                var obj = widget.schedule[int.parse(event.description)];
                id = int.parse(obj["extendedProps"]["exerciseID"]);
              });
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    actionsAlignment: MainAxisAlignment.center,
                    title: const Text(
                      "Edit/Delete or View?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Future<void> _editEvent() async {
                            final events = await context
                                .pushRoute<CalendarEventData<Event>>(
                              EditEventPage(
                                withDuration: true,
                                title: event.title,
                                role: widget.role,
                                schedule: widget.schedule,
                                userId: widget.userId,
                                id: id,
                                desc: event.description,
                                username: widget.username,
                              ),
                            );
                            if (events == null) return;
                            Navigator.pop(context);
                          }

                          _editEvent();
                        },
                        child: const Text("Edit"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            widget.schedule
                                .removeAt(int.parse(event.description));
                          });
                          addExercise();
                          Navigator.pop(context);
                        },
                        child: const Text("Delete"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DayPlanScreen(
                                id: id,
                              ),
                            ),
                          );
                        },
                        child: const Text("View"),
                      ),
                    ],
                    elevation: 24,
                  );
                },
              );
            }
          : null,
    );
  }
}
