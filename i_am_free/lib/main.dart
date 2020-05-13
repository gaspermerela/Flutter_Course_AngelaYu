import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.lightBlueAccent[100],
          appBar: AppBar(
            title: Text('I Am Free'),
            backgroundColor: Colors.blue[400],
          ),
          body: Center(
            child: Image(
              image: AssetImage('images/The_Matterhorn.png'),
            ),
          ),
        ),
      ),
    );
