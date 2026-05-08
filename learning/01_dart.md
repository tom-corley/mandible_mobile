# Dart for React Devs

Dart is a strongly-typed, compiled language. If you know TypeScript, Dart will feel familiar — but stricter and with a few different conventions.

---

## Types and null safety

Dart has sound null safety. Every type is non-nullable by default; you opt into nullable with `?`.

```dart
String name = "Tom";       // never null
String? nickname = null;   // explicitly nullable

nickname?.toUpperCase();   // safe call — returns null if nickname is null
nickname ?? "no nickname"; // fallback if null
nickname!.toUpperCase();   // force unwrap — throws if null (avoid if possible)
```

This is stricter than TypeScript's `strictNullChecks` — the compiler enforces it everywhere.

---

## `final` and `const`

```dart
final name = "Tom";          // assigned once at runtime (like JS const for primitives)
const pi = 3.14159;          // compile-time constant — value must be known at compile time
```

In Flutter you'll see `const` on widget constructors constantly. It tells Flutter the widget never changes, enabling optimisations.

```dart
const Text("hello")   // Flutter can skip rebuilding this — same as React.memo for static output
```

---

## Variables and type inference

```dart
var x = 42;           // inferred as int
var name = "Tom";     // inferred as String
int count = 0;        // explicit
```

---

## Collections

```dart
// List (Array)
final items = [1, 2, 3];
final typed = <String>["a", "b"];
items.map((x) => x * 2).toList();
items.where((x) => x > 1).toList();   // filter

// Map (Object / Record)
final ages = {"Tom": 30, "Alice": 25};
ages["Tom"];          // 30
ages["unknown"];      // null (not a throw)

// Spread and collection-if (great for building widget lists)
final extras = [4, 5];
final all = [1, 2, 3, ...extras, if (true) 6];  // [1, 2, 3, 4, 5, 6]
```

---

## Functions

```dart
// Named
int add(int a, int b) => a + b;

// Fat arrow (single expression)
bool isEven(int n) => n % 2 == 0;

// Anonymous / closure
final double = (int x) => x * 2;

// Named parameters (Flutter uses these everywhere)
void greet({required String name, String greeting = "Hello"}) {
  print("$greeting, $name");
}
greet(name: "Tom");
greet(name: "Tom", greeting: "Hi");
```

Named parameters are like React props — you call them by name, not position.

---

## Classes

```dart
class Point {
  final double x;
  final double y;

  const Point(this.x, this.y);    // shorthand constructor — assigns to fields directly

  double distanceTo(Point other) {
    return ((x - other.x) * (x - other.x) + (y - other.y) * (y - other.y));
  }
}

final p = Point(1.0, 2.0);
p.x;  // 1.0
```

No `this.` needed inside methods (unlike Java). Fields are public by default; prefix with `_` to make private.

---

## Records (tuples)

Dart 3 added records — lightweight anonymous multi-value types.

```dart
(int, int) coords = (3, 5);
final (q, r) = coords;   // destructure

// With named fields
({String name, int age}) person = (name: "Tom", age: 30);
person.name;
```

You'll see `List<(int, int)>` in this project for hex coordinate lists.

---

## Async

Dart async looks exactly like JS:

```dart
Future<String> fetchData() async {
  final result = await someHttpCall();
  return result.body;
}
```

`Future<T>` = `Promise<T>`. `Stream<T>` = async iterator / observable.

---

## String interpolation

```dart
final name = "Tom";
print("Hello, $name");           // simple
print("2 + 2 = ${2 + 2}");       // expression
```

---

## Key differences from TypeScript

| TypeScript | Dart |
|---|---|
| `interface` / `type` | `class` (no structural typing) |
| `Array<T>` | `List<T>` |
| `Record<K,V>` / `Map` | `Map<K,V>` |
| `Promise<T>` | `Future<T>` |
| `undefined` | doesn't exist — use `null` |
| `any` | `dynamic` (avoid it) |
| optional chaining `?.` | same |
| nullish coalescing `??` | same |
