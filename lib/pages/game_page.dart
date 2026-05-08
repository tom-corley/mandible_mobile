import 'package:flutter/material.dart';
import '../widgets/board.dart';
import '../models.dart';
import '../constants.dart';

const _samplePieces = [
  // White
  Piece(q: 0, r: 0, player: Player.white, type: PieceType.grasshopper),
  Piece(q: -1, r: 0, player: Player.white, type: PieceType.queenBee),
  // Black
  Piece(q: 1, r: 1, player: Player.black, type: PieceType.queenBee),
  Piece(q: 0, r: 1, player: Player.black, type: PieceType.ant),
];

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Mandible'),
      ),
      backgroundColor: const Color.fromARGB(255, 226, 234, 198),
      body: const Board(pieces: _samplePieces),
    );
  }
}
