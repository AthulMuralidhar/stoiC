import 'package:flutter/material.dart';
import 'dart:async';

void main(){
  Timer.periodic(const Duration(seconds:1), (timer) {
    var now = new DateTime.now().toString();
    print(now);
  });
  runApp(MaterialApp(
    title: 'stoiC',
    home: HomeScreen(),
  ));
}


class HomeScreen extends StatelessWidget{
  final date = new DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Text('a practical counter for practicing stoics'),
            widthFactor: 2.0,
            heightFactor: 2.0,
          ),
          Center(
            child: Text(date),
            widthFactor: 2.0,
            heightFactor: 2.0,
          ),
        ],
      )
      );
  }
}
