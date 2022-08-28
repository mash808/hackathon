import 'package:flutter/material.dart';
import 'package:hackathon_app/ValueListenableBuilder2.dart';
import 'package:hackathon_app/models/main_quest.dart';
import 'package:hackathon_app/models/sub_task_model.dart';
import 'package:hackathon_app/profile_screen/profile.dart';
import 'package:hackathon_app/side_quest_screen/side_quests.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class DisplayAchievements extends StatelessWidget {
  Box<MainQuestModel> mainQuestDb;
  Box<SubTaskModel> sideQuestDb;
  DisplayAchievements(
      {Key? key, required this.mainQuestDb, required this.sideQuestDb})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder2(
      valueListenable1: mainQuestDb.listenable(),
      valueListenable2: sideQuestDb.listenable(),
      builder:
          (context, Box<MainQuestModel> items, Box<SubTaskModel> items2, _) {
        List<int> keys = items.keys.cast<int>().toList();
        return Wrap(
          alignment: WrapAlignment.center,
          spacing: 50.0,
          runSpacing: 5.0,
          children: [
            AchievementIcon(
                imageAddress: 'images/very_hard_boss.png',
                achievementCount: items.values
                    .where((MainQuestModel) =>
                        MainQuestModel.mainQuestIconPath ==
                            "images/very_hard_boss.png" &&
                        MainQuestModel.completed)
                    .length),
            AchievementIcon(
                achievementCount: items.values
                    .where((MainQuestModel) =>
                        MainQuestModel.mainQuestIconPath ==
                            "images/hard_boss.png" &&
                        MainQuestModel.completed)
                    .length,
                imageAddress: 'images/hard_boss.png'),
            AchievementIcon(
                achievementCount: items.values
                    .where((MainQuestModel) =>
                        MainQuestModel.mainQuestIconPath ==
                            "images/medium_boss.png" &&
                        MainQuestModel.completed)
                    .length,
                imageAddress: 'images/medium_boss.png'),
            AchievementIcon(
                achievementCount: items.values
                    .where((MainQuestModel) =>
                        MainQuestModel.mainQuestIconPath ==
                            "images/easy_boss.png" &&
                        MainQuestModel.completed)
                    .length,
                imageAddress: 'images/easy_boss.png'),
            AchievementIcon(
                achievementCount: items.values
                    .where((MainQuestModel) =>
                        MainQuestModel.mainQuestIconPath ==
                            "images/very_easy_boss.png" &&
                        MainQuestModel.completed)
                    .length,
                imageAddress: 'images/very_easy_boss.png'),
            AchievementIcon(
                achievementCount: items2.values
                    .where((SubTaskModel) => SubTaskModel.completed)
                    .length,
                imageAddress: 'images/side_quests_achievement.png')
          ],
        );
      },
    );
  }
}
