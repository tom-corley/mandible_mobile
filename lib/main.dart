import 'package:flutter/material.dart';
import 'widgets/board.dart';
import 'models.dart';
import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: const Color.fromARGB(255, 237, 158, 21),
        ),
      ),
      home: const MyHomePage(title: 'Mandible Mobile'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const _samplePieces = [
  // White
  Piece(q: 0, r: 0, player: Player.white, type: PieceType.grasshopper),
  Piece(q: -1, r: 0, player: Player.white, type: PieceType.queenBee),
  // Black
  Piece(q: 1, r: 1, player: Player.black, type: PieceType.queenBee),
  Piece(q: 0, r: 1, player: Player.black, type: PieceType.ant),
];

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      backgroundColor: const Color.fromARGB(255, 226, 234, 198),
      body: const Board(pieces: _samplePieces),
    );
  }
}
