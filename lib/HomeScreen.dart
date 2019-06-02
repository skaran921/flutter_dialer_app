import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

String number = "";

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      this._textEditingController.text = number;
    });
  }

  void runBackSpace() {
    setState(() {
      var l = number.length - 1;
      number = number.substring(0, l);
      this._textEditingController.text = number;
    });
  }

  Future _dialNumber() async {
    var dialNumber = "tel:$number";
    if (await canLaunch(dialNumber)) {
      await launch(dialNumber);
    } else {
      throw 'Could not launch $dialNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 100.0),
              ),
              Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: _textEditingController,
                      textAlign: TextAlign.center,
                      enabled: false,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(),
                      style: TextStyle(fontSize: 30.0, color: Colors.blue),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 20,
                    child: GestureDetector(
                      onLongPress: () {
                        this.runBackSpace();
                      },
                      onTap: () {
                        this.runBackSpace();
                      },
                      child: Icon(
                        Icons.backspace,
                        size: 24.0,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  dialerButton("1"),
                  dialerButton("2"),
                  dialerButton("3")
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  dialerButton("4"),
                  dialerButton("5"),
                  dialerButton("6")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  dialerButton("7"),
                  dialerButton("8"),
                  dialerButton("9")
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  dialerButton("*"),
                  dialerButton("0"),
                  dialerButton("#")
                ],
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 10.0, top: 10),
                  child: FloatingActionButton(
                    onPressed: () {
                      this._dialNumber();
                    },
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    child: Icon(Icons.call),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dialerButton(String buttonNo) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: FloatingActionButton(
          elevation: 1.0,
          onPressed: () {
            setState(() {
              number += buttonNo;
              _textEditingController.text = number;
            });
          },
          backgroundColor: Color(0xFFDAE0E2),
          foregroundColor: Colors.black87,
          child: Text(
            buttonNo,
            style: TextStyle(fontSize: 27.0),
          ),
        ),
      ),
    );
  }
}
