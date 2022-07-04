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
  List<Tile> winTiles = [];

  final ChangeNotifier playerWon = ChangeNotifier();

  BoardState({required this.boardSetting});

  // reset the board to the blank state
  void clearBoard() {
    playerTaken.clear();
    aiTaken.clear();
    notifyListeners();
  }

  // set the tile color based on the given tile's coordinates
  Color tileColor(Tile tile) {
    if (winTiles.contains(tile)) {
      return Colors.yellow;
    } else if (getTileOwner(tile) == TileOwner.player) {
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

    // check if player won
    bool didWin = checkWin(newTileCord);
    print("DID PLAYER WIN? $didWin");
    if (didWin == true) {
      playerWon.notifyListeners();
      notifyListeners();
      return;
    }

    // TODO add a slight delay and lock the board.
    makeAiMove();
    // TODO check if AI won.
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

  TileOwner getTileOwner(Tile tile) {
    if (playerTaken.contains(tile)) {
      return TileOwner.player;
    } else if (aiTaken.contains(tile)) {
      return TileOwner.ai;
    } else {
      return TileOwner.blank;
    }
  }

  // checks for win and add winning tiles to winTiles.
  // returns true if the playTile caused a win.
  bool checkWin(Tile playTile) {
    var takenTiles = (getTileOwner(playTile) == TileOwner.player) ? playerTaken : aiTaken;

    // check vertical
    List<Tile>? vertical = verticalCheck(playTile, takenTiles);
    if (vertical != null) {
      winTiles = vertical;
      return true;
    }

    // check horizontal
    List<Tile>? horizontal = horizontalCheck(playTile, takenTiles);
    if (horizontal != null) {
      winTiles = horizontal;
      return true;
    }

    // TODO check left diagonal

    // TODO check right diagonal

    return false;
  }

  List<Tile>? verticalCheck(Tile playTile, List<Tile> takenTiles) {
    List<Tile> tempWinTiles = [];

    // test only vertical wins, start at playTile row and move down.
    for (var row = playTile.row; row > 0; row--) {
      Tile tile = Tile(col: playTile.col, row: row);

      if (takenTiles.contains(tile)) {
        tempWinTiles.add(tile);
      } else {
        break;
      }
    }

    // see if tempWinTiles meets the win condition, if so it's a win
    if (tempWinTiles.length >= boardSetting.winCondition) {
      return tempWinTiles;
    }

    return null;
  }

  List<Tile>? horizontalCheck(Tile playTile, List<Tile> takenTiles) {
    // add the play tile to the list
    List<Tile> tempWinTiles = [playTile];

    // Look left, unless playTile is the first tile.
    // Start at playTile.col - 1
    if (playTile.col > 1) {
      for (var col = playTile.col - 1; col > 0; col--) {
        Tile tile = Tile(col: col, row: playTile.row);

        if (takenTiles.contains(tile)) {
          tempWinTiles.add(tile);
        } else {
          break;
        }
      }
    }

    // Look right, unless playTile is the last tile.
    // Start at playTile.col + 1
    if (playTile.col < boardSetting.cols) {
      for (var col = playTile.col + 1; col < boardSetting.cols + 1; col++) {
        Tile tile = Tile(col: col, row: playTile.row);

        if (takenTiles.contains(tile)) {
          tempWinTiles.add(tile);
        } else {
          break;
        }
      }
    }

    // see if tempWinTiles meets the win condition, if so it's a win
    if (tempWinTiles.length >= boardSetting.winCondition) {
      return tempWinTiles;
    }

    return null;
  }
}
