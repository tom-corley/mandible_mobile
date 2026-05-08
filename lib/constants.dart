import 'package:flutter/material.dart';

enum Player {
  white(Colors.white),
  black(Colors.black);

  const Player(this.color);

  final Color color;
}

enum PieceType {
  queenBee('Q', Colors.amber),
  beetle('B', Colors.purple),
  grasshopper('G', Colors.green),
  spider('S', Colors.brown),
  ant('A', Colors.blue),
  ladybug('L', Colors.red),
  mosquito('M', Colors.grey),
  pillbug('P', Colors.teal);

  const PieceType(this.label, this.color);

  final String label;
  final Color color;
}

// Number of each piece type per player in the standard Hive game.
const Map<PieceType, int> standardCounts = {
  PieceType.queenBee: 1,
  PieceType.beetle: 2,
  PieceType.grasshopper: 3,
  PieceType.spider: 2,
  PieceType.ant: 3,
};

// Extended set including the Ladybug, Mosquito, and Pillbug expansions.
const Map<PieceType, int> fullCounts = {
  PieceType.queenBee: 1,
  PieceType.beetle: 2,
  PieceType.grasshopper: 3,
  PieceType.spider: 2,
  PieceType.ant: 3,
  PieceType.ladybug: 1,
  PieceType.mosquito: 1,
  PieceType.pillbug: 1,
};
