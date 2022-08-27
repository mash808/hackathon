import 'package:flutter/material.dart';
import 'package:hackathon_app/app_bar.dart';
import 'package:hackathon_app/main_quest_screen/quests.dart';
import 'package:hackathon_app/profile_screen/profile.dart';
import 'package:hackathon_app/side_quest_screen/side_quests.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHome(),
      routes: {
        '/quests': (context) => const Quests(),
        '/side_quests': (context) => const SideQuests(),
        '/profile': (context) => const Profile()
      },
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

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
        child: Column(
          children: [],
        ),
        // child: GestureDetector(
        //   onTap: () {
        //     Navigator.pushNamed(context, "/quests");
        //   },
        //   onDoubleTap: () {
        //     Navigator.pushNamed(context, '/side_quests');
        //   },
        //   onLongPress: () {
        //     Navigator.pushNamed(context, '/profile');
        //   },
        //   child: Container(
        //     width: 100,
        //     height: 100,
        //     color: Colors.red,
        //   ),
        // ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Business',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'School',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}
