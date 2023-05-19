import 'package:morpion/class/individual_bar.dart';
import 'package:morpion/class/morpion.dart';

class BarData {
  final double scores1;
  final double scores2;

  BarData({required this.scores1, required this.scores2});

  List<IndividualBar> barData = [];

  void initBarData(){
    barData = [
      IndividualBar(x: 0, y: Morpion.scoreJ1),

      IndividualBar(x: 0, y: Morpion.scoreJ2),
    ];
  }
}