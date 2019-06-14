import 'package:flutter/material.dart';

void main(){

  runApp(MaterialApp(
    title: 'stoiC',
    home: HomeScreen(),
  ));
}


class HomeScreen extends StatelessWidget{
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
            child: Text('place holder'),
            widthFactor: 2.0,
            heightFactor: 2.0,
          ),
        ],
      )
      );
  }
}
