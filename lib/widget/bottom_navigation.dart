import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigation extends StatefulWidget {
  final PageController controller;
  BottomNavigation(this.controller);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  int _index = 0;

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
        backgroundColor: Color(0xFFFF482D),
        unselectedItemColor: Colors.white,
        onTap: (index) {
          this._index = index;
          widget.controller.jumpToPage(index);
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Color(0xFFF7B200),
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
              title: const Text(
                'aovivo',
                style: TextStyle(color: Color(0xFFF7B200), fontSize: 18.0),
              ),
              icon: Icon(
                FontAwesomeIcons.headphonesAlt,
                color: Color(0xFFF7B200),
                size: 27.0,
              )),
          BottomNavigationBarItem(
              title: const Text(
                'programação',
                style: TextStyle(color: Color(0xFFF7B200), fontSize: 18.0),
              ),
              icon: Icon(
                FontAwesomeIcons.solidClock,
                color: Color(0xFFF7B200),
                size: 25.0,
              )),
          BottomNavigationBarItem(
              title: const Text(
                'pedir musica',
                style: TextStyle(color: Color(0xFFF7B200), fontSize: 18.0),
              ),
              icon: Icon(
                FontAwesomeIcons.music,
                color: Color(0xFFF7B200),
                size: 24.0,
              )),
        ]);
  }

}