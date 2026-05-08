# Widgets for React Devs

The core mental model: **everything in Flutter is a widget**. Widgets are the equivalent of React components — they describe what to render, and Flutter handles the diffing and updating.

---

## StatelessWidget = functional component

```dart
class Greeting extends StatelessWidget {
  final String name;

  const Greeting({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text("Hello, $name");
  }
}
```

React equivalent:
```tsx
function Greeting({ name }: { name: string }) {
  return <span>Hello, {name}</span>;
}
```

- `build()` = `return (...)` in React
- Props are just constructor parameters
- `const` constructor = `React.memo` — Flutter can skip rebuilding it if nothing changed

---

## StatefulWidget = component with useState

Flutter splits stateful components into two classes: the widget (immutable config) and the state (mutable).

```dart
class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("$_count"),
      ElevatedButton(onPressed: _increment, child: const Text("+")),
    ]);
  }
}
```

React equivalent:
```tsx
function Counter() {
  const [count, setCount] = useState(0);
  return (
    <div>
      <span>{count}</span>
      <button onClick={() => setCount(c => c + 1)}>+</button>
    </div>
  );
}
```

- `setState(() { ... })` triggers a rebuild, like calling the setter from `useState`
- The mutation happens *inside* the `setState` callback
- `_CounterState` has access to `widget.someProperty` to read the widget's props

---

## BuildContext

`BuildContext` is passed to `build()` and is used to:
- Read inherited data (Theme, MediaQuery, etc.) — like React Context
- Navigate

```dart
Theme.of(context).colorScheme.primary   // like useContext(ThemeContext)
MediaQuery.of(context).size             // screen size
```

Don't store `context` — it can become stale (same rule as React ref patterns).

---

## Widget tree vs JSX

Flutter has no JSX. You nest widget constructors directly:

```dart
// Flutter
Padding(
  padding: const EdgeInsets.all(16),
  child: Column(
    children: [
      Text("Title"),
      Text("Subtitle"),
    ],
  ),
)
```

```tsx
// React
<div style={{ padding: 16 }}>
  <span>Title</span>
  <span>Subtitle</span>
</div>
```

Flutter is more verbose but fully type-safe — no JSX parser needed.

---

## Keys

Flutter `Key` works like React `key` — helps Flutter reconcile widget identity when lists reorder.

```dart
ListView(children: [
  for (final item in items)
    MyWidget(key: ValueKey(item.id), data: item),
])
```

Same rule as React: use a stable ID, not an index, when order can change.

---

## Lifecycle

| React | Flutter (State) |
|---|---|
| mount / first render | `initState()` |
| render | `build()` |
| props/state changed | `didUpdateWidget()` / `setState` triggers `build` |
| unmount | `dispose()` |

For StatelessWidget there is no lifecycle — just `build()`.

---

## Composition

Flutter has no slots or `children` prop pattern like React. Instead, widgets either accept:
- `child: Widget` — single child
- `children: List<Widget>` — multiple children

```dart
Column(children: [widget1, widget2])
Container(child: Text("hi"))
```

This is equivalent to React's `children` prop, just made explicit per widget.
