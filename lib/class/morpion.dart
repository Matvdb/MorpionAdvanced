class Morpion {
  static String joueur1 = "X";
  static String joueur2 = "O";

  static int scoreJ1 = 0;
  static int scoreJ2 = 0;

  // Fonction pour calculer les probabilités
  static List<double> calculerProbabilite(int scoreJoueur1, int scoreJoueur2) {
    int totalScores = scoreJoueur1 + scoreJoueur2;
    double probabiliteJoueur1 = scoreJoueur1 / totalScores;
    double probabiliteJoueur2 = scoreJoueur2 / totalScores;

    return [probabiliteJoueur1, probabiliteJoueur2];
  }
  
  static int bestScore = 0;

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

  static double probaVictoireJ1(){
    List<double> probabilites = calculerProbabilite(scoreJ1, scoreJ2);
    double probabiliteJoueur1 = probabilites[0];
    return probabiliteJoueur1;
  }

  static double probaVictoireJ2(){
    List<double> probabilites = calculerProbabilite(scoreJ1, scoreJ2);
    double probabiliteJoueur2 = probabilites[1];
    if(probabilites == null){
      probabiliteJoueur2 = 0; 
    } else {
      double probabiliteJoueur2 = probabilites[1];
    }
    return probabiliteJoueur2;
  }

  
    
}