import 'dart:async';


import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';


class Gyro extends StatefulWidget {
  GyroState createState() => new GyroState();
  
 
}

class GyroState extends State<Gyro> {
  List<double> _gyroscopeValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];


  @override
  void initState() {
     _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[event.x, event.y, event.z];
              });
    }));
    super.initState();
  }
    

 
 void dispose() {
    
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }
 

  @override
 
  Widget build(BuildContext context) {
   
    final List<String> gyroscope =
        _gyroscopeValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    
    return new Text('Gyroscope: $gyroscope');
  }
}