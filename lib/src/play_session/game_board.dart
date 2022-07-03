import 'package:flutter/material.dart';
import 'package:game_template/src/play_session/board_tile.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  final boardRows = 5;
  final boardCols = 7;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: boardCols,
              children: [
                for (var x = 0; x < boardRows * boardCols; x++)
                  BoardTile(),
              ],
            ),
          ),
          Text("Make Your Move"),
        ],
      ),
    );
  }
}
