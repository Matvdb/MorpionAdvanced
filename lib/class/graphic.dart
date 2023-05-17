import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Graphic{
  final String nameJoueur;
  final int scoreJoueur;
  final charts.Color color;
  Graphic(this.nameJoueur, this.scoreJoueur, Color color) : this.color=charts.Color(g:color.green, r: color.red, a: color.alpha, b: color.blue);
}