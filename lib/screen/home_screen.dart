import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grande_serra/modals/radio_modal.dart';
import 'package:grande_serra/widget/bottom_navigation.dart';
import 'package:grande_serra/widget/player.dart';
import 'package:grande_serra/widget/program.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _slugRadio = 'araripina';
  String _nameRadio = 'Araripina';
  String _streaming = 'https://araripina.radiograndeserra.com.br/;';

  @override
  void initState() {
    super.initState();
  }

  _changeRadio(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return RadioModal(
            onCodeChanged: (code) {
              setState(() {
                var json = jsonDecode(code);
                this._nameRadio = json['title'];
                this._slugRadio = json['slug'];
                this._streaming = json['streaming'];
              });
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return new Scaffold(
      body: new Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                child: Image.asset(
                    'images/background.png',
                    fit: BoxFit.cover,
                    width: width,
                    height: height - 62.0,
                  ),
              ),

              Column(
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

//                    Spacer(),

                    GestureDetector(
                      onTap: this._changeRadio,
                      child:  Container(
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
                              _nameRadio.toUpperCase(),
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

                 Program(),

                  SizedBox(
                    height: 20.0,
                  ),
                  Player(_streaming)
                ],
              )
            ],
          )
        ],
      ),

      bottomNavigationBar: BottomNavigation(),
    );
  }
}
