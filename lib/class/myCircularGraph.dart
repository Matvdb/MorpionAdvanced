import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:morpion/class/GraphCircData.dart';
import 'package:morpion/class/morpion.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyCircularGraph extends StatefulWidget {
  const MyCircularGraph({super.key});

  @override
  State<MyCircularGraph> createState() => _MyCircularGraphState();
}

class _MyCircularGraphState extends State<MyCircularGraph> {
  late List<GDPData> _chartData; 

  @override
  void initState(){
    _chartData = getCircularGraphData();
    super.initState();
  }

  List<GDPData> getCircularGraphData(){
    final List<GDPData> graphData = [
      GDPData(0, Morpion.scoreJ1),
      GDPData(0, Morpion.scoreJ2),
    ];
    return graphData;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SfCircularChart(
          series: <CircularSeries> [
            PieSeries <GDPData, double>(
              dataSource: _chartData,
              xValueMapper: (GDPData data, _) => data.x,
              yValueMapper: (GDPData data, _) => data.y,
            )
          ],
        ),
      ),
    );
  }
}