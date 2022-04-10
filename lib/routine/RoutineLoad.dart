import 'dart:async';
import 'dart:convert';
import 'package:health_app/MyTabs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum SelectedQW { //enum 변수 생성
  only,both
  
}

class RPost {  //리턴 값을 받을 모델 클래스
  String workout_name ;
  String routine_name;
  String area;
  int set_count ;
  int weight  ;
  int count ;
  


  RPost({this.workout_name, this.set_count, this.weight,this.count,this.routine_name,this.area }); //

  factory RPost.fromJson(Map<String,dynamic> json) { 
    //Map <String, dynamic>  을 Post 객체로 변환하는 방법
    return RPost(
     workout_name: json['workout_name'],
     set_count: json['set_count'],
     weight: json['weight'],
     count : json['count'],
     routine_name: json['routine_name'],
     area: json['area'], 
    );
  } 

}


class RoutineLoad extends StatefulWidget {
  
     String routine_name1; 
    RoutineLoad({Key key,this.routine_name1}) : super(key: key);
   
  @override
  _RoutineLoadState createState() => _RoutineLoadState();
}

class _RoutineLoadState extends State<RoutineLoad> {
Future<RPost> post1;
List<RPost> _posts = [];
bool loaded = false; //로딩 완료
SelectedQW selectedQW;


 



Future<RPost> fetchPost() async {
  final response =
      await http.post('http://dlwoduq789.dothome.co.kr/health/Routine_Load.php',
       headers: <String, String> {
         'Content-Type': 'application/x-www-form-urlencoded',},
           body: <String, String> {
           'routine_name': widget.routine_name1,
        },);
       if (response.statusCode == 200) {
  final List<RPost> parasedResponse =jsonDecode(response.body) //parasedResponse = response 데이터
       .map<RPost>((json) => RPost.fromJson(json))
       .toList();
        setState(() {
      _posts.clear();
      _posts.addAll(parasedResponse);
      loaded=true;
       });}
       else{
    // 만약 요청이 실패하면, 에러를 던집니다.
    throw Exception('Failed to load post');
  }
}

  @override
  void initState() {
    super.initState();
    post1=fetchPost();
  }

  
 @override
  Widget build(BuildContext context) {
    if(loaded)
    return MaterialApp(
          theme: ThemeData.light().copyWith(
          primaryColor: Color(0xFF0A0E21),
          scaffoldBackgroundColor:Color(0xFF0A0E21),
         ),
        home: MyTabs(routineList:_posts));
    return Scaffold(
     appBar: AppBar(title: Text('헬스 App'),),
     body:Center(
       child:CircularProgressIndicator())
       );
       
  }
  
}
