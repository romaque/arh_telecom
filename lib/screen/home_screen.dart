import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grande_serra/layouts/main.dart';
import 'package:grande_serra/models/radios.dart';
import 'package:grande_serra/widget/player.dart';
import 'package:grande_serra/widget/program.dart';

class HomeScreen extends StatefulWidget {
  RadiosModel radio;

  HomeScreen(this.radio);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),

        Program(widget.radio),

        SizedBox(
          height: 30.0,
        ),

        Player(widget.radio)
      ],
    );
  }
}
