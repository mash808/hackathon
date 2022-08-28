import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hackathon_app/constants.dart';
import 'package:hackathon_app/main_quest_screen/display_main_quests_sub_quests.dart';
import 'package:hackathon_app/models/boxes.dart';
import 'package:hackathon_app/models/main_quest.dart';
import 'package:hackathon_app/models/sub_task_model.dart';
import 'package:hive_flutter/adapters.dart';

class MainQuestIconDisplay extends StatefulWidget {
  final String iconPath;
  final String mainQuestName;
  final int index;

  const MainQuestIconDisplay({
    Key? key,
    required this.iconPath,
    required this.mainQuestName,
    required this.index,
  }) : super(key: key);

  @override
  State<MainQuestIconDisplay> createState() => _MainQuestIconDisplayState();
}

class _MainQuestIconDisplayState extends State<MainQuestIconDisplay> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    backgroundColor: kOsrsBrown,
                    content: Container(
                      height: (MediaQuery.of(context).size.height) * 0.9,
                      width: (MediaQuery.of(context).size.width) * 0.9,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(widget.iconPath),
                                Text(
                                  widget.mainQuestName,
                                  style: TextStyle(color: kTextCream),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text('HP: TODO HP'),
                                // Container(
                                //   width: 10,
                                //   child: LinearProgressIndicator(
                                //     backgroundColor: Colors.red,
                                //     color: Colors.lightGreen,
                                //   ),
                                // ),
                              ],
                            ),
                            DisplayMainQuestSubQuests(
                              db: Boxes.getMainQuests(),
                              indexMainQuest: widget.index,
                            ),
                            NewMainQuestSideQuestButton(
                              db: Boxes.getMainQuests(),
                              indexMainQuest: widget.index,
                              refresh: () => refresh(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ));
        },
        child: Container(
          constraints: BoxConstraints(
              maxWidth: ((MediaQuery.of(context).size.width - 100) / 2)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(widget.iconPath),
              Text(
                widget.mainQuestName,
                style: TextStyle(color: kTextCream),
              )
            ],
          ),
        ));
  }
}

class NewMainQuestSideQuestButton extends StatefulWidget {
  final Box<MainQuestModel> db;
  final int indexMainQuest;
  final Function refresh;
  const NewMainQuestSideQuestButton(
      {super.key,
      required this.db,
      required this.indexMainQuest,
      required this.refresh});

  @override
  State<NewMainQuestSideQuestButton> createState() =>
      _NewMainQuestSideQuestButtonState();
}

class _NewMainQuestSideQuestButtonState
    extends State<NewMainQuestSideQuestButton> {
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
    final Box<MainQuestModel> mainQuestDB = widget.db;
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                      title: const Text('Create Sub Quest'),
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
                                // mainQuestDB.add(
                                //   SubTaskModel(
                                // subTaskName: questNameController.text,
                                // exp: int.parse(expAmountController.text),
                                // completed: false,
                                //   ),
                                // );
                                mainQuestDB
                                    .getAt(widget.indexMainQuest)!
                                    .subTasks
                                    .add(SubTaskModel(
                                      subTaskName: questNameController.text,
                                      exp: int.parse(expAmountController.text),
                                      completed: false,
                                    ));
                                questNameController.clear();
                                expAmountController.clear();
                                widget.refresh;
                                widget.refresh();
                              });
                              widget.refresh();
                              widget.refresh;
                              Navigator.pop(context);
                            })
                      ]));
        },
        child: Image.asset('images/add_button.png'));
  }
}
