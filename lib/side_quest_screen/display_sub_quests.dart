import 'package:flutter/material.dart';
import 'package:hackathon_app/models/sub_task_model.dart';
import 'package:hackathon_app/side_quest_screen/side_quests.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class DisplaySubQuests extends StatelessWidget {
  Box<SubTaskModel> db;
  DisplaySubQuests({
    Key? key,
    required this.db,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ValueListenableBuilder(
        valueListenable: db.listenable(),
        builder: (context, Box<SubTaskModel> items, _) {
          List<int> keys = items.keys.cast<int>().toList();
          return ListView.separated(
            separatorBuilder: (_, index) => Divider(height: 0),
            itemCount: keys.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              final int key = keys[index];
              final SubTaskModel? data = items.get(key);
              if (!data!.completed) {
                return Column(
                  children: [
                    IndividualQuests(
                      index: key,
                      exp: data.exp,
                      sideQuestName: data.subTaskName,
                    ),
                    const SizedBox.shrink(),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          );
        },
      ),
      ValueListenableBuilder(
        valueListenable: db.listenable(),
        builder: (context, Box<SubTaskModel> items, _) {
          List<int> keys = items.keys.cast<int>().toList();
          return ListView.separated(
            separatorBuilder: (_, index) => Divider(height: 0),
            itemCount: keys.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              final int key = keys[index];
              final SubTaskModel? data = items.get(key);
              if (data!.completed) {
                return Column(
                  children: [
                    IndividualQuests(
                      index: key,
                      exp: data.exp,
                      sideQuestName: data.subTaskName,
                    ),
                    const SizedBox.shrink(),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          );
        },
      )
    ]);
  }
}
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


/*
GestureDetector(
            onTap: () {
              sideQuestDB.add(
                SubTaskModel(
                  subTaskName: 'kill chickens',
                  exp: 1,
                  completed: false,
                ),
              );
            },
            child: Container(
              width: 200,
              height: 200,
              color: Colors.green,
            ),
          ),
          GestureDetector(
            onTap: (() {
              print(sideQuestDB.get('kill chickens'));
            }),
            child: DisplaySubQuests(db: sideQuestDB),
          )
*/