import 'package:flutter/material.dart';

class BoardTile extends StatefulWidget {
  final List position;

  const BoardTile({super.key, required this.position});

  @override
  State<BoardTile> createState() => _BoardTileState();
}

class _BoardTileState extends State<BoardTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        color: Colors.blue,
        child: Center(child: Text("${widget.position}")),
      ),
    );
  }
}
