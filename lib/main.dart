import 'package:flutter/material.dart';
import 'package:hackathon_app/quests.dart';
import 'package:hackathon_app/side_quests.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHome(),
      routes: {
        '/quests': (context) => const Quests(),
        '/side_quests': (context) => const SideQuests()
      },
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hackathon Project'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/quests");
          },
          onDoubleTap: () {
            Navigator.pushNamed(context, '/side_quests');
          },
          child: Container(
            width: 100,
            height: 100,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
