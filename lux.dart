import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:light/light.dart';

class Lux extends StatefulWidget {
  LuxState createState() => new LuxState();
  @override
  LuxState getLL(){
    return LuxState();
  }
 
}

class LuxState extends State<Lux> {
    Light _light;
    String luxString ='no';


  @override
  void initState() {
    initPlatformState();
    super.initState();
  }
    void _onData(int luxValue) async {
    print("Lux value: $luxValue");
    setState(() {
      print(luxValue);
      luxString = "$luxValue";
       print("Lux STR ici1: $luxString");

        //_chrono();
     
    });
  }
  void _onDone() {

  }

  void _onError(error) {
    // Handle the error
  }
  
    Future<void> initPlatformState() async {
    _light = new Light();

    _light.lightSensorStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);

      
  }

 

  @override
  String getLux(LuxState){
        print("Lux STR getteurs: $luxString");

    return LuxState.luxString;
  }
  Widget build(BuildContext context) {
    print("Lux STR ici 2: $luxString");
    
    return new Text('$luxString');
  }
}