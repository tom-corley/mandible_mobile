import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MandibleApp());
}

class MandibleApp extends StatelessWidget {
  const MandibleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mandible',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 237, 158, 21),
        ),
      ),
      home: const HomePage(),
    );
  }
}
