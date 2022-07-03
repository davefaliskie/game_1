import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BoardState extends ChangeNotifier {
  // the current state of the board will be determined by these two lists.
  final List<List<int>> playerTaken = [];
  final List<List<int>> aiTaken = [];

  // set the tile color based on the given tile's coordinates
  Color tileColor(List<int> coordinates) {
    if (playerTaken.any((c) => listEquals(c, coordinates))) {
      return Colors.amber;
    } else if (aiTaken.any((c) => listEquals(c, coordinates))) {
      return Colors.redAccent;
    } else {
      return Colors.lightGreenAccent;
    }
  }

  // the action called when a tile is clicked.
  void makeMove(List<int> coordinates) {
    // skip if the list already has the coordinates.
    if (playerTaken.any((c) => listEquals(c, coordinates))) {
      return;
    }
    playerTaken.add(coordinates);
    notifyListeners();
  }
}