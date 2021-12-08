import 'package:test/test.dart';
import 'package:bowling/scoring_engine.dart';

void main () {
  print(">>game_all_strikes_test...");

  var expectedBalls = [
    'X', '',      // Frame 1
    'X', '',      //    "  2
    'X', '',      //    "  3  
    'X', '',      //    "  4  
    'X', '',      //    "  5  
    'X', '',      //    "  6  
    'X', '',      //    "  7  
    'X', '',      //    "  8  
    'X', '',      //    "  9  
    'X', 'X', 'X' //    "  10  
  ];

  var expectedScores = [30, 60, 90, 120, 150, 180, 210, 240, 270, 300 ];

  test('test all strikes', () {
    expect(ScoringEngine.nFrames, 10);

    ScoringEngine game = new ScoringEngine();
    // All strikes
    for (int i=0; i < 10; i++) {
      game.throwBall(10);
    }
    expect(game.gameOver, false);
    game.throwBall(10);
    expect(game.gameOver, false);
    game.throwBall(10);
    expect(game.gameOver, true);

    for (int i=0; i < game.throws.length; i++) {
      expect (game.throws[i], expectedBalls[i]);
    }

    expect(game.frameScores.length, 10);
    for (int i=0; i < 10; i++) {
      expect(game.frameScores[i], expectedScores[i]);
    }
  });
}
