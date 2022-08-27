import 'package:flutter/material.dart';
import 'package:hackathon_app/constants.dart';

class NavBarBottom extends StatefulWidget {
  final Function handleTap;
  const NavBarBottom({
    Key? key,
    required this.handleTap,
  }) : super(key: key);

  @override
  State<NavBarBottom> createState() => _NavBarBottomState();
}

class _NavBarBottomState extends State<NavBarBottom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: const BoxDecoration(color: kOsrsBrown),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => widget.handleTap(0),
            child: Image.asset(
              'images/quests.png',
              scale: 0.6,
            ),
          ),
          GestureDetector(
            onTap: () => widget.handleTap(1),
            child: Image.asset(
              'images/book.png',
              scale: 0.6,
            ),
          ),
          GestureDetector(
            onTap: () => widget.handleTap(2),
            child: Image.asset(
              'images/character.png',
              scale: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}
