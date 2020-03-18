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

  final _controller = TextEditingController();


  
  
  

  //String luxString = new Lux().getLL().getLux();
  String _wifi="inconnu";
  int _count=0;
   String _monrouteur= "inconnu";
  final Lux Luxi = new Lux();


  

  // Platform messages are asynchronous, so we initialize in an async method.
  

  @override
   void initState() {
  _controller.addListener(_print);
    super.initState();
  }
    

  void dispose() {
   
    super.dispose();
   _controller.dispose();
  }

 _print(){
    print(_controller.text);
  }

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
          new RepaintBoundary(
            child: new SizedBox(
              height: 22.0,
              child: 
              TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                      hintText: "wifiIP....", labelText: 'wifiIP'),
                ),
         
                
              //new Text(new Lux().getLL().getLux()),
              
              //new Text('Running on : $luxString'),
            ),
          ),
          new RepaintBoundary(
            child: new SizedBox(
              height: 22.0,
              child: 
           new RaisedButton(
                  onPressed: () async {
                    _wifi=_controller.text;
                     print(_wifi);
                     
                    
                  },
                  child: const Text("actualiser mon routeur de wifi"),
                ),
                 ),
          ),
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
              new Text(Luxi.getLL().getLux()),
              //Luxi,
              //new Text('Running on : $luxString'),
            ),
          ),
          
         /* new Padding(
          child: new Text('mon routeur : $_wifi\n'),
           padding: const EdgeInsets.all(16.0),
          ),
           new Padding(
          child: new Text('le routeur wifi actuel : $_wifi\n'),
           padding: const EdgeInsets.all(16.0),
          ), */
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