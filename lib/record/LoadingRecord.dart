import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'record.dart';
import 'package:http/http.dart' as http;

////////////////////////// workout_name 받을때 사용////////////////////////////////(pop)

class Post {  
  String today ;
  Post({this.today});
  factory Post.fromJson(Map<String,dynamic> json) { 
    return Post( 
     today: json['today'],
    );
  } 
}


class LoadingRecord extends StatefulWidget {
    
  @override
  _LoadingRecordState createState() => _LoadingRecordState();
}

class _LoadingRecordState extends State<LoadingRecord> {
  
Future<Post> post1;
bool loaded;
List<Post> days = [];

  Future<Post> _fetchPost() async {
  final response =
      await http.post('http://dlwoduq789.dothome.co.kr/health/RecordDate.php');
       if (response.statusCode == 200) {
  final List<Post> parasedResponse =jsonDecode(response.body) //parasedResponse = response 데이터
       .map<Post>((json) => Post.fromJson(json))
       .toList();
        setState(() {
      days.clear();
      days.addAll(parasedResponse);
      loaded=true;
       });
       
       }
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
    if(loaded)
    return new Record(days:days);
    
    return Scaffold(
     body:Center(
       child:CircularProgressIndicator())
    ); 
  }
}
