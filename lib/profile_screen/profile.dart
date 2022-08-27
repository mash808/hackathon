import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app/column_wrapper.dart';
import 'package:hackathon_app/global_state/global_provider.dart';
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
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Total EXP: ',
                      style: TextStyle(color: kTextCream)),
                  Text(expcount.toString(), style: TextStyle(color: kTextCream))
                ],
              ),
              Container(height: 5),
              XPRow(),
            ]),
            const SizedBox(height: 40, width: 10),
            const SizedBox(height: 40, width: 10),
            ProfileHeader(
                label: " profile ", imageAddress: "images/character.png"),
            ProfileHeader(
                label: " settings ", imageAddress: "images/character.png"),
            const SizedBox(height: 40, width: 10),
            ProfileHeader(
                imageAddress: "images/missions.png", label: " help / FAQ "),
            const SizedBox(height: 40, width: 10),
            Text(
              "Achievements",
              style: TextStyle(fontSize: 20, color: kTextCream),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
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

//This Widget contains the profile picture and title of the profile page
class ProfileHeader extends StatelessWidget {
  final String imageAddress;
  final String label;

  const ProfileHeader(
      {Key? key, required this.label, required this.imageAddress})
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
          child: Text(label),
        ),
      ],
    );
  }
}

// This widget contains the XP Bar and decorations
class XPRow extends StatelessWidget {
  const XPRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: (MediaQuery.of(context).size.width / 2),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromARGB(255, 43, 43, 43), width: 3)),
            child: const LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
              backgroundColor: Color.fromARGB(255, 57, 57, 57),
              color: Color.fromARGB(255, 27, 134, 221),
              value: 0.5,
              minHeight: 20,
            ))
      ],
    );
  }
}
