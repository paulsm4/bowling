import 'package:test/test.dart';
import 'package:bowling/scoring_engine.dart';

void main () {
  print(">>game_all_spares_test...");

  var throws = [3,7, 3,7, 3,7, 3,7, 3,7, 3,7, 3,7, 3,7, 3,7, 3,7,3 ];
   
  var expectedBalls = [
    '3', '/',     // Frame 1
    '3', '/',     //    "  2
    '3', '/',     //    "  3  
    '3', '/',     //    "  4  
    '3', '/',     //    "  5  
    '3', '/',     //    "  6  
    '3', '/',     //    "  7  
    '3', '/',     //    "  8  
    '3', '/',     //    "  9  
    '3', '/', '3' //    "  10  
  ];

  var expectedScores = [13, 26, 39, 52, 65, 78, 91, 104, 117, 130 ];

  test('test all spares', () {
    expect(ScoringEngine.nFrames, 10);

    ScoringEngine game = new ScoringEngine();
    // All spares
    for (int i=0; i < throws.length-1; i++) {
      game.throwBall(throws[i]);
    }
    expect(game.gameOver, false);
    game.throwBall(throws[throws.length-1]);
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
