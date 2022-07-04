import 'package:flutter/material.dart';
import 'package:game_template/src/game_internals/board_setting.dart';
import 'package:provider/provider.dart';

import '../game_internals/board_state.dart';
import '../game_internals/tile.dart';

class BoardTile extends StatefulWidget {
  final int boardIndex;
  final BoardSetting boardSetting;

  const BoardTile({super.key, required this.boardIndex, required this.boardSetting});

  @override
  State<BoardTile> createState() => _BoardTileState();
}

class _BoardTileState extends State<BoardTile> {
  @override
  Widget build(BuildContext context) {
    final tile = Tile.fromBoardIndex(widget.boardIndex, widget.boardSetting);

    return InkResponse(
      onTap: () {
        Provider.of<BoardState>(context, listen: false).makeMove(tile);
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Consumer<BoardState>(
          builder: (context, bordState, child) {
            return Container(
              color: bordState.tileColor(tile),
              child: Center(child: Text(tile.toString())),
            );
          }
        ),
      ),
    );
  }
}
