import 'dart:async';


import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';


class Acce extends StatefulWidget {
  AcceState createState() => new AcceState();
  AcceState getAA(){
    return AcceState();
  }
  
 
}

class AcceState extends State<Acce> {
     List<double> _accelerometerValues;
     List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];
      final List<String> accelerometer =null;
      



  @override
  void initState() {
    _streamSubscriptions.add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = <double>[event.x, event.y, event.z];
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
 List<String> getAcce(){
        print("Acce  getteurs: $accelerometer");

    return accelerometer;
  }
  Widget build(BuildContext context) {
    final List<String> accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    
    return new Text('Accelerometer: $accelerometer');
  }
}