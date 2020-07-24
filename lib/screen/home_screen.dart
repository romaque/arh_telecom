import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grande_serra/modals/radio_modal.dart';
import 'package:grande_serra/models/radios.dart';
import 'package:grande_serra/widget/player.dart';
import 'package:grande_serra/widget/program.dart';

class HomeScreen extends StatefulWidget {
  RadiosModel radio;
  final ValueChanged<RadiosModel> radioSet;

  HomeScreen(this.radio, {this.radioSet});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      print(ModalRoute.of(context).settings.name);
      showDialog(
          barrierDismissible: false,
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
    });
  }

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
          height: 20.0,
        ),
        Player(widget.radio)
      ],
    );
  }
}
