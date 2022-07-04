import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/game_internals/board_setting.dart';
import 'package:game_template/src/game_internals/coordinate.dart';
import 'package:game_template/src/game_internals/tile.dart';

class BoardState extends ChangeNotifier {
  final BoardSetting boardSetting;
  // the current state of the board will be determined by these two lists.
  final List<Coordinate> playerTaken = [];
  final List<Coordinate> aiTaken = [];

  BoardState({required this.boardSetting});

  // set the tile color based on the given tile's coordinates
  Color tileColor(Coordinate coordinate) {
    if (playerTaken.any((c) => listEquals(c.asList(), coordinate.asList()))) {
      return Colors.amber;
    } else if (aiTaken.any((c) => listEquals(c.asList(), coordinate.asList()))) {
      return Colors.redAccent;
    } else {
      return Colors.lightGreenAccent;
    }
  }

  // the action called when a tile is clicked.
  void makeMove(Tile tile) {
    // skip if the list already has the coordinates.
    // if (playerTaken.contains(tile)) {
    //   return;
    // }
    Coordinate? newTileCord = evaluateMove(tile);
    if (newTileCord == null) {
      return;
    }
    playerTaken.add(newTileCord);
    // TODO make AI move
    notifyListeners();
  }

  // Return the coordinates of the tile that should become active by the recent move.
  // This is the key game logic, clicking on tile [5,3] should activate [1,3]
  // assuming there are no other active tiles in the 3rd column.
  Coordinate? evaluateMove(Tile tile) {
    //loop over number of rows and find the lowest blank row in the column
    for (var row = 1; row < boardSetting.rows + 1; row++) {
      var evalCord = Coordinate(col: tile.col(), row: row);
      if (playerTaken.any((c) => listEquals(c.asList(), evalCord.asList()))) {
        // the tile is already active by the PLAYER
        // TODO will need to also check the AI
        continue;
      } else {
        return evalCord;
      }
    }
    return null;
  }

  // reset the board to the blank state
  void clearBoard() {
    playerTaken.clear();
    aiTaken.clear();
    notifyListeners();
  }
}