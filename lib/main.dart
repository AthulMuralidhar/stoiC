import 'package:flutter/material.dart';
import 'dart:async';

void main(){

  runApp(MaterialApp(
    title: 'stoiC',
    home: HomeScreen(),
  ));
}


//https://flutter.institute/creating-your-first-flutter-app/

class ClockWidget extends StatefulWidget{
  ClockWidget({Key key}) : super(key:key);

  @override
  _ClockWidgetState createState() => new _ClockWidgetState();
}
class _ClockWidgetState extends State<ClockWidget>{
  Timer _timer;
  DateTime _time;

  @override
  void initState() {
    super.initState();
    _time = new DateTime.now();

    const duration = const Duration(seconds: 1);
    _timer = new Timer.periodic(duration, _updateTime);
  }

  void _updateTime(Timer _){
    setState(() {
      _time = new DateTime.now();
    });
  }

  @override
  void dispose(){
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text(_time.toString()),
    );
  }
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: new ClockWidget(),
            ),
          ),
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