import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'hexagon.dart';
import '../models.dart';

class Board extends StatelessWidget {
  final List<Piece> pieces;
  final double hexSize;

  const Board({
    super.key,
    required this.pieces,
    this.hexSize = 50,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final origin = Offset(constraints.maxWidth / 2, constraints.maxHeight / 2);
        final hexH = hexSize * math.sqrt(3);

        return InteractiveViewer(
          boundaryMargin: EdgeInsets.zero,
          minScale: 0.3,
          maxScale: 5.0,
          child: SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Stack(
              children: [
                for (final piece in pieces)
                  Positioned(
                    left: Hexagon.pixelCenter(piece.q, piece.r, hexSize).dx + origin.dx - hexSize,
                    top: Hexagon.pixelCenter(piece.q, piece.r, hexSize).dy + origin.dy - hexH / 2,
                    child: Hexagon(
                      q: piece.q,
                      r: piece.r,
                      size: hexSize,
                      player: piece.player,
                      label: piece.type.label,
                      labelColor: piece.type.color,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
