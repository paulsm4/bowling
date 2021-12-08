import 'package:test/test.dart';
import 'package:bowling/scoring_engine.dart';

ScoringEngine Play () {
  var game = new ScoringEngine();
  // No strikes/spares
  for (int i=0; i < 10; i++) { 
    game.throwBall(3);
    game.throwBall(3);
  }
  return game;
}

void main () {
  print(">>game_no_strikes_test...");

  var expectedBalls = [
    '3', '3',    // Frame 1
    '3', '3',    //    "  2
    '3', '3',    //    "  3  
    '3', '3',    //    "  4  
    '3', '3',    //    "  5  
    '3', '3',    //    "  6  
    '3', '3',    //    "  7  
    '3', '3',    //    "  8  
    '3', '3',    //    "  9  
    '3', '3', '' //    "  10  
  ];

  var expectedScores = [6, 12, 18, 24, 30, 36, 42, 48, 54, 60 ];

  test('test no strikes', () {
    expect(ScoringEngine.nFrames, 10);

    var game = Play();

    for (int i=0; i < game.throws.length; i++) {
      expect (game.throws[i], expectedBalls[i]);
    }

    expect(game.frameScores.length, 10);
    for (int i=0; i < 10; i++) {
      expect(game.frameScores[i], expectedScores[i]);
    }
  });
}
