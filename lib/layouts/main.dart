import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grande_serra/models/radios.dart';

class MainLayout extends StatefulWidget {
  final List<Widget> body;
  RadiosModel radio;
  final ValueChanged<RadiosModel> radioSet;

  MainLayout({this.body, this.radio, this.radioSet});

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  _changeRadio() {
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Container(
          child: Image.asset(
            'images/bg_app.png',
            fit: BoxFit.cover,
            width: width,
            height: height,
          ),
        ),
        Container(
            child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  height: 35.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.body,
                ),
              ],
            )
          ],
        ))
      ],
    );
  }
}
