class Coordinate {
  final int col;
  final int row;

  Coordinate({required this.col, required this.row});

  List<int> asList() {
    return [col, row];
  }
}