import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hackathon_app/column_wrapper.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColumnWrapper(
      child: Column(
        children: [
          const Text('WELCOME PAGE - EDIT INSIDE THIS COLUMN'),
        ],
      ),
    );
  }
}
