import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'time.dart';
import 'lux.dart';
import 'acce.dart';
import 'gyro.dart';
import 'connect.dart';


// Sets a platform override for desktop to avoid exceptions. See
// https://flutter.dev/desktop#target-platform-override for more info.
void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() {
  _enablePlatformOverrideForDesktop();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}






class _MyHomePageState extends State<MyHomePage> {
  final Dependencies dependencies = new Dependencies();

  Timer timer;
  int milliseconds;
  final _controller = TextEditingController();

  String _connectionStatus = 'Unknown';
  
  
  

  //String luxString = new Lux().getLL().getLux();
  String _wifi="inconnu";
  int _count=0;
   String _monrouteur= "inconnu";
  final Lux Luxi = new Lux();


  void leftButtonPressed() {
    setState(() {
      if (dependencies.stopwatch.isRunning) {
        print("${dependencies.stopwatch.elapsedMilliseconds}");
      } else {
        dependencies.stopwatch.reset();
        dependencies.stopwatch.start();
      }
    });
  }

  void rightButtonPressed() {
    setState(() {
      if (dependencies.stopwatch.isRunning) {
        dependencies.stopwatch.stop();
      } 
    });
  }



    
  @override
  void initState() {
    super.initState();
    timer = new Timer.periodic(new Duration(milliseconds: dependencies.timerMillisecondsRefreshRate), callback);
    _controller.addListener(_print);
   
    
   
    
  }

  @override
  void callback(Timer timer) {
    if (milliseconds != dependencies.stopwatch.elapsedMilliseconds) {
      milliseconds = dependencies.stopwatch.elapsedMilliseconds;
      final int hundreds = (milliseconds / 10).truncate();
      final int seconds = (hundreds / 100).truncate();
      final int minutes = (seconds / 60).truncate();
      final int hours = (minutes / 60).truncate();
      final ElapsedTime elapsedTime = new ElapsedTime(
        hundreds: hundreds,
        seconds: seconds,
        minutes: minutes,
        hours : hours,
      );
      for (final listener in dependencies.timerListeners) {
        listener(elapsedTime);
      }
    }
  }
  /*_chrono(){
    if(_count==0){
    if( _wifi==_monrouteur && int.parse(_luxString)<5 && (_accelerometerValues[0]+_accelerometerValues[1]+_accelerometerValues[2])<10.5 && (_accelerometerValues[0]+_accelerometerValues[1]+_accelerometerValues[2])>9.0 && (_gyroscopeValues[0]+_gyroscopeValues[1]+_gyroscopeValues[2])<0.1 && (_gyroscopeValues[0]+_gyroscopeValues[1]+_gyroscopeValues[2])>(-0.1) && (_accelerometerValues[0] > 9.5 || _accelerometerValues[1]>9.5 || _accelerometerValues[2] > 9.5) ){
      _count=1;
      leftButtonPressed();

    }
    }
    else{
      if( _wifi!=_monrouteur || int.parse(_luxString)>5 || (_accelerometerValues[0]+_accelerometerValues[1]+_accelerometerValues[2])>10.5 || (_accelerometerValues[0]+_accelerometerValues[1]+_accelerometerValues[2])<9.0 || (_gyroscopeValues[0]+_gyroscopeValues[1]+_gyroscopeValues[2])>0.1 || (_gyroscopeValues[0]+_gyroscopeValues[1]+_gyroscopeValues[2])<(-0.1) ){
      _count=0;
      rightButtonPressed();
    }
    }
    
  }
  */
  void dispose() {
    timer?.cancel();
    timer = null;
    _controller.dispose();

    super.dispose();
   
  }
  _print(){
    print(_controller.text);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  

  @override
  Widget build(BuildContext context) {
    


    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: new Container(
      margin: const EdgeInsets.only(left: 8.0, right: 8.0),
       child : new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[ 
          new TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                      hintText: "wifiIP....", labelText: 'wifiIP'),
                ),
          new RaisedButton(
                  onPressed: () async {
                    _wifi=_controller.text;
                     print(_wifi);
                     
                    
                  },
                  child: const Text("actualiser mon routeur de wifi"),
                ),
          new Center(child: Text('Connection Status: $_connectionStatus')),
          /*new Padding(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text('Accelerometer: $accelerometer'),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
          ),
          */
          /*
          new Padding(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text('Gyroscope: $gyroscope'),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
          ),
          */
           new RepaintBoundary(
            child: new SizedBox(
              height: 22.0,
              child: 
              //new Text(new Lux().getLL().getLux()),
              Luxi,
              //new Text('Running on : $luxString'),
            ),
          ),
          new RepaintBoundary(
            child: new SizedBox(
              height: 22.0,
              child: 
              //new Text(new Lux().getLL().getLux()),
              new Acce(),
              //new Text('Running on : $luxString'),
            ),
          ),
          new RepaintBoundary(
            child: new SizedBox(
              height: 22.0,
              child: 
              //new Text(new Lux().getLL().getLux()),
              new Gyro(),
              //new Text('Running on : $luxString'),
            ),
          ),
          new RepaintBoundary(
            child: new SizedBox(
              height: 72.0,
              child: 
              //new Text(new Lux().getLL().getLux()),
              new Connect(),
              //new Text('Running on : $luxString'),
            ),
          ),
          new RepaintBoundary(
            child: new SizedBox(
              height: 22.0,
              child: 
              new Text(Luxi.getLL().getLux(Luxi.getLL())),
              //Luxi,
              //new Text('Running on : $luxString'),
            ),
          ),
          
          new Padding(
          child: new Text('mon routeur : $_wifi\n'),
           padding: const EdgeInsets.all(16.0),
          ),
           new Padding(
          child: new Text('le routeur wifi actuel : $_monrouteur\n'),
           padding: const EdgeInsets.all(16.0),
          ),
           new Padding(
          child: new Text('je dors depuis : $_count\n'),
           padding: const EdgeInsets.all(16.0),
          ),
          new RepaintBoundary(
            child: new SizedBox(
              height: 72.0,
              child: new MinutesAndSeconds(dependencies: dependencies),
            ),
          ),
         
          
          
          ],
          
      ),
      ),
    );
  }
 
  




}