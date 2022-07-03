import 'package:flutter/material.dart';

class BoardTile extends StatefulWidget {
  const BoardTile({super.key});

  @override
  State<BoardTile> createState() => _BoardTileState();
}

class _BoardTileState extends State<BoardTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.blue,
        child: Center(child: Text("?")),
      ),
    );
  }
}
