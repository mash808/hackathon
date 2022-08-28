import 'package:hive/hive.dart';
import 'package:hackathon_app/models/main_quest.dart';
import 'package:hackathon_app/models/sub_task_model.dart';

class Boxes {
  static Box<MainQuestModel> getMainQuests() =>
      Hive.box<MainQuestModel>('mainQuestDB');

  static Box<SubTaskModel> getSubTasks() =>
      Hive.box<SubTaskModel>('sideQuestDB');
}
