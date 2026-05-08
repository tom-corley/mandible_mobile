import 'constants.dart';

class Piece {
  final int q;
  final int r;
  final Player player;
  final PieceType type;

  const Piece({
    required this.q,
    required this.r,
    required this.player,
    required this.type,
  });
}
