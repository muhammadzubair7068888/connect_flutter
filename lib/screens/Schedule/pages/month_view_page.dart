import 'dart:async';
import 'dart:convert';

import 'package:calendar_view/calendar_view.dart';
import 'package:connect/screens/Schedule/extension.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../Globals/globals.dart';
import '../../Exercises/user_model.dart';
import '../create_event_page.dart';
import '../model/event.dart';
import '../widgets/month_view_widget.dart';

DateTime get _now => DateTime.now();

class MonthViewPageDemo extends StatefulWidget {
  final String role;
  final String? i;
  final String? u;
  const MonthViewPageDemo({
    Key? key,
    required this.role,
    required this.i,
    required this.u,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MonthViewPageDemoState createState() => _MonthViewPageDemoState();
}

class _MonthViewPageDemoState extends State<MonthViewPageDemo> {
  final storage = const FlutterSecureStorage();
  bool loading = true;
  List schedule = [];
  late String userId = widget.i == "" ? '' : widget.i.toString();
  late String userName = widget.u == "" ? "Me" : widget.u.toString();
  DateFormat format = DateFormat("yyyy-MM-dd");
  List<CalendarEventData<Event>> _events = [];
  Future getEvents(String? id) async {
    setState(() {
      loading = true;
    });
    // await EasyLoading.show(
    //   status: 'Loading...',
    //   maskType: EasyLoadingMaskType.black,
    // );
    var url = Uri.parse('${apiURL}exercises/schedule');
    String? token = await storage.read(key: "token");
    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String?>{
        'id': id,
      }),
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
                date: format.parse(data[i]["start"]),
                // DateTime.parse(data[i]["start"]),
                title: data[i]["title"],
                color: HexColor(
                  data[i]["backgroundColor"],
                ),
                description: i.toString(),
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

  getd() async {
    String? idUser = await storage.read(key: "id");
    setState(() {
      userId = idUser!;
    });
  }

  @override
  void initState() {
    super.initState();
    getd();
    getEvents(userId);
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
              floatingActionButton: widget.role != 'user'
                  ? FloatingActionButton(
                      backgroundColor: HexColor("#30CED9"),
                      elevation: 8,
                      onPressed: () {
                        _addEvent();
                      },
                      child: const Icon(Icons.add),
                    )
                  : null,
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: widget.role != 'user'
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.4,
                                )
                              ],
                            ),
                            child: DropdownSearch<UserModel>(
                              onChanged: (value) {
                                userId = value!.id.toString();
                                userName = value.name;
                                getEvents(userId);
                              },
                              selectedItem: UserModel(
                                  id: int.parse(userId), name: userName),
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 10, 10, 10),
                                labelText: "Select User",
                                hintText: "Select User",
                              )),
                              asyncItems: (String? filter) => getData(filter),
                              popupProps:
                                  PopupPropsMultiSelection.modalBottomSheet(
                                showSelectedItems: true,
                                itemBuilder: _customPopupItemBuilderExample2,
                                showSearchBox: true,
                              ),
                              compareFn: (item, sItem) => item.id == sItem.id,
                            ),
                          )
                        : null,
                  ),
                  Expanded(
                    child: MonthViewWidget(
                      schedule: schedule,
                      userId: userId,
                      role: widget.role,
                      username: userName,
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Future<void> _addEvent() async {
    final event = await context.pushRoute<CalendarEventData<Event>>(
      CreateEventPage(
        withDuration: true,
        schedule: schedule,
        userId: userId,
        role: widget.role,
        username: userName,
      ),
    );
    if (event == null) return;
    // ignore: use_build_context_synchronously
    // CalendarControllerProvider.of<Event>(context).controller.add(event);
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
      "${apiURL}exercises/users",
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
