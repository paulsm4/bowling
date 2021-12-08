// ignore_for_file: unnecessary_new

import 'package:test/test.dart';
import 'package:bowling/scoring_engine.dart';

void main () {
  print(">>game_mixed_test...");

  var throws1 = [10, 10, 10, 10, 10, 10, 10, 10, 10, 3,7,10 ];
  var expectedBalls1 = [
    'X', '',      // Frame 1
    'X', '',      //    "  2
    'X', '',      //    "  3  
    'X', '',      //    "  4  
    'X', '',      //    "  5  
    'X', '',      //    "  6  
    'X', '',      //    "  7  
    'X', '',      //    "  8  
    'X', '',      //    "  9  
    '3', '/', 'X' //    "  10  
  ];
  var expectedScores1 = [30, 60, 90, 120, 150, 180, 210, 233, 253, 273 ];

  var throws2 = [10, 3,7, 10, 10, 10, 10, 10, 10, 10, 10,10,10 ];
  var expectedBalls2 = [
    'X', '',      // Frame 1
    '3','/',      //    "  2
    'X', '',      //    "  3  
    'X', '',      //    "  4  
    'X', '',      //    "  5  
    'X', '',      //    "  6  
    'X', '',      //    "  7  
    'X', '',      //    "  8  
    'X', '',      //    "  9  
    'X', 'X', 'X' //    "  10  
  ];
  var expectedScores2 = [20, 40, 70, 100, 130, 160, 190, 220, 250, 280 ];

  test('test mixed strikes/spares', () {
    expect(ScoringEngine.nFrames, 10);

    ScoringEngine game = new ScoringEngine();
    for (int i=0; i < throws1.length-1; i++) {
      game.throwBall(throws1[i]);
    }
    expect(game.gameOver, false);
    game.throwBall(throws1[throws1.length-1]);
    expect(game.gameOver, true);

    for (int i=0; i < game.throws.length; i++) {
      expect (game.throws[i], expectedBalls1[i]);
    }

    expect(game.frameScores.length, 10);
    for (int i=0; i < 10; i++) {
      expect(game.frameScores[i], expectedScores1[i]);
    }

    game = new ScoringEngine();
    expect(game.gameOver, false);

    for (int i=0; i < throws2.length-1; i++) {
      game.throwBall(throws2[i]);
    }
    expect(game.gameOver, false);
    game.throwBall(throws2[throws2.length-1]);
    expect(game.gameOver, true);

    for (int i=0; i < game.throws.length; i++) {
      expect (game.throws[i], expectedBalls2[i]);
    }

    expect(game.frameScores.length, 10);
    for (int i=0; i < 10; i++) {
      expect(game.frameScores[i], expectedScores2[i]);
    }


  });
}
