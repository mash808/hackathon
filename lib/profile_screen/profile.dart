import 'package:flutter/material.dart';
import 'package:hackathon_app/column_wrapper.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColumnWrapper(
      child: Column(
        children: [
          const Text('PROFILE PAGE - EDIT INSIDE THIS COLUMN'),
        ],
      ),
    );
  }
}
