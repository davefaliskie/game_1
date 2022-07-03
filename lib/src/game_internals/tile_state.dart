import 'package:game_template/src/game_internals/board_setting.dart';

class TileState {
  final BoardSetting boardSetting;
  final int boardIndex;


  TileState(this.boardSetting, this.boardIndex);

  int row() {
    return boardSetting.rows - ((boardIndex + 1) / boardSetting.cols).ceil() + 1;
  }

  int col() {
    return (boardIndex % boardSetting.cols).ceil() + 1;
  }

  List<int> coordinates() {
    return [row(), col()];
  }

}