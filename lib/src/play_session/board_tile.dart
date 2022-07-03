import 'package:flutter/material.dart';
import 'package:game_template/src/game_internals/board_setting.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import '../game_internals/board_state.dart';
import '../game_internals/tile_state.dart';

class BoardTile extends StatefulWidget {
  final int boardIndex;
  final BoardSetting boardSetting;

  const BoardTile({super.key, required this.boardIndex, required this.boardSetting});

  @override
  State<BoardTile> createState() => _BoardTileState();
}

class _BoardTileState extends State<BoardTile> {
  List? coordinates;

  @override
  void initState() {
    super.initState();
    coordinates = TileState(widget.boardSetting, widget.boardIndex).coordinates();
  }

  @override
  Widget build(BuildContext context) {
    final tileState = TileState(widget.boardSetting, widget.boardIndex);

    return InkResponse(
      onTap: () {
        Provider.of<BoardState>(context, listen: false).makeMove(tileState.coordinates());
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Consumer<BoardState>(
          builder: (context, bordState, child) {
            return Container(
              color: bordState.tileColor(tileState.coordinates()),
              child: Center(child: Text("${tileState.coordinates()}")),
            );
          }
        ),
      ),
    );
  }
}
