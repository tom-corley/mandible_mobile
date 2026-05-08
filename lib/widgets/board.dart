import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'hexagon.dart';

class Board extends StatelessWidget {
  final List<(int, int)> hexes;
  final double hexSize;

  const Board({super.key, required this.hexes, this.hexSize = 50});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final origin = Offset(constraints.maxWidth / 2, constraints.maxHeight / 2);
        return InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(double.infinity),
          minScale: 0.1,
          maxScale: 5.0,
          child: SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Stack(
              children: [
                for (final (q, r) in hexes)
                  Builder(builder: (context) {
                    final center = Hexagon.pixelCenter(q, r, hexSize) + origin;
                    return Positioned(
                      left: center.dx - hexSize,
                      top: center.dy - hexSize * math.sqrt(3) / 2,
                      child: Hexagon(q: q, r: r, size: hexSize),
                    );
                  }),
              ],
            ),
          ),
        );
      },
    );
  }
}
