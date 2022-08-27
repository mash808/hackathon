import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hackathon_app/column_wrapper.dart';
import 'package:hackathon_app/models/sub_task_model.dart';
import 'package:hackathon_app/side_quest_screen/display_sub_quests.dart';
import 'package:hive/hive.dart';

class SideQuests extends StatefulWidget {
  const SideQuests({Key? key}) : super(key: key);

  @override
  State<SideQuests> createState() => _SideQuestsState();
}

class _SideQuestsState extends State<SideQuests> {
  Box<SubTaskModel> sideQuestDB = Hive.box('sideQuestDB');

  @override
  Widget build(BuildContext context) {
    return ColumnWrapper(
      child: Column(
        children: [
          Image.asset('images/side_quests_book.png',
              height: (MediaQuery.of(context).size.height / 4)),
          FractionallySizedBox(
            widthFactor: 0.95,
            child: Column(
              children: [
                // IndividualQuests(),
                // IndividualQuests(),
                // IndividualQuests(),

                DisplaySubQuests(db: sideQuestDB),
                const NewSideQuestButton(),
                GestureDetector(
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.pink,
                  ),
                  onTap: () {
                    sideQuestDB.add(
                      SubTaskModel(
                        subTaskName: 'kill chickens',
                        exp: 1,
                        completed: false,
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class IndividualQuests extends StatelessWidget {
  final String sideQuestName;
  final int exp;

  const IndividualQuests({
    super.key,
    required this.exp,
    required this.sideQuestName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CompleteSideQuestsButton(),
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
                    sideQuestName,
                    style: const TextStyle(
                      color: Color.fromRGBO(255, 184, 0, 1.0),
                    ),
                  ),
                  Text(
                    'EXP: $exp',
                    style: const TextStyle(
                      color: Colors.lightGreen,
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

class CompleteSideQuestsButton extends StatelessWidget {
  const CompleteSideQuestsButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Image.asset(
            'images/side_quests_icon.png')); // Can make this image darker if not completed??
  }
}

class NewSideQuestButton extends StatelessWidget {
  const NewSideQuestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                      title: const Text('Create Side Quest'),
                      backgroundColor: Color.fromRGBO(247, 235, 209, 1.0),
                      content: Container(
                        height: (MediaQuery.of(context).size.height / 4),
                        child: Column(
                          children: [
                            const Text('Quest Name:',
                                style: TextStyle(
                                    color: Color.fromRGBO(253, 211, 152, 1.0))),
                            Container(height: 5),
                            TextField(
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                hintText: 'Complete Hackathon',
                              ),
                            ),
                            const Text('XP Amount:',
                                style: TextStyle(
                                    color: Color.fromRGBO(253, 211, 152, 1.0))),
                            Container(height: 5),
                            TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                hintText: '15',
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                            child: const Text('Cancel'),
                            onPressed: () => Navigator.pop(context)),
                        TextButton(
                            child: const Text('Confirm'),
                            onPressed: () => Navigator.pop(context))
                      ]));
        },
        child: Image.asset('images/add_button.png'));
  }
}
