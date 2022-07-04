import 'package:game_template/src/game_internals/board_setting.dart';
import 'package:game_template/src/game_internals/coordinate.dart';

class Tile {
  final BoardSetting boardSetting;
  final int boardIndex;

  Tile(this.boardSetting, this.boardIndex);

  int row() {
    return boardSetting.rows - ((boardIndex + 1) / boardSetting.cols).ceil() + 1;
  }

  int col() {
    return (boardIndex % boardSetting.cols).ceil() + 1;
  }

  Coordinate coordinate() {
    return Coordinate(row: row(), col: col());
  }
}