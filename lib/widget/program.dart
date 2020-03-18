import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grande_serra/utils/request.dart';

class Program extends StatefulWidget {
  @override
  _ProgramState createState() => _ProgramState();
}

class _ProgramState extends State<Program> {
  var _item = {};

  void _getPrograma() {
    request.get('https://radiograndeserra.com.br/wp-json/wp/v2/programacao/ar?radio=araripina').then((req) {
      setState(() {
        _item = req;
        this._getTimeProgram();
      });
    });
  }

  _getTimeProgram(){
    Timer timer = new Timer(new Duration(seconds: 10), () {
      this._getPrograma();
    });
  }

  @override
  void initState() {
    super.initState();

    this._getPrograma();
  }

  @override
  Widget build(BuildContext context) {
    return  (_item['apresentador']) ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        (_item['image'] != '') ? Image.network(_item['image']) : Container(),

        SizedBox(width: 20.0,),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              (_item['apresentador'] != '') ? _item['apresentador'] : '',
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Color(0xFFF7B200),
                  fontSize: 20.0),
            ),

            SizedBox(height: 2.0,),

            Text(
              (_item['post_title'] != '') ? _item['post_title'] : '',
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Color(0xFFFF482D),
                  fontSize: 20.0),
            ),
          ],
        )
      ],
    ) : Container();
  }
}
