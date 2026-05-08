# CustomPaint

When built-in widgets aren't enough — drawing shapes, game graphics, charts — you drop down to `CustomPaint`. It gives you direct access to a 2D canvas, like the HTML `<canvas>` API.

---

## Basic structure

```dart
CustomPaint(
  size: const Size(200, 200),   // how much space to occupy
  painter: MyPainter(),
)
```

The `painter` is a class that extends `CustomPainter` and implements two methods:

```dart
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // draw here
  }

  @override
  bool shouldRepaint(MyPainter old) => false; // return true if inputs changed
}
```

---

## Canvas API

```dart
final paint = Paint()
  ..color = Colors.blue
  ..style = PaintingStyle.fill    // fill or stroke
  ..strokeWidth = 2.0;

canvas.drawRect(Rect.fromLTWH(0, 0, 100, 100), paint);
canvas.drawCircle(Offset(50, 50), 30, paint);
canvas.drawLine(Offset(0, 0), Offset(100, 100), paint);
```

`..` is Dart's cascade — it calls methods on the same object, returning the object itself. Equivalent to chaining setters.

---

## Drawing paths (arbitrary shapes)

```dart
final path = Path();
path.moveTo(0, 0);
path.lineTo(100, 0);
path.lineTo(50, 87);
path.close();                    // connect back to start

canvas.drawPath(path, Paint()..color = Colors.green);
```

This is how `Hexagon` draws its six-sided shape — it loops over the 6 vertex angles and builds a path.

---

## shouldRepaint

```dart
@override
bool shouldRepaint(MyPainter old) => color != old.color || size != old.size;
```

Return `true` if the visual output could have changed since the last paint. Flutter skips calling `paint()` if this returns `false`. Like `shouldComponentUpdate` in class components — or the dep array in `useMemo`.

Pass mutable inputs through the constructor so you can compare them here:

```dart
class MyPainter extends CustomPainter {
  final Color color;
  const MyPainter({required this.color});

  @override
  bool shouldRepaint(MyPainter old) => color != old.color;
  ...
}
```

---

## Coordinate system

- Origin `(0, 0)` is **top-left**
- `x` increases rightward, `y` increases **downward** (same as browser canvas)
- `size` in `paint(Canvas canvas, Size size)` is the paint area — use it to compute centers

```dart
final cx = size.width / 2;
final cy = size.height / 2;
```

---

## Layering

Multiple `drawX` calls paint in order — later calls paint over earlier ones. So draw fill first, then stroke on top:

```dart
canvas.drawPath(path, Paint()..color = color);                           // fill
canvas.drawPath(path, Paint()..style = PaintingStyle.stroke             // outline on top
                            ..strokeWidth = 3.0
                            ..color = Colors.black);
```

---

## CustomPaint vs built-in widgets

Use built-in widgets (Container, Row, Text, etc.) for anything they can express — they're faster to write and easier to maintain. Drop into CustomPaint when you need:
- Arbitrary shapes (hexagons, curves, game graphics)
- Per-pixel control
- Animations driven by raw math
