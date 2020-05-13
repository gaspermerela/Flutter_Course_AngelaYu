import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue[900],
          title: Text(
            'Ask Me Anything',
            style: TextStyle(fontSize: 30.0),
          ),
        ),
        body: AskPage(),
      ),
    ),
  );
}

class AskPage extends StatefulWidget {
  @override
  _AskPageState createState() => _AskPageState();
}

class _AskPageState extends State<AskPage> {
  int num = 2;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[600],
      child: Center(
        child: FlatButton(
          onPressed: () {
            setState(() {
              num = Random().nextInt(5) + 1;
            });
          },
          child: Image.asset('images/ball$num.png'),
        ),
      ),
    );
  }
}
