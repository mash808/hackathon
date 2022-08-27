import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app/app_bar.dart';
import 'package:hackathon_app/global_state/global_provider.dart';
import 'package:hackathon_app/main_quest_screen/quests.dart';
import 'package:hackathon_app/models/main_quest.dart';
import 'package:hackathon_app/models/sub_task_model.dart';
import 'package:hackathon_app/nav_bar_bottom.dart';
import 'package:hackathon_app/profile_screen/profile.dart';
import 'package:hackathon_app/side_quest_screen/side_quests.dart';
import 'package:hackathon_app/welcome.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SubTaskModelAdapter());
  await Hive.openBox<MainQuestModel>('mainQuestDB');
  await Hive.openBox<SubTaskModel>('sideQuestDB');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends ConsumerStatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  ConsumerState<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends ConsumerState<MyHome> {
  final List<Widget> _pages = <Widget>[
    const Quests(),
    const SideQuests(),
    const Profile(),
    const WelcomeScreen(),
  ];
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    final loggedIn = ref.watch(globalProvider);
    final pageIndex = ref.watch(indexProvider);
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
        // child: _pages.elementAt(_selectedIndex),
        child: _pages.elementAt(pageIndex),
      ),
      bottomNavigationBar: (loggedIn)
          ? NavBarBottom(
              handleTap: (newValue) {
                setState(() {
                  // _selectedIndex = newValue;
                  ref.read(indexProvider.notifier).updateIndex(newValue);
                });
              },
            )
          : null,
    );
  }
}
