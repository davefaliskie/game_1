import 'dart:math';
import 'package:flutter/material.dart';
import 'package:game_template/src/game_internals/board_setting.dart';
import 'package:game_template/src/game_internals/tile.dart';

enum TileOwner {
  blank,
  player,
  ai
}

class BoardState extends ChangeNotifier {
  final BoardSetting boardSetting;
  // the current state of the board will be determined by these two lists.
  final List<Tile> playerTaken = [];
  final List<Tile> aiTaken = [];

  BoardState({required this.boardSetting});

  // set the tile color based on the given tile's coordinates
  Color tileColor(Tile tile) {
    if (getTileOwner(tile) == TileOwner.player) {
      return Colors.amber;
    } else if (getTileOwner(tile) == TileOwner.ai) {
      return Colors.redAccent;
    } else {
      return Colors.lightGreenAccent;
    }
  }

  // the action called when a tile is clicked.
  void makeMove(Tile tile) {
    Tile? newTileCord = evaluateMove(tile);
    if (newTileCord == null) {
      //TODO give feedback that the choice can't work
      return;
    }
    playerTaken.add(newTileCord);

    // TODO check if won

    makeAiMove();
    notifyListeners();
  }

  // Return the coordinates of the tile that should become active by the recent move.
  // This is the key game logic, clicking on tile [5,3] should activate [1,3]
  // assuming there are no other active tiles in the 3rd column.
  Tile? evaluateMove(Tile tile) {
    //loop over number of rows and find the lowest blank row in the column
    for (var bRow = 1; bRow < boardSetting.rows + 1; bRow++) {
      var evalCord = Tile(col: tile.col, row: bRow);
      if (getTileOwner(evalCord) == TileOwner.blank) {
        return evalCord;
      }
    }
    return null;
  }

  void makeAiMove() {
    // Get all the Coordinates that are available and pick a random one.
    List<Tile> available = [];
    for (var row = 1; row < boardSetting.rows + 1; row++) {
      for (var col = 1; col < boardSetting.cols + 1; col++) {
        Tile cord = Tile(col: col, row: row);
        if (getTileOwner(cord) == TileOwner.blank) {
          available.add(cord);
        }
      }
    }

    if (available.isEmpty) { return; }

    // We know the Coordinate will be available because we already checked.
    // this is making sure it's at the bottom of the column.
    Tile aiCord = evaluateMove(available[Random().nextInt(available.length)])!;
    aiTaken.add(aiCord);
  }

  // reset the board to the blank state
  void clearBoard() {
    playerTaken.clear();
    aiTaken.clear();
    notifyListeners();
  }

  TileOwner getTileOwner(Tile tile) {
    if (playerTaken.contains(tile)) {
      return TileOwner.player;
    } else if (aiTaken.contains(tile)) {
      return TileOwner.ai;
    } else {
      return TileOwner.blank;
    }
  }
}