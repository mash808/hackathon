import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackathon_app/column_wrapper.dart';
import 'package:hackathon_app/models/sub_task_model.dart';
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
        children: [
          // TODO: Return everything inside the mainQuestDB
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
        ],
      ),
    );
  }
}

class DisplaySubQuests extends StatelessWidget {
  Box<SubTaskModel> db;
  DisplaySubQuests({
    Key? key,
    required this.db,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: db.listenable(),
      builder: (context, Box<SubTaskModel> items, _) {
        List<int> keys = items.keys.cast<int>().toList();
        return ListView.separated(
          separatorBuilder: (_, index) => Divider(),
          itemCount: keys.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            final int key = keys[index];
            final SubTaskModel? data = items.get(key);
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.blueGrey[200],
              child: ListTile(
                title: Text(
                  data!.subTaskName,
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
                subtitle: Text(data.completed.toString(),
                    style: TextStyle(fontSize: 20, color: Colors.black38)),
                leading: Text(
                  "$key",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
