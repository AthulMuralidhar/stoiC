import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

//==============MAIN===================================================================================================================
void main(){

  runApp(MaterialApp(
    title: 'stoiC',
    home: HomeScreen(),
  ));
}
//=============CLOCKWIDGET=================================================================================================================
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
//=======HOMESCREEN==================================================================================================================
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
//====================OVERVIEWSCREEN======================================================================================================
//https://flutter.dev/docs/development/ui/interactive
class Internal{
  String text;
  bool opinions;
  bool aims;
  bool desires;
  bool aversions;
  Internal({
    this.text,
    this.aversions=false,
    this.desires=false,
    this.aims=false,
    this.opinions=false,
  });
}

class InternalsList extends StatefulWidget{
  @override
  _InternalsListState createState()=> _InternalsListState();
}
class _InternalsListState extends State<InternalsList>{
  List<Internal> internals = [];
  TextEditingController controller = new TextEditingController();

  _toggleOpinion(Internal internal,bool isOpinionChecked){
    setState(() {
      internal.opinions = isOpinionChecked;
    });
  }
  _toggleAim(Internal internal,bool isAimChecked){
    setState(() {
      internal.aims = isAimChecked;
    });
  }
  _toggleDesire(Internal internal,bool isDesireChecked){
    setState(() {
      internal.desires= isDesireChecked;
    });
  }
  _toggleAversion(Internal internal,bool isAversionChecked){
    setState(() {
      internal.aversions= isAversionChecked;
    });
  }

  _addInternal(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('New Internal'),
          content: TextField(
            controller: controller,
            autofocus: true,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Add'),
              onPressed: (){
                setState(() {
                  final internal= new Internal(text: controller.value.text);
                  internals.add(internal);
                  controller.clear();
                  Navigator.of(context).pop();
                });
              },
            ),
            FlatButton(
              child: Text('Cancel'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }

  _removeInternal(){
    setState(() {
      internals.removeLast();
    });
  }

  Widget _buildItem(BuildContext context,int index){
    final internal = internals[index];
    return Row(
        children: <Widget>[
          Expanded(child: Text(internal.text)),
          Checkbox(
              value: internal.aversions,
              onChanged: (bool isAversionChecked){
                _toggleAversion(internal, isAversionChecked);
              }
          ),
          Checkbox(
              value: internal.desires,
              onChanged: (bool isDesireChecked){
                _toggleDesire(internal, isDesireChecked);
              }
          ),
          Checkbox(
              value: internal.opinions,
              onChanged: (bool isOpinionChecked){
                _toggleOpinion(internal, isOpinionChecked);
              }
          ),
          Checkbox(
              value: internal.aims,
              onChanged: (bool isAimChecked){
                _toggleAim(internal, isAimChecked);
              }
          ),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Overview Screen')),
      body: ListView.builder(
        itemBuilder: _buildItem,
        itemCount: internals.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addInternal,
        child: Icon(Icons.add),
      ),
      bottomSheet: RaisedButton(
          child: Text('Delete'),
          onPressed: _removeInternal,
      ),
    );
  }
}

//--------------------------------------------------------------------------------------------------------------------------------------
class OverviewScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  InternalsList();
  }
}
//================================EOF=============================================================================================