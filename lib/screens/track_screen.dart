import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  DateTime _dateTime = DateTime.now();
  DateFormat _format = DateFormat('MM//dd/yyyy');
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: HexColor("#F6F6F6"),
          leading: Icon(Icons.arrow_back_ios),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => IconScreen()));
                });
              },
              icon: Icon(Icons.filter_list),
              iconSize: 25,
            ),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30))),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text("History",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: HexColor("#222222"))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 150,
                        height: 35,
                        child: TextField(
                            decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          isCollapsed: true,
                          contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                          hintText: "Search",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                        )),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                        child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => HexColor("#30CED9")),
                      columnSpacing: 5.0,
                      columns: [
                        DataColumn(
                            label: Container(
                          width: width * .3,
                          child: Text("Date"),
                        )),
                        DataColumn(
                            label: Container(
                          width: width * .2,
                          child: Text("Weight"),
                        )),
                        DataColumn(
                            label: Container(
                          width: width * .2,
                          child: Text("Arm Pain"),
                        )),
                        DataColumn(
                            label: Container(
                          width: width * .2,
                          child: Text("Action"),
                        )),
                      ],
                      rows: List<DataRow>.generate(
                          30,
                          (index) => DataRow(cells: [
                                DataCell(Text("May 02,2022")),
                                DataCell(Text(" 11")),
                                DataCell(Text(" 10")),
                                DataCell(RichText(
                                  text: TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: Icon(
                                          Icons.delete,
                                          size: 20,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                              ])),
                    ))),
              ),
            ]),
          ),
        ));
  }
}
