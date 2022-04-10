import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Data_out {
   Data_out({@required this. workout_name,@required this. set_count,@required this.weight,@required this.count,});

   String workout_name;
   int set_count;
   int weight;
   String count;


void postRequest() async {
        String url = 'http://dlwoduq789.dothome.co.kr/health/Register_health.php';
         http.Response response = await http.post(
           url,
          headers: <String, String> {
         'Content-Type': 'application/x-www-form-urlencoded',},
           body: <String, String> {
           'workout_name': workout_name,
           'set_count' : '$set_count',
           'weight' : '$weight',
           'count' :  count,
        },
    );
}

}

class RoutineData_out {
   RoutineData_out({@required this. routine_name,@required this. workout_name,@required this.area});
  
   String routine_name;
   String workout_name;
   String area;
  


void rpostRequest() async {
        String url = 'http://dlwoduq789.dothome.co.kr/health/Routine_Register.php';
         http.Response response = await http.post(
           url,
          headers: <String, String> {
         'Content-Type': 'application/x-www-form-urlencoded',},
           body: <String, String> {
           'workout_name': workout_name,
           'routine_name': routine_name,
           'area': area,
           
        },
    );
}

}

class Resultrecord {
   Resultrecord({@required this.routine_name,@required this.area,@required this.workout_name,@required this.set_count,@required this.weight,@required this.count,@required this.resultTime,@required this.totalRestTime,@required this.state});
  
  String today = DateFormat('yyyy,MM,dd').format(new DateTime.now());
  String routine_name;
  String area;
  String workout_name;
  int set_count;
  int weight;
  int count;
  String resultTime;
  int totalRestTime;
  String state;
   
  
     
//routine_name: null, area: null, workout_name: null,set_count: ,weight: ,count: ,resulTime: ,totalRestTime
void resultpost() async {
        String url = 'http://dlwoduq789.dothome.co.kr/health/Record.php';
         http.Response response = await http.post(
           url,
          headers: <String, String> {
         'Content-Type': 'application/x-www-form-urlencoded',},
           body: <String, String> {
          'today' :today,   
          'routine_name': routine_name,
          'area': area,
           'workout_name': workout_name,
           'set_count': '$set_count',
           'weight': '$weight',
            'count': '$count',
           'resultTime': resultTime,
           'totalRestTime': '$totalRestTime',
            'state': state
         
           
           
        },
    );
}

}

class Delete {
   Delete({@required this. workout_name});
   String workout_name;
  

void postRequest() async {
        String url = 'http://dlwoduq789.dothome.co.kr/health/Delete.php';
         http.Response response = await http.post(
           url,
          headers: <String, String> {
         'Content-Type': 'application/x-www-form-urlencoded',},
           body: <String, String> {
           'workout_name': workout_name,

        },
    );
}

}

class Delete_Routine {
   Delete_Routine({@required this. routine_name});
   String routine_name;
  

void postRequest() async {
        String url = 'http://dlwoduq789.dothome.co.kr/health/DeleteRoutine.php';
         http.Response response = await http.post(
           url,
          headers: <String, String> {
         'Content-Type': 'application/x-www-form-urlencoded',},
           body: <String, String> {
           'routine_name': routine_name,

        },
    );
}

}



