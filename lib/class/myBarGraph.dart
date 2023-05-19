import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:morpion/class/bar_data.dart';
import 'package:morpion/class/individual_bar.dart';
import 'package:morpion/class/morpion.dart';

class MyBarGraph extends StatelessWidget {
  const MyBarGraph({super.key, required this.scores});

  final List scores;

  @override
  Widget build(BuildContext context) {

    BarData myBarData = BarData(scores1: Morpion.scoreJ1, scores2: Morpion.scoreJ2);
    myBarData.initBarData();

    return BarChart(
      BarChartData(
        maxY: 20,
        minY: 0,
        barGroups: myBarData.barData.map((data) => BarChartGroupData(x: data.x, barRods: [BarChartRodData(toY: data.y)])).toList()
      ),
    );
  }
}