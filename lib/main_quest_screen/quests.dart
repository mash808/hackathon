import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathon_app/column_wrapper.dart';
import 'package:hackathon_app/models/sub_task_model.dart';
import 'package:hackathon_app/side_quest_screen/display_sub_quests.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class Quests extends StatefulWidget {
  const Quests({Key? key}) : super(key: key);

  @override
  State<Quests> createState() => _QuestsState();
}

class _QuestsState extends State<Quests> {
  // var mainQuestBox = Hive.box('mainQuestDb');
  Box<SubTaskModel> sideQuestDB = Hive.box('sideQuestDB');

  @override
  Widget build(BuildContext context) {
    return ColumnWrapper(
      child: Column(
        children: [],
      ),
    );
  }
}

class addMainQuests extends StatelessWidget {
  const addMainQuests({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {}, child: Image.asset('images/add_quest.png'));
  }
}
