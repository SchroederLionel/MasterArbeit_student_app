class Score {
  int _numberOfResponsesRight = 0;

  void updateScore(bool wasRight) {
    if (wasRight) {
      _numberOfResponsesRight++;
    }
  }

  int get numberOfResponsesRight => _numberOfResponsesRight;
}
