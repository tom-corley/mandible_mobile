# Layout for React Devs

Flutter's layout system is like CSS Flexbox — but the "CSS" is written in Dart as widget properties, and there's no cascade or inheritance.

---

## Row and Column = flexbox

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [Text("left"), Text("right")],
)

Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [Text("top"), Text("bottom")],
)
```

| CSS Flexbox | Flutter |
|---|---|
| `flex-direction: row` | `Row` |
| `flex-direction: column` | `Column` |
| `justify-content` | `mainAxisAlignment` |
| `align-items` | `crossAxisAlignment` |
| `gap` | wrap children in `SizedBox(width/height: N)` or use `gap:` on recent Flutter |

---

## Expanded and Flexible = flex-grow

```dart
Row(children: [
  const SizedBox(width: 100),   // fixed width
  Expanded(child: TextField()), // takes remaining space
])
```

`Expanded` = `flex: 1` in CSS. Wrap any child in `Expanded` to make it fill available space.

`Flexible` is like `Expanded` but won't force the child to fill — it *can* expand up to the available space.

---

## Stack and Positioned = position: absolute

```dart
Stack(
  children: [
    Image.asset("background.png"),           // fills the stack
    Positioned(
      top: 20,
      right: 20,
      child: Icon(Icons.star),               // floated over the image
    ),
  ],
)
```

- `Stack` is the positioned container
- `Positioned` is `position: absolute` with `top/left/right/bottom`
- Children without `Positioned` fill the stack (like `position: relative; width: 100%`)

This is what `Board` uses to place hexagons at computed pixel positions.

---

## SizedBox and Container

```dart
SizedBox(width: 100, height: 50)       // fixed size box (spacer or constraint)
SizedBox.expand()                       // fills all available space

Container(
  width: 200,
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(8),
  ),
  child: Text("hi"),
)
```

`Container` is like a `<div>` with optional padding, margin, background, and border-radius.
`SizedBox` is a simpler, cheaper fixed-size box — prefer it when you only need size.

---

## Padding and Align

```dart
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  child: Text("padded"),
)

Align(
  alignment: Alignment.bottomRight,
  child: Text("corner"),
)

Center(child: Text("centered"))   // shorthand for Align(alignment: Alignment.center)
```

---

## LayoutBuilder = ResizeObserver / container queries

```dart
LayoutBuilder(
  builder: (context, constraints) {
    final width = constraints.maxWidth;
    return width > 600 ? WideLayout() : NarrowLayout();
  },
)
```

Gives you the available size at build time. Used in `Board` to compute the origin point.

---

## Constraints flow down, sizes flow up

Flutter's layout rule: **parent passes constraints to child → child picks its size within those constraints → parent positions child**.

This is why you sometimes need to wrap things in `SizedBox` or `Expanded` — to give a child a constraint it can work with. If a widget gets unbounded constraints (e.g. inside a `ListView`) and tries to fill infinity, it will throw.

---

## InteractiveViewer = pan and pinch-to-zoom

```dart
InteractiveViewer(
  boundaryMargin: const EdgeInsets.all(double.infinity), // no boundary
  minScale: 0.1,
  maxScale: 5.0,
  child: YourContent(),
)
```

Built-in gesture handling for pan and zoom. No library needed. This is what `Board` wraps the hex stack with.
