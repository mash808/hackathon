import 'package:flutter/material.dart';
import 'package:hackathon_app/column_wrapper.dart';

class Quests extends StatefulWidget {
  const Quests({Key? key}) : super(key: key);

  @override
  State<Quests> createState() => _QuestsState();
}

class _QuestsState extends State<Quests> {
  Color myBoxColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return ColumnWrapper(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Image.asset('images/quests_screen_banner.png', scale: 0.8),
          ),
        ],
      ),
    );
  }
}
