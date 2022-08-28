import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hackathon_app/constants.dart';
import 'package:hackathon_app/main_quest_screen/display_main_quests_sub_quests.dart';
import 'package:hackathon_app/models/boxes.dart';

class MainQuestIconDisplay extends StatelessWidget {
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
                                Image.asset(iconPath),
                                Text(
                                  mainQuestName,
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
                              index: index,
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
              Image.asset(iconPath),
              Text(
                mainQuestName,
                style: TextStyle(color: kTextCream),
              )
            ],
          ),
        ));
  }
}
