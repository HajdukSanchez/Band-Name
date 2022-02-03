import 'package:band_names/models/band.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Chart extends StatelessWidget {
  final List data;
  final String centerText;

  const Chart({Key? key, required this.data, this.centerText = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, double> chartData = {};

    for (Band element in data) {
      chartData.addAll({element.name: element.votes.toDouble()});
    }

    return PieChart(
      dataMap: chartData,
      animationDuration: const Duration(milliseconds: 800),
      initialAngleInDegree: 0,
      chartRadius: MediaQuery.of(context).size.width / 1.5,
      chartType: ChartType.disc,
      centerText: centerText,
      legendOptions: const LegendOptions(
          showLegends: true,
          legendTextStyle: TextStyle(fontWeight: FontWeight.w400)),
      chartValuesOptions: const ChartValuesOptions(
        showChartValueBackground: false,
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValuesOutside: false,
        chartValueStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
    );
  }
}
