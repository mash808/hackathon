import 'package:flutter/material.dart';
import 'package:hackathon_app/app_bar.dart';
import 'package:hackathon_app/constants.dart';
import 'package:hackathon_app/main_quest_screen/quests.dart';
import 'package:hackathon_app/nav_bar_bottom.dart';
import 'package:hackathon_app/profile_screen/profile.dart';
import 'package:hackathon_app/side_quest_screen/side_quests.dart';
import 'package:hackathon_app/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final List<Widget> _pages = <Widget>[
    const Quests(),
    const SideQuests(),
    const Profile(),
    const WelcomeScreen(),
  ];
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/osrs_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: NavBarBottom(
        handleTap: (newValue) {
          setState(() {
            _selectedIndex = newValue;
          });
        },
      ),
    );
  }
}
