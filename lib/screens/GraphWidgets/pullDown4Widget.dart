import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PullDown4Widget extends StatefulWidget {
  const PullDown4Widget({Key? key}) : super(key: key);

  @override
  State<PullDown4Widget> createState() => _PullDown4WidgetState();
}

class _PullDown4WidgetState extends State<PullDown4Widget> {
  List<_SalesData> data = [
    _SalesData("2022/06/01", 0.6),
    _SalesData("2022/06/02", 0.4),
    _SalesData("2022/06/03", 0.2),
    _SalesData("2022/06/04", 0),
    _SalesData("2022/06/05", -0.2),
    _SalesData("2022/06/06", -0.4),
    _SalesData("2022/06/07", -0.6),
    _SalesData("2022/06/08", 0.6),
    _SalesData("2022/06/09", 0.4),
    _SalesData("2022/06/10", 0.2),
    _SalesData("2022/06/11", 0),
    _SalesData("2022/06/12", -0.2),
    _SalesData("2022/06/13", -0.4),
    _SalesData("2022/06/14", -0.6),
    _SalesData("2022/06/15", 0.6),
    _SalesData("2022/06/16", 0.4),
    _SalesData("2022/06/17", 0.2),
    _SalesData("2022/06/18", 0),
    _SalesData("2022/06/19", -0.2),
    _SalesData("2022/06/20", -0.4),
    _SalesData("2022/06/21", -0.6),
    _SalesData("2022/06/22", 0.6),
    _SalesData("2022/06/23", 0.4),
    _SalesData("2022/06/24", 0.2),
    _SalesData("2022/06/25", 0),
    _SalesData("2022/06/26", -0.2),
    _SalesData("2022/06/27", -0.4),
    _SalesData("2022/06/28", -0.6),
    _SalesData("2022/06/29", 0.6),
    _SalesData("2022/06/30", 0.4),
  ];
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      backgroundColor: Colors.white,
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(minimum: -1, maximum: 1, interval: 0.2),
      title: ChartTitle(text: 'Pull Down 4'),
      legend: Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <ChartSeries>[
        StepLineSeries<_SalesData, String>(
          name: 'Pull Down 4',
          color: HexColor("#30CED9"),
          dataSource: data,
          dashArray: const <double>[5, 5],
          xValueMapper: (_SalesData weight, _) => weight.year,
          yValueMapper: (_SalesData weight, _) => weight.weight,
          markerSettings: const MarkerSettings(isVisible: true),
        )
      ],
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.weight);

  final String year;
  final double weight;
}
