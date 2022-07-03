import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

enum TileState { blank, player, ai }

class BoardTile extends StatefulWidget {
  final List position;
  static final Logger _log = Logger('_BoardTile');

  const BoardTile({super.key, required this.position});

  @override
  State<BoardTile> createState() => _BoardTileState();
}

class _BoardTileState extends State<BoardTile> {
  TileState _tileState = TileState.blank;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () {
        print("${widget.position} was clicked");
        setState(() {
          _tileState = TileState.player;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          color: tileColor(_tileState),
          child: Center(child: Text("${widget.position}")),
        ),
      ),
    );
  }

  Color tileColor(TileState tileState) {
    switch (tileState) {
      case TileState.blank:
        return Colors.white;
      case TileState.player:
        return Colors.amber;
      case TileState.ai:
        return Colors.redAccent;
    }
  }
}
