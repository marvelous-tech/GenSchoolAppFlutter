import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class AttendancePieChart extends StatefulWidget {
  final double absents;
  final double presents;


  AttendancePieChart({this.presents, this.absents});

  @override
  _AttendancePieChartState createState() => _AttendancePieChartState();
}

class _AttendancePieChartState extends State<AttendancePieChart> {
  Map<String, double> dataMap = Map();
  List<Color> colorList = [
    Colors.blue,
    Colors.red,
  ];

  @override
  void initState() {
    super.initState();
    dataMap.putIfAbsent("${this.widget.presents.toInt()} Presents", () => this.widget.presents);
    dataMap.putIfAbsent("${this.widget.absents.toInt()} Absents", () => this.widget.absents);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Center(
        child: PieChart(
                dataMap: dataMap,
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 50.0,
                chartRadius: MediaQuery.of(context).size.width/2.5,
                showChartValuesInPercentage: true,
                showChartValues: true,
                showChartValuesOutside: false,
                chartValueBackgroundColor: Colors.grey[200],
                colorList: colorList,
                showLegends: true,
                legendPosition: LegendPosition.right,
                decimalPlaces: 1,
                showChartValueLabel: true,
                initialAngle: 45,
                chartValueStyle: defaultChartValueStyle.copyWith(
                  color: Colors.blueGrey[900].withOpacity(0.9),
                ),
                chartType: ChartType.ring,
              ),
      ),
    );
  }
}
