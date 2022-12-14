import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app/column_wrapper.dart';
import 'package:hackathon_app/constants.dart';
import 'package:hackathon_app/global_state/global_provider.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  final userNameController = TextEditingController();
  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loggedIn = ref.watch(globalProvider);
    return ColumnWrapper(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/quests_logo.png',
                  width: MediaQuery.of(context).size.width * 0.7)
            ],
          ),
          FractionallySizedBox(
            widthFactor: 0.95,
            child: Container(
                // height: (MediaQuery.of(context).size.height / 4),
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Username',
                          style: TextStyle(color: kTextCream)),
                      Container(height: 5),
                      TextField(
                        controller: userNameController,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'keanu_reeves',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Password',
                          style: TextStyle(color: kTextCream)),
                      Container(height: 5),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: '*************',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 10),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        ref.read(globalProvider.notifier).logIn();
                        if (userNameController.text == '') {
                          ref.read(nameProvider.notifier).setName('Guest123');
                        } else {
                          ref
                              .read(nameProvider.notifier)
                              .setName(userNameController.text);
                        }
                        ;
                        ref.read(indexProvider.notifier).updateIndex(0);
                      });
                    },
                    child: const Text('Login'),
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                      backgroundColor: kTextCream,
                    ),
                  ),
                ),
              ],
            )),
          ),
          Container(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Create Account'),
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    backgroundColor: kTextCream,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
