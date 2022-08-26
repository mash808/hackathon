import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color myBoxColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hackathon Project'),
        ),
        body: Column(
          children: [
            const DoubleRowBoxes(
              box1color: Colors.black,
              box2color: Colors.amber,
            ),
            const SizedBox(
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      myBoxColor = Colors.red;
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    color: myBoxColor,
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.yellow,
                ),
                Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DoubleRowBoxes extends StatelessWidget {
  final Color box1color;
  final Color box2color;

  const DoubleRowBoxes({
    Key? key,
    required this.box1color,
    required this.box2color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 100,
          height: 100,
          color: box1color,
        ),
        Container(
          width: 100,
          height: 100,
          color: box2color,
        ),
      ],
    );
  }
}
