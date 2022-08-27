import 'package:flutter/material.dart';
import 'package:hackathon_app/models/sub_task_model.dart';

class MainQuest {
  final int id;
  final Image mainQuestIcon;
  final String mainQuestName;
  final List<SubTaskModel> subTasks;
  final int exp;
  final bool completed;

  MainQuest({
    required this.id,
    required this.mainQuestIcon,
    required this.mainQuestName,
    required this.subTasks,
    required this.exp,
    required this.completed,
  });
}
