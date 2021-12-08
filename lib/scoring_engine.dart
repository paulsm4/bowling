class ScoringEngine {
  // public members
  static const int nFrames = 10;  // 10-frame game
  List<String> throws = List.generate(21, (i) => "");  // 10 frames * 2 throws/frame + 3 throws final frame
  List<int> frameScores = [];  // "Current score" will be null a) at game start, b) for next throw (if spare), c) for next two throws (if strike)
  int pinsStanding = 10;  // Reset to "10" at start of each frame
  int ball = 1;  // Reset to "1" at start of each frame
  int frame = 1; //      "    "
  bool gameOver = false;
  int _idx = 0;

  void throwBall(int pinsDown) {
    //print (">>throwBall: pinsDown=$pinsDown...");

    // Sanity check: game over?
    if (gameOver)  return;

    // Save the current index into "throws"; compute pinfall
    var initialIdx = _idx;
    pinsStanding -= pinsDown;

    // Mark the ball score for this throw and update _idx for next throw
    if (pinsStanding == 0) {
      if (ball == 1 || ball == 3) {
        // ... Ball 1 or ball 3: always "Strike"
        throws[_idx++] = 'X';
        if (!_is10thFrame(initialIdx))  _idx++;
      } else {
        // ... Ball 2: if 10th frame, could be either "strike" or "spare"
        throws[_idx++] = (throws[initialIdx-1] == 'X') ? 'X' : '/';
      }
    } else {
      // ... Not a strike or a spare
      throws[_idx++] = pinsDown.toString();
    }

    // Update ball count, frame count and reset pins as needed for next throw
    if (!_is10thFrame(initialIdx))
    {
      if ((pinsStanding == 0) || (++ball > 2))  _nextFrame();
    } else {
      ++ball;
      if (pinsStanding == 0)  pinsStanding = 10;
    }

    // Finally, update all available scores
    _getAvailableScores(frameScores.length * 2, initialIdx);
  }

  bool _is10thFrame(int idx) {
    var retval = idx >= (nFrames-1)*2;
    return retval;
  }

  void _nextFrame() {
      frame++;
      pinsStanding = 10;
      ball = 1;
  }

  void  _getAvailableScores(int nextIndex, int maxIndex) {
    while (nextIndex < maxIndex) {
      // Get score for this frame
      int score = 0;
      if (throws[nextIndex] == 'X') {
        if ((score = _getNextTwoBalls(nextIndex, maxIndex)) < 0) return;
        score += 10;
      } else if (throws[nextIndex+1] == '/') {
        if ((score = _getNextBall(nextIndex+1, maxIndex)) < 0) return;
        // Count both balls in spare as "10"
        score += 10;
      } else if (nextIndex+1 <= maxIndex) {
        score = int.parse(throws[nextIndex]) + int.parse(throws[nextIndex+1]);
      }

      // Accumulate scores from previous frame(s)
      if (frameScores.isNotEmpty) score += frameScores[frameScores.length-1];

      // Add this frame to the liste
      frameScores.add(score);

      // Check for "game over"
      if (frameScores.length == nFrames) {
        gameOver = true;
        return;
      }

      // Continue on to next unscored frame (if any)
      if (_is10thFrame(nextIndex)) {
        nextIndex++;
      } else {
        nextIndex += 2;
      }
    }
  }

  int _getNextTwoBalls(int currentIndex, int maxIndex) {
    int score = 0;
    currentIndex = !_is10thFrame(currentIndex) ? currentIndex + 2 : currentIndex + 1;
    for (int i=0; i < 2; i++) {
      if (currentIndex > maxIndex) return -1;
      if (throws[currentIndex] == 'X') {
        score += 10;
        currentIndex = !_is10thFrame(currentIndex) ? currentIndex + 2 : currentIndex + 1;
      } else if (throws[currentIndex+1] == '/') {
        return 10;
      } else {
        score += int.parse(throws[currentIndex]);
        currentIndex++;
      }
    }
    return score;
  }

  int _getNextBall(int currentIndex, int maxIndex) {
      if (++currentIndex > maxIndex) return -1;
      if (throws[currentIndex] == 'X') return 10;
      return int.parse(throws[currentIndex]);
  }

}