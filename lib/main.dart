import 'package:flutter/material.dart';
import 'package:grande_serra/screen/home_screen.dart';
import 'package:grande_serra/screen/music_screen.dart';
import 'package:grande_serra/screen/programs_screen.dart';
import 'package:grande_serra/widget/bottom_navigation.dart';

import 'layouts/main.dart';
import 'models/radios.dart';

void main() {
  runApp(new MaterialApp(
    home: HomeView(),
  ));
}

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _pageController = PageController();
  RadiosModel radio;

  set _setRadio(value) {
    radio = value;
  }

  @override
  void initState() {
    super.initState();
    this.radio = RadiosModel('Araripina', '', 'araripina',
        logo: 'images/logo_araripina.png');
  }

  _changeRadio(radio) {
    setState(() {
      this.radio = radio;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Montserrat'),
        home: Scaffold(
          bottomNavigationBar: BottomNavigation(_pageController),
          body: PageView(
            physics: new NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              MainLayout(
                  radio: radio,
                  body: [
                    HomeScreen(radio, radioSet: _changeRadio),
                  ],
                  radioSet: _changeRadio),
              MainLayout(
                  radio: radio,
                  body: [
                    ProgramsScreen(radio),
                  ],
                  radioSet: _changeRadio),
              MainLayout(
                  radio: radio,
                  body: [
                    MusicScreen(radio),
                  ],
                  radioSet: _changeRadio),
            ],
          ),
        ));
  }
}
