import 'package:flutter/material.dart';
import 'dart:async';




class AboutTime with ChangeNotifier{
 bool _isRunning = false;
bool _isRunning_2 = false;
bool _endstart = false;
 int _secs = 0;
 
 int _mins = 0;

 int _i =0; 
 int _m =0;
 int j =0;
 Timer _timer;
 Timer _timer_2;
 List<String> _laptime = <String>[];
  
 bool get isRunning => _isRunning; //다른 클래스에서 불러올때
 bool get isRunning_2 => _isRunning_2;
 bool get endstart => _endstart;
 set endstart(bool endstart)=> _endstart = endstart;
 int get seconds => _secs;
 int get minutes => _mins;
 //int get seconds_2 => _secs_2;
 //set seconds_2(int seconds_2)=> _secs_2 = seconds_2;
 List<String> get laptime => _laptime;
 set laptime(List<String> laptime) => _laptime =laptime;

 
 void dispose(){
   _timer?.cancel();
   super.dispose();
 }

 void startTimer(){
  _isRunning = true;
  _timer = Timer.periodic(Duration(milliseconds: 10), (Timer timer) {
   _secs++;
   notifyListeners(); 
   if(_secs >= 6000)
   { _mins = _mins+1;
     _secs = 0;
   }; 
   });
 }

 
 void count(){
  
  _timer_2 = Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
 
   notifyListeners(); 
   
   });
 }
 
 void countStop(){
  
  
  _timer_2?.cancel();
   notifyListeners(); 
   
   
 }

  /*void startTimer_2(){
  _isRunning_2 = true;
  _timer_2 = Timer.periodic(Duration(milliseconds: 10), (Timer timer_2) {
      if(_secs_2 == 0)
   { _mins_2 = _mins_2-1;
     _secs_2 = 5999;
     
     } 
   else{
   _secs_2--;}
   if(_mins_2 < 0 ){
      _secs_2 = 0; _mins_2 = 0;
      _timer_2?.cancel();
      _isRunning_2 = false;
     }
    if(_mins_2 ==0 && _secs_2 <4)
    {   j++;
       if(j == 100)
       {// final player = AudioCache();
        // player.play('note5.wav');
       j=0;}
    } 
   notifyListeners(); 
   });
 }*/



 void pauseTimer(){
   if(_isRunning){
    _timer?.cancel();
    _isRunning = false;
   }
  notifyListeners();
 }



 void resetTimer(){
   _timer?.cancel();
   _secs = 0;
   _mins=0;
   _isRunning = false;
   _laptime.clear();
   notifyListeners();
 }


 
 void recordtime(){
   _timer?.cancel();
   _isRunning = false;
   _laptime.insert(0, '${_mins ~/ 60}'+'시간''${_mins % 60}'+'분''${_secs ~/ 100}'+'초');
   _secs = 0;
   notifyListeners();
 }

 
}


