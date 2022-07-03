class BoardSetting {
  final int cols;
  final int rows;

  const BoardSetting(
      {required this.cols,
      required this.rows});

  int totalTiles() {
    return cols * rows;
  }

  List<int> tilePosition(int boardIndex) {

    // int x = ((boardIndex + 1) / cols).ceil();
    // int y = ((rows * cols) + 1) - ((rows * cols) - boardIndex);

    int column = (boardIndex % cols).ceil() + 1;
    int row = ((boardIndex + 1) / cols).ceil();
    return [column, row];
  }


  // @override
  // int get hashCode => Object.hash(cols, rows);
  //
  // @override
  // bool operator ==(Object other) {
  //   return other is BoardSetting &&
  //       other.cols == cols &&
  //       other.rows == rows &&
  //       other.tiles == tiles;
  // }
}
