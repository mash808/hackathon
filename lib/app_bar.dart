import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app/global_state/global_provider.dart';

class ProfileAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  ProfileAppBar({Key? key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  ConsumerState<ProfileAppBar> createState() => _ProfileAppBarState();
}

class _ProfileAppBarState extends ConsumerState<ProfileAppBar> {
  @override
  Widget build(BuildContext context) {
    final loggedIn = ref.watch(globalProvider.notifier).state;
    final username = ref.watch(nameProvider.notifier).state;
    return AppBar(
        backgroundColor: const Color.fromRGBO(72, 63, 51, 1), //(0x3E3529),
        title: loggedIn
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/gnome.png',
                    height: 50,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 200,
                    height: 25,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(253, 211, 152, 1),
                        borderRadius:
                            BorderRadius.horizontal(right: Radius.circular(8))),
                    child: Text(
                      username,
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
            : null
        // bottom: TabBar(tabs: [
        //   Tab(
        //     icon: Icon(Icons.psychology),
        //   ),
        //   Tab(
        //     icon: Icon(Icons.menu_book),
        //   ),
        //   Tab(
        //     icon: Icon(Icons.account_box),
        //   ),
        // ]),
        );
  }
}
