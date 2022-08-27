import 'package:flutter/material.dart';
import 'package:hackathon_app/column_wrapper.dart';

class SideQuests extends StatelessWidget {
  const SideQuests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColumnWrapper(
      child: Column(
        children: [
          const Text('SIDE QUESTS PAGE - EDIT INSIDE THIS COLUMN'),
        ],
      ),
    );
  }
}
