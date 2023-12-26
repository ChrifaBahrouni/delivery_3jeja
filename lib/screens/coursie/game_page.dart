import 'package:flutter/material.dart';

class Game_page extends StatefulWidget {
  const Game_page({super.key});

  @override
  State<Game_page> createState() => _Game_pageState();
}

class _Game_pageState extends State<Game_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const  Text(" Gamification page "),
    );
  }
}
