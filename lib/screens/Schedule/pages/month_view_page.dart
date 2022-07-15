import 'dart:async';
import 'dart:convert';

import 'package:calendar_view/calendar_view.dart';
import 'package:connect/screens/Schedule/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import '../../../Globals/globals.dart';
import '../create_event_page.dart';
import '../model/event.dart';
import '../widgets/month_view_widget.dart';

DateTime get _now => DateTime.now();

class MonthViewPageDemo extends StatefulWidget {
  const MonthViewPageDemo({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MonthViewPageDemoState createState() => _MonthViewPageDemoState();
}

class _MonthViewPageDemoState extends State<MonthViewPageDemo> {
  final storage = const FlutterSecureStorage();
  bool loading = true;
  List schedule = [];

  List<CalendarEventData<Event>> _events = [];
  Future getEvents() async {
    setState(() {
      loading = true;
    });
    await EasyLoading.show(
      status: 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
    var url = Uri.parse('${apiURL}exercises/schedule');
    String? token = await storage.read(key: "token");
    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      // body: jsonEncode(<String, String?>{
      //     'id': ,
      //   }),
    );
    if (response.statusCode == 200) {
      var jsonBody = response.body;
      var jsonData = jsonDecode(jsonBody);
      var data = jsonData["schedule"];
      if (mounted) {
        setState(() {
          schedule = data;
          _events = [];
          for (var i = 0; i < data.length; i++) {
            _events.add(
              CalendarEventData(
                date: DateTime.parse(data[i]["start"]),
                title: data[i]["title"],
                color: HexColor(
                  data[i]["backgroundColor"],
                ),
              ),
            );
          }
          print(_events);
          loading = false;
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
    getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(),
            ),
          )
        : CalendarControllerProvider<Event>(
            controller: EventController<Event>()..addAll(_events),
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                backgroundColor: HexColor("#30CED9"),
                elevation: 8,
                onPressed: _addEvent,
                child: const Icon(Icons.add),
              ),
              body: const MonthViewWidget(),
            ),
          );
  }

  Future<void> _addEvent() async {
    final event = await context.pushRoute<CalendarEventData<Event>>(
      CreateEventPage(
        withDuration: true,
        schedule: schedule,
      ),
    );
    if (event == null) return;
    // ignore: use_build_context_synchronously
    // CalendarControllerProvider.of<Event>(context).controller.add(event);
  }
}
