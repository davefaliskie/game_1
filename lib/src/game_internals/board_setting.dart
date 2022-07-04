class BoardSetting {
  final int cols;
  final int rows;

  const BoardSetting(
      {required this.cols,
      required this.rows});

  // The amount of Tiles in a row needed to win
  int get winCondition => 4;

  int totalTiles() {
    return cols * rows;
  }
}
