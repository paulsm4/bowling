import 'package:flutter/material.dart';
import './game_page.dart';

void main() {
  runApp(BowlingApp());
}

// ignore: use_key_in_widget_constructors
class BowlingApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GamePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
