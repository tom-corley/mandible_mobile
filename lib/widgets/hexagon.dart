// Dumb stateless widget that draws a hexagon at a given axial coordinate.

import 'dart:math' as math;
import 'package:flutter/material.dart';

class Hexagon extends StatelessWidget {
  final int q;
  final int r;
  final double size;
  final Color color;

  // constructor
  const Hexagon({
    super.key,
    required this.q,
    required this.r,
    required this.size,
    this.color = const Color.fromARGB(255, 205, 204, 146),
  });

  /// Pixel center of the hex at (q, r) relative to an arbitrary origin point.
  /// Use this to position hexagons inside a Stack via Positioned or Transform.
  static Offset pixelCenter(int q, int r, double size) => Offset(
        size * 1.5 * q,
        -size * (math.sqrt(3) / 2 * q + math.sqrt(3) * r),
      );

  // build widget (equivalent to render of a component in React)
  @override
  Widget build(BuildContext context) => CustomPaint(
        painter: _HexPainter(size: size, color: color),
        size: Size(size * 2, size * math.sqrt(3)),
      );
}

class _HexPainter extends CustomPainter {
  final double size;
  final Color color;

  const _HexPainter({required this.size, required this.color});

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final cx = canvasSize.width / 2;
    final cy = canvasSize.height / 2;
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = math.pi / 3 * i;
      final x = cx + size * math.cos(angle);
      final y = cy + size * math.sin(angle);
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, Paint()..color = color);
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0,
    );
  }

  @override
  bool shouldRepaint(_HexPainter old) =>
      size != old.size || color != old.color;
}
