import 'dart:async';

import 'package:flutter/material.dart';
import 'package:light/light.dart';

class Lux extends StatefulWidget {
  LuxState createState() => new LuxState();
}

class LuxState extends State<Lux> {
    Light _light;
    String _luxString = 'Unknown';


  @override
  void initState() {
    initPlatformState();
    super.initState();
  }
    void _onData(int luxValue) async {
    print("Lux value: $luxValue");
    setState(() {
      _luxString = "$luxValue";
        //_chrono();
     
    });
  }
  void _onDone() {}

  void _onError(error) {
    // Handle the error
  }
    Future<void> initPlatformState() async {
    _light = new Light();
    _light.lightSensorStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
      
  }

 

  @override
  Widget build(BuildContext context) {
    
    return new Text('$_luxString');
  }
}