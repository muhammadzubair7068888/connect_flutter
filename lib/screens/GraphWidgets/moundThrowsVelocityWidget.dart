import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MoundThrowsVelocityWidget extends StatefulWidget {
  const MoundThrowsVelocityWidget({Key? key}) : super(key: key);

  @override
  State<MoundThrowsVelocityWidget> createState() =>
      _MoundThrowsVelocityWidgetState();
}

class _MoundThrowsVelocityWidgetState extends State<MoundThrowsVelocityWidget> {
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
      title: ChartTitle(text: 'Mound Throws Velocity'),
      legend: Legend(isVisible: true),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <ChartSeries<_SalesData, String>>[
        SplineSeries<_SalesData, String>(
          name: 'Mound Throws Velocity',
          color: HexColor("#30CED9"),
          dataSource: data,
          // dashArray: const <double>[5, 5],
          // splineType: SplineType.monotonic,
          xValueMapper: (_SalesData data, _) => data.year,
          yValueMapper: (_SalesData data, _) => data.weight,
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
