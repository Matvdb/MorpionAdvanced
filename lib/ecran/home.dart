import 'package:flutter/material.dart';
import 'package:morpion/class/morpion.dart';
import 'package:morpion/ecran/game.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isSelected = false;

  final Container _jouerSolo = Container(
    height: 100,
    width: 100,
    decoration: const BoxDecoration(
      color: Colors.grey,
    ),
    child: const Icon(Icons.person),
  );

  final Container _jouerDuo = Container(
    height: 100,
    width: 100,
    decoration: BoxDecoration(
      color: Colors.indigo.shade300,
    ),
    child: const Icon(Icons.group),
  );

  Future<void> _selectionMode() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sélectionner le nombre de joueur', textAlign: TextAlign.center,),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text("Jouer avec un robot", textAlign: TextAlign.center,),
                const Padding(padding: EdgeInsets.all(5)),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Game()));
                      Morpion.initGame();
                      Morpion.initScore();
                    });
                  },
                  child: _jouerSolo,
                ),
                const Padding(padding: EdgeInsets.all(10)),
                const Text("Jouer avec un ami", textAlign: TextAlign.center,),
                const Padding(padding: EdgeInsets.all(5)),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Game()));
                      Morpion.initGame();
                      Morpion.initScore();
                    });
                  },
                  child: _jouerDuo,
                ),
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
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Theme.of(context).primaryColor,
              ),
              child: Text(widget.title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20.0),),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            _selectionMode();
          });
        },
        tooltip: 'Increment',
        label: const Text("Jouer"),
        icon: const Icon(Icons.play_arrow),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}