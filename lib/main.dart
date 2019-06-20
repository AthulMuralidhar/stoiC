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
          Align(
            alignment: Alignment.center,
            child: Text('''
            In your daily travels, you might 
            come across various situations that 
            try to put your stoicabilities to 
            the test. Here is a helper app to 
            distinguish and keep track of the 
            internals, the "real" things that
            you actually have to care about 
           '''
           ),
            widthFactor: 2.0,
            heightFactor: 2.0,
          ),
          Center(
            child: RaisedButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>OverviewScreen()),
                  );
                },
              child: Text('Go!'),
            ),
          ),
        ],
      )
      );
  }
}

class OverviewScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:Text('Overview screen!'),
    ),
    body: Center(
    child: Column(
    children: <Widget>[
      RaisedButton(
        child: Text('Go back'),
        onPressed: (){
          Navigator.pop(context);
          },
        ),
      ],
    ),
    ),
    );
  }
}