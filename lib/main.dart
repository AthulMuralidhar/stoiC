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
      body: Center(
        child: Text('The counter for stoics'),
      ),
    );
  }
}