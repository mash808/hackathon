import 'package:flutter/material.dart';
import 'package:hackathon_app/column_wrapper.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return ColumnWrapper(
        child: Column(
      children: [
        ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            const SizedBox(height: 40, width: 10),
            ProfileHeader(
                label: " profile ", imageAddress: "images/character.png"),
            const SizedBox(height: 40, width: 10),
            XPRow(),
            const SizedBox(height: 40, width: 10),
            ProfileHeader(
                label: " settings ", imageAddress: "images/character.png"),
            const SizedBox(height: 40, width: 10),
            ProfileHeader(
                imageAddress: "images/missions.png", label: " help / FAQ "),
            const SizedBox(height: 40, width: 10),
            Text(
              "Achievements",
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 253, 211, 152)),
              textAlign: TextAlign.center,
            )
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
                color: Color.fromARGB(255, 253, 211, 152),
              ),
              borderRadius: BorderRadius.horizontal(
                  left: Radius.zero, right: Radius.circular(3)),
              color: Color.fromARGB(255, 253, 211, 152)),
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
