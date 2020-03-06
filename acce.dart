import 'dart:async';


import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';


class Acce extends StatefulWidget {
  AcceState createState() => new AcceState();
  
 
}

class AcceState extends State<Acce> {
     List<double> _accelerometerValues;
     List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];



  @override
  void initState() {
    _streamSubscriptions.add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = <double>[event.x, event.y, event.z];
              });
    }));
    super.initState();
  }
    

 

 

  @override
 
  Widget build(BuildContext context) {
    final List<String> accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    
    return new Text('Accelerometer: $accelerometer');
  }
}