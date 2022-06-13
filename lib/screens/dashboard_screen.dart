import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<_SalesData> data = [
    _SalesData("2022/06/01", 1.0),
    _SalesData("2022/06/02", 0.8),
    _SalesData("2022/06/03", 0.6),
    _SalesData("2022/06/04", 0.4),
    _SalesData("2022/06/05", 0.2),
    _SalesData("2022/06/06", 0),
    _SalesData("2022/06/07", -0.2),
    _SalesData("2022/06/08", -0.4),
    _SalesData("2022/06/09", -0.6),
    _SalesData("2022/06/10", -0.8),
    _SalesData("2022/06/11", -1.0),
    _SalesData("2022/06/12", 1.0),
    _SalesData("2022/06/13", 0.8),
    _SalesData("2022/06/14", 0.6),
    _SalesData("2022/06/15", 0.4),
    _SalesData("2022/06/16", 0.2),
    _SalesData("2022/06/17", 0),
    _SalesData("2022/06/18", -0.2),
    _SalesData("2022/06/19", -0.4),
    _SalesData("2022/06/20", -0.6),
    _SalesData("2022/06/21", -0.8),
    _SalesData("2022/06/22", -1.0),
    _SalesData("2022/06/23", 0.8),
    _SalesData("2022/06/24", 0.6),
    _SalesData("2022/06/25", 0.4),
    _SalesData("2022/06/26", 0.2),
    _SalesData("2022/06/27", -0.2),
    _SalesData("2022/06/28", -0.4),
    _SalesData("2022/06/29", -0.6),
    _SalesData("2022/06/30", -0.8),
  ];

  @override
  void initState() {
    // _chartData = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: (Scaffold(
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
        body: Column(
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
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 2.0, spreadRadius: 0.4)
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
            const SizedBox(
              height: 30,
            ),
            Row(
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
            const SizedBox(
              height: 30,
            ),
            SfCartesianChart(
              primaryXAxis:
                  CategoryAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
              title: ChartTitle(text: 'Weight Weight Weight'),
              legend: Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<_SalesData, String>>[
                LineSeries<_SalesData, String>(
                  dataSource: data,
                  xValueMapper: (_SalesData sales, _) => sales.year,
                  yValueMapper: (_SalesData sales, _) => sales.sales,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
