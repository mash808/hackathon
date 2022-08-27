import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app/column_wrapper.dart';
import 'package:hackathon_app/global_state/global_provider.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final loggedIn = ref.watch(globalProvider);
    return ColumnWrapper(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset('images/quests_logo.png')]),
          FractionallySizedBox(
            widthFactor: 0.95,
            child: Container(
                height: (MediaQuery.of(context).size.height / 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('Username',
                              style: TextStyle(
                                  color: Color.fromRGBO(253, 211, 152, 1.0))),
                          Container(height: 5),
                          TextField(
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
                              style: TextStyle(
                                  color: Color.fromRGBO(253, 211, 152, 1.0))),
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
                    Container(height: 5),
                    Container(
                      child: ElevatedButton(
                        onPressed: () {
                          ref.read(globalProvider.notifier).logIn();
                          ref.read(indexProvider.notifier).updateIndex(0);
                        },
                        child: const Text('Login'),
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Color.fromRGBO(253, 211, 152, 1.0),
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
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('sign up'),
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    backgroundColor: Color.fromRGBO(253, 211, 152, 1.0),
                  ),
                ),
              ),
              Container(
                child: TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                                title: const Text('Forgot Password'),
                                content: const Text('Remember next time :)'),
                                actions: [
                                  TextButton(
                                      child: const Text('OK'),
                                      onPressed: () => Navigator.pop(context))
                                ]));
                  },
                  child: const Text('Forgot Password',
                      style:
                          TextStyle(color: Color.fromRGBO(253, 211, 152, 1.0))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
