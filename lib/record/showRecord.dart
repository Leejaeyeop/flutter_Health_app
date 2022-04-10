import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'showRecord_Detail.dart';

enum SelectedQW { //enum 변수 생성
  only,both
  
}

class RecordPost {  //리턴 값을 받을 모델 클래스
  //today 는 widget임
  String routine_name; //중복
  String area;
  String resultTime;
  int totalRestTime;

  String state;
  String workout_name;
  int set_count;
  int weight;
  int count;
 
   
  RecordPost({@required this.routine_name,@required this.area,@required this.workout_name,@required this.set_count,@required this.weight,@required this.count,@required this.resultTime,@required this.totalRestTime,@required this.state});

  factory RecordPost.fromJson(Map<String,dynamic> json) { 
    //Map <String, dynamic>  을 RecordPost 객체로 변환하는 방법
    return RecordPost(

      workout_name: json['workout_name'],
      set_count: json['set_count'],
      weight: json['weight'],
      count : json['count'],
      routine_name: json['routine_name'],
      area: json['area'],
      resultTime: json['resultTime'],
      totalRestTime : json['totalRestTime'],
      state : json['state']


    );
  } 

}


class ShowRecord extends StatefulWidget {
  
     String today; 
    ShowRecord({Key key,this.today}) : super(key: key);
   
  @override
  _ShowRecordState createState() => _ShowRecordState();
}

class _ShowRecordState extends State<ShowRecord> {
Map<String, List> _records;
List<String> _workout_name;
Future<RecordPost> post1;
List<RecordPost> _posts = [];
int k = 0;
SelectedQW selectedQW;

    


Future<RecordPost> _fetchRecordPost() async {
  final response =
      await http.post('http://dlwoduq789.dothome.co.kr/health/Record_Load.php',
       headers: <String, String> {
         'Content-Type': 'application/x-www-form-urlencoded',},
           body: <String, String> {
           'today': widget.today,
        },);
       if (response.statusCode == 200) {
  final List<RecordPost> parasedResponse =jsonDecode(response.body) //parasedResponse = response 데이터
       .map<RecordPost>((json) => RecordPost.fromJson(json))
       .toList();
        setState(() {
      _posts.clear();
      _posts.addAll(parasedResponse);
      data_input(_posts);
     
       });}
       else{
    // 만약 요청이 실패하면, 에러를 던집니다.
    throw Exception('Failed to load post');
  }
}

void data_input( List<RecordPost> _posts )
{
     List<String> workout_name = List<String>();
     for (var i = 0; i < _posts.length; i++)
     {workout_name.add(_posts[i].workout_name);}
     _workout_name = workout_name.toSet().toList(); //List 중복 제거
      
      
      
     _records={
       
      for(var k =0; k< _workout_name.length; k++)
     _workout_name[k] :[
      for (var i = 0; i < _posts.length; i++) 
      if ( _workout_name[k]==_posts[i].workout_name) 
      '무계:${_posts[i].weight}KG 개수:${_posts[i].count}개                              '+_posts[i].state,]

            };
        
      k=1;




}

  @override
  void initState() {
    super.initState();
    post1=_fetchRecordPost();
     

  }

  @override
  Widget build(BuildContext context) {
        return  Scaffold(
         body: Center(
          child:FutureBuilder<RecordPost>(
           future :post1,
           builder: (BuildContext context, AsyncSnapshot snapshot){
             if(k==1)
          {
             return 
             Scaffold(
        body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[  //ListView.builder = Expanded 필요
          
          Container(
           width: double.infinity,  
          color: Colors.blue,
          child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Text('운동일  '+widget.today,    
            style: TextStyle(
               color: Colors.white,
               fontSize: 30.0,
               fontFamily: 'helvetica_neue_light',
                ),
             textAlign: TextAlign.center,),
            Text('총 휴식 시간  '+_posts[0].totalRestTime.toString() +'초',    
            style: TextStyle(
               color: Colors.white,
               fontSize: 30.0,
               fontFamily: 'helvetica_neue_light',
                ),
             textAlign: TextAlign.center,),
            Text('루틴 이름  '+_posts[0].routine_name.toString(),    
            style: TextStyle(
               color: Colors.white,
               fontSize: 30.0,
               fontFamily: 'helvetica_neue_light',
                ),
             textAlign: TextAlign.center,)
            ]
            )),
           
         Expanded(child: 
            ListView.builder(
               itemCount: this._workout_name.length,
               itemBuilder:(context,index){
               return GestureDetector(
            onTap: () {
            //print(_records[_workout_name[index]]);
       
            Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) 
                  => new  ShowRecord_Detail(record:_records[_workout_name[index]])
                  
                ),
              );


            },
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Text(_workout_name[index]),
              //subtitle: Text('${post.set_count}세트 ${post.weight}KG ${post.count}개',),
              color: index % 2 == 0 ? Colors.grey[200] : Colors.white,
            ),
          );
         })),
               
               ]));
          
     
          }
            
           
          else{ return CircularProgressIndicator();}


            })


         
        ),);
  }
}



