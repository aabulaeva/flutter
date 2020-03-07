
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class ElapsedTime {
  final int hundreds;
  final int seconds;
  final int minutes;
  final int hours;

  ElapsedTime({
    this.hundreds,
    this.seconds,
    this.minutes,
    this.hours,
  });
}class Dependencies {

  final List<ValueChanged<ElapsedTime>> timerListeners = <ValueChanged<ElapsedTime>>[];
  final TextStyle textStyle = const TextStyle(fontSize: 32.0, fontFamily: "Bebas Neue");
  final Stopwatch stopwatch = new Stopwatch();
  final int timerMillisecondsRefreshRate = 30;
}
class MinutesAndSeconds extends StatefulWidget {
  MinutesAndSeconds({this.dependencies});
  final Dependencies dependencies;

  MinutesAndSecondsState createState() => new MinutesAndSecondsState(dependencies: dependencies);
}
class MinutesAndSecondsState extends State<MinutesAndSeconds> {
  MinutesAndSecondsState({this.dependencies});
  final Dependencies dependencies;
  int hours =0;
  int minutes = 0;
  int seconds = 0;
  Timer timer;
  int milliseconds;

  @override
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
    dependencies.timerListeners.add(onTick);
    timer = new Timer.periodic(new Duration(milliseconds: dependencies.timerMillisecondsRefreshRate), callback);
    leftButtonPressed();
    
   
    
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

    super.dispose();
   
  }

  

  void onTick(ElapsedTime elapsed) {
    if (elapsed.hours != hours || elapsed.seconds != seconds) {
      setState(() {
        minutes = elapsed.minutes;
        seconds = elapsed.seconds;
        hours = elapsed.hours;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    return new Text('$hoursStr:$minutesStr:$secondsStr.', style: dependencies.textStyle);
  }
}


class Hundreds extends StatefulWidget {
  Hundreds({this.dependencies});
  final Dependencies dependencies;

  HundredsState createState() => new HundredsState(dependencies: dependencies);
}

class HundredsState extends State<Hundreds> {
  HundredsState({this.dependencies});
  final Dependencies dependencies;

  int hundreds = 0;

  @override
  void initState() {
    dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.hundreds != hundreds) {
      setState(() {
        hundreds = elapsed.hundreds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');
    return new Text(hundredsStr, style: dependencies.textStyle);
  }
}