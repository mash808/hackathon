import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app/column_wrapper.dart';
import 'package:hackathon_app/models/sub_task_model.dart';
import 'package:hackathon_app/global_state/global_provider.dart';
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
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Image.asset('images/side_quests_book.png',
                height: (MediaQuery.of(context).size.height / 4)),
            FractionallySizedBox(
              widthFactor: 0.95,
              child: Column(
                children: [
                  DisplaySubQuests(db: sideQuestDB),
                  NewSideQuestButton(
                    db: sideQuestDB,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class IndividualQuests extends StatelessWidget {
  final String sideQuestName;
  final int exp;
  final int index;

  const IndividualQuests({
    super.key,
    required this.exp,
    required this.sideQuestName,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CompleteSideQuestsButton(
            index: index,
          ),
          Container(width: (MediaQuery.of(context).size.width * 0.010)),
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

class CompleteSideQuestsButton extends ConsumerStatefulWidget {
  final int index;
  CompleteSideQuestsButton({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  ConsumerState<CompleteSideQuestsButton> createState() =>
      _CompleteSideQuestsButtonState();
}

class _CompleteSideQuestsButtonState
    extends ConsumerState<CompleteSideQuestsButton> {
  Box<SubTaskModel> data = Hive.box('sideQuestDB');
  String image_icon = 'images/side_quests_icon.png';
  @override
  Widget build(BuildContext context) {
    final globalExp = ref.watch(expLevel.notifier).state;
    return GestureDetector(
        onTap: () {
          if (data.get(widget.index)!.completed == false) {
            data.putAt(
                widget.index,
                SubTaskModel(
                  subTaskName: data.get(widget.index)!.subTaskName,
                  exp: data.get(widget.index)!.exp,
                  completed: true,
                ));
            var exp_new = data.get(widget.index);
            ref.read(expLevel.notifier).increaseLevel(exp_new!.exp);
          } else {
            data.putAt(
                widget.index,
                SubTaskModel(
                  subTaskName: data.get(widget.index)!.subTaskName,
                  exp: data.get(widget.index)!.exp,
                  completed: false,
                ));
            var exp_new = data.get(widget.index);
            ref.read(expLevel.notifier).increaseLevel(-exp_new!.exp);
          }
        },
        child: (data.get(widget.index)!.completed == true)
            ? Image.asset('images/side_quests_icon_dark.png')
            : Image.asset(
                'images/side_quests_icon.png')); // Can make this image darker if not completed??
  }
}

class NewSideQuestButton extends StatefulWidget {
  final Box<SubTaskModel> db;
  const NewSideQuestButton({
    super.key,
    required this.db,
  });

  @override
  State<NewSideQuestButton> createState() => _NewSideQuestButtonState();
}

class _NewSideQuestButtonState extends State<NewSideQuestButton> {
  final questNameController = TextEditingController();
  final expAmountController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    questNameController.dispose();
    expAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Box<SubTaskModel> subDB = widget.db;
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
                                    color: Colors.deepOrange,
                                    )),
                            Container(height: 5),
                            TextField(
                              controller: questNameController,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                hintText: 'Complete Hackathon',
                              ),
                            ),
                            Container(height: 10),
                            const Text('XP Amount:',
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    )),
                            Container(height: 5),
                            TextField(
                              controller: expAmountController,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
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
                            onPressed: () {
                              setState(() {
                                subDB.add(
                                  SubTaskModel(
                                    subTaskName: questNameController.text,
                                    exp: int.parse(expAmountController.text),
                                    completed: false,
                                  ),
                                );
                                questNameController.clear();
                                expAmountController.clear();
                              });
                              Navigator.pop(context);
                            })
                      ]));
        },
        child: Image.asset('images/add_button.png'));
  }
}
