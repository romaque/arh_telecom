import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grande_serra/modals/radio_modal.dart';
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
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return RadioModal(
            onCodeChanged: (radio) {
              setState(() {
                widget.radio = radio;
                widget.radioSet(radio);
              });
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Container(
          child: Image.asset(
            'images/background.png',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 5.0,
                    ),
                    Image.asset('images/logo_araripina.png'),
                    GestureDetector(
                      onTap: this._changeRadio,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFF482D),
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.mapMarkerAlt,
                              size: 17.0,
                              color: Color(0xFFF7B200),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              widget.radio.title.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 17.0,
                                  decoration: TextDecoration.none,
                                  color: Color(0xFFF7B200)),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                  ],
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
