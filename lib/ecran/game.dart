import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:morpion/class/graphic.dart';
import 'package:morpion/class/morpion.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {

  @override
  void initState(){
    Morpion.initGame();
    super.initState();
  }

  _gameContainer(){
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(8),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3
        ),
        itemCount: 9,
        itemBuilder: (context, int index){
          return _box(index);
        }
      ),
    );
  }

  _box(int index){
    return InkWell(
      onTap: () {
        if (Morpion.gameEnd || Morpion.estOccuper[index].isNotEmpty) {
          return;
        }
        setState(() {
          Morpion.estOccuper[index] = Morpion.currentPlayer;
          Morpion.changerTour();
          winner();
        });
      },
      child: Container(
        color: Colors.black38,
        margin: const EdgeInsets.all(8),
        child: Center(
          child: Text(
            Morpion.estOccuper[index],
            style: const TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }

  winner() {
    List<List<int>> grilleWin = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var winPosition in grilleWin) {
      String grille0 = Morpion.estOccuper[winPosition[0]];
      String grille1 = Morpion.estOccuper[winPosition[1]];
      String grille2 = Morpion.estOccuper[winPosition[2]];

      if (grille0.isNotEmpty) {
        if (grille0 == grille1 && grille0 == grille2) {
          _messageFin(Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Le joueur "),
              Text("$grille0 ", style: TextStyle(fontWeight: FontWeight.bold),),
              Text("à gagner !"),
            ],
          ));
          Morpion.gameEnd = true;
          if(grille0 == "X"){
            Morpion.scoreJ1++;
          } else if(grille0 == "O"){
            Morpion.scoreJ2++;
          }
          return;
        }
      }
    }
  }

  Future<void> _messageFin(Row phrase) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Partie fini !', textAlign: TextAlign.center,),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                phrase,
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Fermer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Recommencer'),
              onPressed: () {
                setState(() {
                  Navigator.of(context).pop();
                  Morpion.initGame();
                });
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _stats() async {
    return showDialog<void>(
      context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Statistiques', textAlign: TextAlign.center,),
          content: Builder(
            builder: (context) {                           
              var height = MediaQuery.of(context).size.height * 0.8;
              var width = MediaQuery.of(context).size.width;
              return Container(
                height: height,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Score de " + Morpion.joueur1),
                        Text("Score de " + Morpion.joueur2),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(Morpion.scoreJ1.toString()),
                        Text(Morpion.scoreJ2.toString()),
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(15)),
                    Text("Probabilité que " + Morpion.joueur1 + " gagne la partie:", style: TextStyle(fontSize: 13.0),),
                    Text(Morpion.probaVictoireJ1().toString(), style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),),
                    Padding(padding: EdgeInsets.all(5)),
                    Text("Probabilité que " + Morpion.joueur2 + " gagne la partie:", style: TextStyle(fontSize: 13.0),),
                    Text(Morpion.probaVictoireJ2().toString(), style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),),
                  ],
                ),
              );
            },
          ),
        )
    );
  }

  _restartButton(){
    return ElevatedButton(
      onPressed: (){
        setState(() {
          Morpion.initGame();
          Morpion.initScore();
        });
      }, 
      child: const Text("Mise à zéro"),
    );
  }

  _statGame(){
    return ElevatedButton(
      onPressed: (){
        setState(() {
          _stats();
        });
      }, 
      child: const Text("Statistiques"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Morpion - ",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                Text(Morpion.headerText().toString(),
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Score de " + Morpion.joueur1,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                Text("Score de " + Morpion.joueur2,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(Morpion.scoreJ1.toString(),
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                Text(Morpion.scoreJ2.toString(),
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          _gameContainer(),
          _restartButton(),
          Padding(padding: EdgeInsets.all(5)),
          _statGame(),
        ],
      ),
    );
  }
}