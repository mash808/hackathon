import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app/column_wrapper.dart';
import 'package:hackathon_app/global_state/global_provider.dart';
import 'package:hackathon_app/models/boxes.dart';
import 'package:hackathon_app/profile_screen/display_achievements.dart';
import 'package:hackathon_app/profile_screen/profile.dart';
import 'package:hackathon_app/constants.dart';

class Profile extends ConsumerStatefulWidget {
  // final Function handleTap;
  const Profile({
    Key? key,
    // required this.handleTap,
  }) : super(key: key);

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  Widget build(BuildContext context) {
    final loggedIn = ref.watch(globalProvider);
    final pageIndex = ref.watch(indexProvider);
    final expcount = ref.watch(expLevel.notifier).state;
    return ColumnWrapper(
        child: Column(
      children: [
        ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Level: ',
                    style: TextStyle(
                        color: kTextCream,
                        fontSize: 32,
                        fontWeight: FontWeight.bold)),
                Text((expcount ~/ 200).toString(),
                    style: TextStyle(
                        color: kTextCream,
                        fontSize: 32,
                        fontWeight: FontWeight.bold))
              ],
            )),
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          const Text('Total EXP: ',
                              style: TextStyle(color: kTextCream)),
                          Text(expcount.toString(),
                              style: TextStyle(color: kTextCream)),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('EXP to next Level: ',
                              style: TextStyle(color: kTextCream)),
                          Text((200 - (expcount % 200)).toString(),
                              style: TextStyle(color: kTextCream)),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              Container(height: 5),
              XPRow(),
            ]),
            SizedBox(height: 40, width: 10),
            ProfileHeader(
              label: " Settings ",
              imageAddress: "images/character.png",
              fSize: 20,
            ),
            const SizedBox(height: 40, width: 10),
            ProfileHeader(
              imageAddress: "images/missions.png",
              label: " Help / FAQ ",
              fSize: 20,
            ),
            const SizedBox(height: 40, width: 10),
            Text(
              "Achievements",
              style: TextStyle(fontSize: 20, color: kTextCream),
              textAlign: TextAlign.center,
            ),
            Container(height: 10),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: kOsrsBrown,
                ),
                child: Column(
                  children: [
                    Container(height: 10),
                    DisplayAchievements(
                      mainQuestDb: Boxes.getMainQuests(),
                    ),
                    /*Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 50.0,
                      runSpacing: 5.0,
                      children: [
                        AchievementIcon(
                          imageAddress: 'images/very_hard_boss.png',
                          achievementCount: 0,
                        ),
                        AchievementIcon(
                            achievementCount: 5,
                            imageAddress: 'images/hard_boss.png'),
                        AchievementIcon(
                            achievementCount: 5,
                            imageAddress: 'images/medium_boss.png'),
                        AchievementIcon(
                            achievementCount: 5,
                            imageAddress: 'images/easy_boss.png'),
                        AchievementIcon(
                            achievementCount: 5,
                            imageAddress: 'images/very_easy_boss.png'),
                        AchievementIcon(
                            achievementCount: 15,
                            imageAddress: 'images/side_quests_achievement.png')
                      ],
                    ),*/
                    Container(height: 5)
                  ],
                )),
            GestureDetector(
              onTap: () {
                setState(() {
                  ref.read(globalProvider.notifier).logout();
                  ref.read(indexProvider.notifier).updateIndex(3);
                });
              },
              child: Image.asset(
                'images/logout.jpg',
                height: 60,
                // scale: 0.6,
              ),
            ),
          ],
        )
      ],
    ));
  }
}

class AchievementIcon extends StatelessWidget {
  final int achievementCount;
  final String imageAddress;

  const AchievementIcon(
      {Key? key, required this.achievementCount, required this.imageAddress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 47,
          width: 47,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imageAddress), fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        Text(achievementCount.toString(), style: TextStyle(color: kTextCream)),
      ],
    );
  }
}

//This Widget contains the profile picture and title of the profile page
class ProfileHeader extends StatelessWidget {
  final String imageAddress;
  final String label;
  final double fSize;

  const ProfileHeader(
      {Key? key,
      required this.label,
      required this.imageAddress,
      required this.fSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imageAddress),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: kTextCream,
              ),
              borderRadius: BorderRadius.horizontal(
                  left: Radius.zero, right: Radius.circular(3)),
              color: kTextCream),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: fSize,
            ),
          ),
        ),
      ],
    );
  }
}

// This widget contains the XP Bar and decorations
class XPRow extends ConsumerStatefulWidget {
  const XPRow({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<XPRow> createState() => _XPRowState();
}

class _XPRowState extends ConsumerState<XPRow> {
  @override
  Widget build(BuildContext context) {
    final expcount = ref.watch(expLevel.notifier).state;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: (MediaQuery.of(context).size.width / 2),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromARGB(255, 43, 43, 43), width: 3)),
            child: LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
              backgroundColor: Color.fromARGB(255, 57, 57, 57),
              color: Color.fromARGB(255, 27, 134, 221),
              value: ((expcount % 200) / 200),
              minHeight: 20,
            ))
      ],
    );
  }
}
