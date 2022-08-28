import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hackathon_app/constants.dart';

class MainQuestIconDisplay extends StatelessWidget {
  final String iconPath;
  final String mainQuestName;

  const MainQuestIconDisplay(
      {Key? key, required this.iconPath, required this.mainQuestName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
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
