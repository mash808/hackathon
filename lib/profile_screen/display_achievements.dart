import 'package:flutter/material.dart';
import 'package:hackathon_app/models/main_quest.dart';
import 'package:hackathon_app/models/sub_task_model.dart';
import 'package:hackathon_app/profile_screen/profile.dart';
import 'package:hackathon_app/side_quest_screen/side_quests.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class DisplayAchievements extends StatelessWidget {
  Box<MainQuestModel> mainQuestDb;
  DisplayAchievements({Key? key, required this.mainQuestDb}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: mainQuestDb.listenable(),
      builder: (context, Box<MainQuestModel> items, _) {
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
                achievementCount: 5, imageAddress: 'images/hard_boss.png'),
            AchievementIcon(
                achievementCount: 5, imageAddress: 'images/medium_boss.png'),
            AchievementIcon(
                achievementCount: 5, imageAddress: 'images/easy_boss.png'),
            AchievementIcon(
                achievementCount: 5, imageAddress: 'images/very_easy_boss.png'),
            AchievementIcon(
                achievementCount: 15,
                imageAddress: 'images/side_quests_achievement.png')
          ],
        );
      },
    );
  }
}
