import 'package:flutter/material.dart';
import 'package:grande_serra/models/program.dart';
import 'package:grande_serra/models/radios.dart';
import 'package:http/http.dart' as http;

class MusicScreen extends StatefulWidget {
  RadiosModel radio;

  MusicScreen(this.radio);

  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _musica = TextEditingController();
  bool _carregando;
  bool _success;

  _sendMusic() async{

    if(_nome.text == "" && _email.text == "" && _musica.text == "")
      return;

    setState(() {
      _carregando = true;
    });

    var data = {
      "nome": _nome.text,
      "email": _email.text,
      "musica": _musica.text,
      "radio": widget.radio.slug,
    };

    final res = await http.post('https://radiograndeserra.com.br/wp-json/wp/v2/programacao/email', body: data);

    if (res.statusCode == 200) {
      setState(() {
        _nome.text = "";
        _email.text = "";
        _musica.text = "";

        _success = true;
        _carregando = false;
      });

      Future.delayed(
        Duration(seconds: 10),
        () {
          setState(() {
            _success = false;
          });
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
      child: Column(
        children: <Widget>[

          (_success == true) ? Container(
            color: Colors.white,
            margin: EdgeInsets.only(bottom: 20.0),
            padding: EdgeInsets.all(10.0),
            child: Text("Obrigado por pedir sua música. Tocaremos ela!!!", style: TextStyle(color: Colors.green),),
          ) : Container(),
          
          TextField(
            controller: _nome,
            style: new TextStyle(color: Colors.white),
            decoration: InputDecoration(
              fillColor: Colors.white,
              focusColor: Colors.white,
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 18.0
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white
                  )
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white
                  )
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.blue
                  )
              ),
              labelText: 'Seu nome',
            ),
          ),

          SizedBox(height: 10.0,),

          TextField(
            controller: _email,
            style: new TextStyle(color: Colors.white),
            decoration: InputDecoration(
              fillColor: Colors.white,
              focusColor: Colors.white,
              labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white
                  )
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white
                  )
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.blue
                  )
              ),
              labelText: 'Seu e-mail',
            ),
          ),

          SizedBox(height: 10.0,),

          TextField(
            controller: _musica,
            style: new TextStyle(color: Colors.white),
            decoration: InputDecoration(
              fillColor: Colors.white,
              focusColor: Colors.white,
              labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white
                  )
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white
                  )
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.blue
                  )
              ),
              labelText: 'Sua música',
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 20.0, bottom: 10),
            child: RaisedButton(
              padding: EdgeInsets.all(15),
              color: Color(0xFFCB3638),
              elevation: 0.0,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xFFCB3638)),
                  borderRadius: new BorderRadius.circular(50.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  (_carregando == true) ? CircularProgressIndicator() : Container(),

                  (_carregando == true) ? SizedBox(width: 10.0) : Container(),

                  Text("Enviar",
                      style: TextStyle(
                          fontSize: 17,
                          textBaseline: TextBaseline.alphabetic,
                          fontFamily: 'Gilroy')),
                ],
              ),
              onPressed: _sendMusic,
            ),
          )

        ],
      ),
    );
  }
}

