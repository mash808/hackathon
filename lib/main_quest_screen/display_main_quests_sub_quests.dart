import 'package:flutter/material.dart';
import 'package:hackathon_app/main.dart';
import 'package:hackathon_app/models/main_quest.dart';
import 'package:hackathon_app/models/sub_task_model.dart';
import 'package:hackathon_app/side_quest_screen/side_quests.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class DisplayMainQuestSubQuests extends StatelessWidget {
  Box<MainQuestModel> db;
  final int index;
  DisplayMainQuestSubQuests({
    Key? key,
    required this.db,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: db.listenable(),
      builder: (context, Box<MainQuestModel> items, _) {
        MainQuestModel? mainQuest = items.getAt(index);
        print(mainQuest!.mainQuestName);

        List<SubTaskModel> subTasks = mainQuest.subTasks;
        print('*************************');
        print(subTasks.length);
        // if (!(mainQuest!.subTasks == null)) {
        // subTasks = mainQuest.subTasks;
        // }

        // List<int> keys = items.keys.cast<int>().toList();

        return ListView.separated(
          separatorBuilder: (_, index) => Divider(),
          itemCount: subTasks.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            // final int key = keys[index];
            final SubTaskModel? data = subTasks[index];
            return MainQuestIndividualTasks(
              // index: index,
              exp: data!.exp,
              sideQuestName: data.subTaskName,
            );
          },
        );
      },
    );
  }
}

class MainQuestIndividualTasks extends StatefulWidget {
  final String sideQuestName;
  final int exp;
  // final int? index;

  const MainQuestIndividualTasks({
    super.key,
    required this.exp,
    required this.sideQuestName,
    // this.index,
  });

  @override
  State<MainQuestIndividualTasks> createState() =>
      _MainQuestIndividualTasksState();
}

class _MainQuestIndividualTasksState extends State<MainQuestIndividualTasks> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CompleteSideQuestsButton(
            //   index: widget.index,
            // ),
            Container(width: (MediaQuery.of(context).size.width * 0.025)),
            Container(
                width: (MediaQuery.of(context).size.width * 0.6),
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Color.fromRGBO(48, 36, 29, 1.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.sideQuestName,
                      style: const TextStyle(
                        color: Color.fromRGBO(255, 184, 0, 1.0),
                      ),
                    ),
                    Text(
                      'EXP: ${widget.exp}',
                      style: const TextStyle(
                        color: Colors.lightGreen,
                      ),
                    ),
                  ],
                ))
          ],
        ));
  }
}
