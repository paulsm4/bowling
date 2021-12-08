import 'package:flutter/material.dart';
import './scoring_engine.dart';
//import './test_wrap.dart';
import './display_scores.dart';
import './user_input.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  var gameState = new ScoringEngine();
  double screenWidth = 0.0;
  double screenHeight = 0.0;
  //int lowerBoundX, upperBoundX, lowerBoundY, upperBoundY;

  void resetGame () {
    setState(() => gameState = new ScoringEngine());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    // Tests
    //for (int i=0; i < 10; i++) { // No strikes/spares
    //   gameState.throwBall(3);
    //   gameState.throwBall(3);
    //}
    //for (int i=0; i < 9; i++) {  // All spares
    //   gameState.throwBall(3);
    //   gameState.throwBall(7);
    //}
    //gameState.throwBall(3); 
    //gameState.throwBall(7);
    //gameState.throwBall(10);
    //for (int i=0; i < 9; i++) { // All strikes
    //   gameState.throwBall(10);
    //}
    //gameState.throwBall(10);
    //gameState.throwBall(10);
    //gameState.throwBall(10);

    return Scaffold(
      appBar: AppBar(
        title: Text("Bowling App"),
      ),
      body: Column(children: [
        Container(child:  UserInput(
            gameState.pinsStanding,
            gameState.gameOver,
            (int nPins) { setState(() => gameState.throwBall(nPins)); },
            resetGame,
          ),
        ),
        Container(child: DisplayScores(gameState)),
      ]),
    );
  }

}


