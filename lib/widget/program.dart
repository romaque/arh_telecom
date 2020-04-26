import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grande_serra/models/program.dart';
import 'package:grande_serra/models/radios.dart';
import 'package:grande_serra/utils/request.dart';

class Program extends StatefulWidget {
  RadiosModel _radio;

  Program(this._radio);

  @override
  _ProgramState createState() => _ProgramState();
}

class _ProgramState extends State<Program> {
  var _item = {};
  Future<ProgramModel> futureProgram;
  String _currentUrl;

  _getPrograma() async {
    futureProgram = fetchProgram(widget._radio.slug);
  }

  _getTimeProgram() {
    Timer timer = new Timer(new Duration(seconds: 10), () {
      _getPrograma();
      _getTimeProgram();
    });
  }

  @override
  void initState() {
    super.initState();

    this._getPrograma();
    this._getTimeProgram();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUrl != widget._radio.url) {
      _currentUrl = widget._radio.url;
      _getPrograma();
    }

    return FutureBuilder<ProgramModel>(
      future: futureProgram,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          this._getPrograma();

          return Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            decoration: BoxDecoration(
                color: Color(0xFFFFFFFF).withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 5.0,
                ),
                ClipRect(
                  child: Align(
                    heightFactor: 0.90,
                    widthFactor: 0.99,
                    alignment: Alignment.center,
                    child: Image.network(snapshot.data.image),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      snapshot.data.apresentador,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Color(0xFFF7B200),
                          fontSize: 20.0,
                          fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 2.0,),
                    Row(
                      children: <Widget>[
                        Text("Horário: ",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Color(0xFFFFFFFF),
                              fontFamily: 'Montserrat',
                              fontSize: 13.0),
                        ),

                        Text(
                          snapshot.data.inicio.substring(0, 2) + "h",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Color(0xFFFFFFFF),
                              fontFamily: 'Montserrat',
                              fontSize: 13.0),
                        ),

                        Text(" ás ",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Color(0xFFFFFFFF),
                              fontFamily: 'Montserrat',
                              fontSize: 13.0),
                        ),

                        Text(
                          snapshot.data.fim.substring(0, 2) + "h",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Color(0xFFFFFFFF),
                              fontFamily: 'Montserrat',
                              fontSize: 13.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                  ],
                )
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return CircularProgressIndicator();
      },
    );
  }
}
