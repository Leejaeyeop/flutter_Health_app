import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'Routine_maker.dart';
import 'package:http/http.dart' as http;
import 'Routine_maker.dart';

////////////////////////// workout_name 받을때 사용////////////////////////////////(pop)


class Popup {  //리턴 값을 받을 모델 클래스
  String workout_name ;
 

  Popup({this.workout_name});

  factory Popup.fromJson(Map<String,dynamic> json) { 
    //Map <String, dynamic>  을 Post 객체로 변환하는 방법
    return Popup(
      
     workout_name: json['workout_name'],
      
      
    );
  } 

}


class RoutinePopup extends StatefulWidget {
    RoutinePopup({Key key,this.temp,this.newtemp,this.modifierNames,this.routine_name,this.area}) : super(key: key);
    String temp;
    bool newtemp;
    List<String> modifierNames = List<String>();
   String routine_name;
   String area;
  @override
  _RoutinePopupState createState() => _RoutinePopupState();
}

class _RoutinePopupState extends State<RoutinePopup> {
Future<Popup> post1;
int k =0;
List<Popup> _posts = [];
List<String> popup = List<String>(); //////////////////
String _text;
Future<Popup> _fetchPost() async {
  final response =
      await http.get('http://dlwoduq789.dothome.co.kr/health/RoutinePop.php');
       if (response.statusCode == 200) {
  final List<Popup> parasedResponse =jsonDecode(response.body) //parasedResponse = response 데이터
       .map<Popup>((json) => Popup.fromJson(json))
       .toList();
        setState(() {
      _posts.clear();
      _posts.addAll(parasedResponse);
      popup.add('운동을 선택해 주세요');
      k=1; 
      for (var i = 0; i < this._posts.length; i++)
        { 
          popup.add(_posts[i].workout_name); }
       });}
       else{
    // 만약 요청이 실패하면, 에러를 던집니다.
    throw Exception('Failed to load post');
  }
}

  @override
  void initState() {
    super.initState();
   post1; _fetchPost();
  }

 @override
  Widget build(BuildContext context) {
    if(k==1)
    return 
    new Routine_maker(popup: popup, temp:widget.temp, 
    modifierNames:widget.modifierNames,area:widget.area,routine_name:widget.routine_name);
    
    return Scaffold(
     appBar: AppBar(title: Text('헬스 App'),),
     body:Center(
       child:CircularProgressIndicator())
       );
       
  }
}
