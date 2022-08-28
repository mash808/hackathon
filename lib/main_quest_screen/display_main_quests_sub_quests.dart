import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app/global_state/global_provider.dart';
import 'package:hackathon_app/main.dart';
import 'package:hackathon_app/models/boxes.dart';
import 'package:hackathon_app/models/main_quest.dart';
import 'package:hackathon_app/models/sub_task_model.dart';
import 'package:hackathon_app/side_quest_screen/side_quests.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class DisplayMainQuestSubQuests extends StatelessWidget {
  Box<MainQuestModel> db;
  final int indexMainQuest;
  DisplayMainQuestSubQuests({
    Key? key,
    required this.db,
    required this.indexMainQuest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: db.listenable(),
      builder: (context, Box<MainQuestModel> items, _) {
        MainQuestModel? mainQuest = items.getAt(indexMainQuest);
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
              indexMainQuest: indexMainQuest,
              indexSubTask: index,
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
  final int indexMainQuest;
  final int indexSubTask;

  const MainQuestIndividualTasks({
    super.key,
    required this.exp,
    required this.sideQuestName,
    required this.indexMainQuest,
    required this.indexSubTask,
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
            CompleteSubTaskOfMainQuest(
              indexMainTask: widget.indexMainQuest,
              indexSubTask: widget.indexSubTask,
            ),
            Container(width: (MediaQuery.of(context).size.width * 0.025)),
            Container(
                width: (MediaQuery.of(context).size.width * 0.5),
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

class CompleteSubTaskOfMainQuest extends ConsumerStatefulWidget {
  final int indexMainTask;
  final int indexSubTask;
  const CompleteSubTaskOfMainQuest({
    Key? key,
    required this.indexMainTask,
    required this.indexSubTask,
  }) : super(key: key);

  @override
  ConsumerState<CompleteSubTaskOfMainQuest> createState() =>
      _CompleteSubTaskOfMainQuestState();
}

class _CompleteSubTaskOfMainQuestState
    extends ConsumerState<CompleteSubTaskOfMainQuest> {
  @override
  Widget build(BuildContext context) {
    Box<MainQuestModel> mainQuestBox = Boxes.getMainQuests();
    MainQuestModel? mainQuestCopy = mainQuestBox.getAt(widget.indexMainTask);
    SubTaskModel subTaskCopy =
        mainQuestBox.getAt(widget.indexMainTask)!.subTasks[widget.indexSubTask];
    return GestureDetector(
        onTap: () {
          // if (data.get(widget.index)!.completed == false) {
          if (subTaskCopy.completed == false) {
            SubTaskModel subTaskComplete = SubTaskModel(
                completed: true,
                exp: subTaskCopy.exp,
                subTaskName: subTaskCopy.subTaskName);
            List<SubTaskModel> subTasksNew = mainQuestCopy!.subTasks;
            subTasksNew[widget.indexSubTask] = subTaskComplete;

            mainQuestBox.putAt(
              widget.indexMainTask,
              MainQuestModel(
                  mainQuestIconPath: mainQuestCopy.mainQuestIconPath,
                  mainQuestName: mainQuestCopy.mainQuestName,
                  subTasks: subTasksNew,
                  exp: mainQuestCopy.exp,
                  completed: mainQuestCopy.completed),
            );
            var exp_new = subTaskComplete.exp;
            ref.read(expLevel.notifier).increaseLevel(exp_new);
          } else {
            SubTaskModel subTaskUnComplete = SubTaskModel(
                completed: false,
                exp: subTaskCopy.exp,
                subTaskName: subTaskCopy.subTaskName);
            List<SubTaskModel> subTasksNew = mainQuestCopy!.subTasks;
            subTasksNew[widget.indexSubTask] = subTaskUnComplete;

            mainQuestBox.putAt(
              widget.indexMainTask,
              MainQuestModel(
                  mainQuestIconPath: mainQuestCopy.mainQuestIconPath,
                  mainQuestName: mainQuestCopy.mainQuestName,
                  subTasks: subTasksNew,
                  exp: mainQuestCopy.exp,
                  completed: mainQuestCopy.completed),
            );

            var exp_new = subTaskUnComplete.exp;
            ref.read(expLevel.notifier).increaseLevel(-exp_new);
            // var exp_new = data.get(widget.index);
            // ref.read(expLevel.notifier).increaseLevel(-exp_new!.exp);
          }
        },
        child: (mainQuestBox
                .getAt(widget.indexMainTask)!
                .subTasks[widget.indexSubTask]
                .completed) // (data.get(widget.index)!.completed == true)
            ? Image.asset('images/side_quests_icon_dark.png')
            : Image.asset(
                'images/side_quests_icon.png')); // Can make this image darker if not completed??
  }
}
