import 'package:flutter/material.dart';
import 'package:hackathon_app/column_wrapper.dart';
import 'package:hackathon_app/models/main_quest.dart';
import 'package:hackathon_app/models/sub_task_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class Quests extends StatefulWidget {
  const Quests({Key? key}) : super(key: key);

  @override
  State<Quests> createState() => _QuestsState();
}

class _QuestsState extends State<Quests> {
  Box<MainQuestModel> mainQuestDB = Hive.box('mainQuestDB');
  Box<SubTaskModel> sideQuestDB = Hive.box('sideQuestDB');

  @override
  Widget build(BuildContext context) {
    return ColumnWrapper(
      child: Container(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('images/quests_screen_banner.png', width: 300),
            Wrap(
                alignment: WrapAlignment.spaceEvenly,
                runSpacing: 10.0,
                children: [
                  MainQuests(),
                  MainQuests(),
                  MainQuests(),
                  MainQuests(),
                  addMainQuests(db: mainQuestDB),
                ])
          ],
        ),
      ),
    );
  }
}

class MainQuests extends StatelessWidget {
  const MainQuests({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Offstage(
            offstage: 1 != 1, // the database value is not veryeasy,
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: ((MediaQuery.of(context).size.height - 90) / 2)),
              child: Column(children: [
                GestureDetector(
                    onTap: () {},
                    child: Image.asset('images/very_easy_boss.png')),
                const Text(
                  'The Name of the thingy',
                  style: TextStyle(color: Color.fromRGBO(253, 211, 152, 1.0)),
                )
              ]),
            )),
        Offstage(
            offstage: 1 != 0, // the database value is not veryeasy,
            child: Column(children: [
              GestureDetector(
                  onTap: () {}, child: Image.asset('images/easy_boss.png')),
              const Text(
                'The Name of the thingy',
                style: TextStyle(color: Color.fromRGBO(253, 211, 152, 1.0)),
              )
            ])),
        Offstage(
            offstage: 1 != 0, // the database value is not veryeasy,
            child: Column(children: [
              GestureDetector(
                  onTap: () {}, child: Image.asset('images/medium_boss.png')),
              const Text(
                'The Name of the thingy',
                style: TextStyle(color: Color.fromRGBO(253, 211, 152, 1.0)),
              )
            ])),
        Offstage(
            offstage: 1 != 0, // the database value is not veryeasy,
            child: Column(children: [
              GestureDetector(
                  onTap: () {}, child: Image.asset('images/hard_boss.png')),
              const Text(
                'The Name of the thingy',
                style: TextStyle(color: Color.fromRGBO(253, 211, 152, 1.0)),
              )
            ])),
        Offstage(
            offstage: 1 != 0, // the database value is not veryeasy,
            child: Column(children: [
              GestureDetector(
                  onTap: () {},
                  child: Image.asset('images/very_hard_boss.png')),
              const Text(
                'The Name of the thingy',
                style: TextStyle(color: Color.fromRGBO(253, 211, 152, 1.0)),
              )
            ])),
      ],
    );
  }
}

class addMainQuests extends StatefulWidget {
  final Box<MainQuestModel> db;
  const addMainQuests({
    super.key,
    required this.db,
  });

  @override
  State<addMainQuests> createState() => _addMainQuestsState();
}

enum boss { veryeasy, easy, medium, hard, veryhard }

class _addMainQuestsState extends State<addMainQuests> {
  final mainQuestNameController = TextEditingController();

  @override
  void dispose() {
    mainQuestNameController.dispose();
    super.dispose();
  }

  boss? _level = boss.medium;

  @override
  Widget build(BuildContext context) {
    final Box<MainQuestModel> mainDB = widget.db;

    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                      title: const Text('Create Quest'),
                      backgroundColor: Color.fromRGBO(247, 235, 209, 1.0),
                      content: StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return Container(
                          child: Column(
                            children: [
                              const Text('Quest Name:',
                                  style: TextStyle(
                                      color:
                                          Color.fromRGBO(253, 211, 152, 1.0))),
                              Container(height: 5),
                              Container(height: 5),
                              TextField(
                                controller: mainQuestNameController,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  hintText: 'Complete Hackathon',
                                ),
                              ),
                              const Text('Pick Diffuculty Level:',
                                  style: TextStyle(
                                      color:
                                          Color.fromRGBO(253, 211, 152, 1.0))),
                              Container(height: 5),
                              Column(
                                children: [
                                  RadioListTile<boss>(
                                      title: const Text("Very Easy"),
                                      value: boss.veryeasy,
                                      groupValue: _level,
                                      onChanged: (boss? value) {
                                        setState(() {
                                          _level = boss.veryeasy;
                                        });
                                      }),
                                  RadioListTile<boss>(
                                      title: const Text("Easy"),
                                      value: boss.easy,
                                      groupValue: _level,
                                      onChanged: (boss? value) {
                                        setState(() {
                                          _level = value;
                                        });
                                      }),
                                  RadioListTile<boss>(
                                      title: const Text("Medium"),
                                      value: boss.medium,
                                      groupValue: _level,
                                      onChanged: (boss? value) {
                                        setState(() {
                                          _level = value;
                                        });
                                      }),
                                  RadioListTile<boss>(
                                      title: const Text("Hard"),
                                      value: boss.hard,
                                      groupValue: _level,
                                      onChanged: (boss? value) {
                                        setState(() {
                                          _level = value;
                                        });
                                      }),
                                  RadioListTile<boss>(
                                      title: const Text("Very Hard"),
                                      value: boss.veryhard,
                                      groupValue: _level,
                                      onChanged: (boss? value) {
                                        setState(() {
                                          _level = value;
                                        });
                                      }),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                      actions: [
                        TextButton(
                            child: const Text('Cancel'),
                            onPressed: () => Navigator.pop(context)),
                        TextButton(
                            child: const Text('Confirm'),
                            onPressed: () {
                              mainDB.add(MainQuestModel(
                                  mainQuestIcon:
                                      Image.asset('images/easy_boss.png'),
                                  mainQuestName: mainQuestNameController.text,
                                  subTasks: <SubTaskModel>[
                                    SubTaskModel(
                                        subTaskName: 'task 1',
                                        exp: 5,
                                        completed: false),
                                    SubTaskModel(
                                        subTaskName: 'task 2',
                                        exp: 10,
                                        completed: false),
                                    SubTaskModel(
                                        subTaskName: 'task 3',
                                        exp: 50,
                                        completed: false)
                                  ],
                                  exp: 250,
                                  completed: false));
                              mainQuestNameController.clear();
                              Navigator.pop(context);
                            })
                      ]));
        },
        child: Image.asset('images/add_quest.png'));
  }
}
