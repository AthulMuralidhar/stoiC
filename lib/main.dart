import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

//==============MAIN===================================================================================================================
void main(){

  runApp(MaterialApp(
    title: 'stoiC',
    home: SplashScreen(),
  ));
}
//=============SPLASHSCREEN================================================================================================================
//https://fluttermaster.com/create-splash-screen-in-flutter/
//https://github.com/petehouston/flutter-tips/blob/master/create-splash-screen/main.dart

class SplashScreen extends StatefulWidget{

  @override
  _SplashScreenState createState() => new _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen>{

  @override
  void initState(){
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }
  onDoneLoading() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/launcher/stoic-launcher-404*404.png'),
            fit: BoxFit.scaleDown,
        )
      ),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }

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
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Card(
          child:Container(
            child:new ClockWidget(),
            padding: const EdgeInsets.all(8.0),
            width: 300,
            height: 100,
            alignment: Alignment.center,
            ),
          ),
          Card(
            child: Container(
              child: Text('a practical counter for practicing stoics',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              padding: const EdgeInsets.all(8.0),
              width: 300,
              height: 100,
              alignment: Alignment.center,
            ),
          ),
          Card(
            child:Container(
              child: Text('In your daily travels, you might come across various situations that try to put your stoicabilities to the test. Here is a helper app to distinguish and keep track of the internals, the real things that you actually have to care about',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 7,
              ),
              padding: const EdgeInsets.all(8.0),
              width: 300,
              height: 110,
              alignment: Alignment.center,
            ),
        ),

          Center(
            // TODO: Better design for the button
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
//====================INTERNALSWIDGET======================================================================================================
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
      appBar: AppBar(
          title: Text('Overview Screen'),
          backgroundColor: Colors.black
      ),
      body: ListView.builder(
        itemBuilder: _buildItem,
        itemCount: internals.length,
      ),
      //TODO: Better buttons
      floatingActionButton: FloatingActionButton(
        onPressed: _addInternal,
        child: Icon(Icons.add),
      ),
      //TODO: Better buttons
      bottomSheet: RaisedButton(
          child: Text('Delete'),
          onPressed: _removeInternal,
      ),
    );
  }
}
//================================OVERVIEWSCREEN==================================================================================
class OverviewScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  InternalsList();
  }
}
//TODO: Add functionality to store data locally and or over a server
//================================EOF=============================================================================================