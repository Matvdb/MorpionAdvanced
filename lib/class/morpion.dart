class Morpion {
  static String joueur1 = "X";
  static String joueur2 = "O";

  static int scoreJ1 = 0;
  static int scoreJ2 = 0;

  static String phraseResult = "";

  // Fonction pour calculer les probabilités
  static List<double> calculerProbabilite(int scoreJoueur1, int scoreJoueur2) {
    int totalScores = scoreJoueur1 + scoreJoueur2;
    double probabiliteJoueur1 = scoreJoueur1 / totalScores;
    double probabiliteJoueur2 = scoreJoueur2 / totalScores;

    return [probabiliteJoueur1, probabiliteJoueur2];
  }
  
  static int bestScore = 0;

  static int getBestScore(){
    if(scoreJ1 > scoreJ2){
      bestScore = scoreJ1;
    } else if(scoreJ2 > scoreJ1){
      bestScore = scoreJ2;
    }
    return bestScore;
  }

  static String currentPlayer = "";
  static bool gameEnd = false;
  static List<String> estOccuper = [];

  static void initGame(){
    currentPlayer = joueur1;
    gameEnd = false;
    estOccuper = ["", "", "", "", "", "", "", "", ""];
  }

  static void initScore(){
    scoreJ1 = 0;
    scoreJ2 = 0;
    bestScore = 0;
  }

  static String headerText(){
    String tour = currentPlayer;
    String text = "Tour de $tour";
    return text;
  }

  static void changerTour(){
    if(currentPlayer == joueur1){
      currentPlayer = joueur2;
    } else {
      currentPlayer = joueur1;
    }
  }

  static String probaVictoireJ1(){
    List<double> probabilites = calculerProbabilite(scoreJ1, scoreJ2);
    double probabiliteJoueur1 = probabilites[0];
    String result = probabiliteJoueur1.toStringAsFixed(2);
    return "$result %";
  }

  static String probaVictoireJ2(){
    List<double> probabilites = calculerProbabilite(scoreJ1, scoreJ2);
    double probabiliteJoueur2 = probabilites[1];
    String result = probabiliteJoueur2.toStringAsFixed(2);
    return "$result %";
  } 
}