import 'package:flutter/material.dart';
import 'package:hackathon_app/models/sub_task_model.dart';
import 'package:hive/hive.dart';

part 'main_quest.g.dart';

@HiveType(typeId: 1)
class MainQuestModel {
  // final int id;
  @HiveField(0)
  final String mainQuestIconPath;
  @HiveField(1)
  final String mainQuestName;
  @HiveField(2)
  final List<SubTaskModel> subTasks;
  @HiveField(3)
  final int exp;
  @HiveField(4)
  final bool completed;

  MainQuestModel({
    // required this.id,
    required this.mainQuestIconPath,
    required this.mainQuestName,
    required this.subTasks,
    required this.exp,
    required this.completed,
  });
}
