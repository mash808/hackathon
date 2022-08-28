import 'package:flutter/material.dart';
import 'package:hackathon_app/main_quest_screen/main_quest_icon_display.dart';
import 'package:hackathon_app/models/main_quest.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class DisplayMainQuests extends StatelessWidget {
  Box<MainQuestModel> db;
  DisplayMainQuests({
    Key? key,
    required this.db,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: db.listenable(),
      builder: (context, Box<MainQuestModel> items, _) {
        List<int> keys = items.keys.cast<int>().toList();
        return ListView.separated(
          separatorBuilder: (_, index) => Divider(),
          itemCount: keys.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            final int key = keys[index];
            final MainQuestModel? data = items.get(key);
            return MainQuestIconDisplay(
              iconPath: data!.mainQuestIconPath,
              mainQuestName: data.mainQuestName,
            );
            // return Card(
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(15.0),
            //   ),
            //   color: Colors.blueGrey[200],
            //   child: ListTile(
            //     title: Text(
            //       data!.subTaskName,
            //       style: TextStyle(fontSize: 22, color: Colors.black),
            //     ),
            //     subtitle: Text(data.completed.toString(),
            //         style: TextStyle(fontSize: 20, color: Colors.black38)),
            //     leading: Text(
            //       "$key",
            //       style: TextStyle(fontSize: 18, color: Colors.black),
            //     ),
            //   ),
            // );
          },
        );
      },
    );
  }
}
