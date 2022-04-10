import 'RoutineCard.dart';
import 'package:flutter/material.dart';
import 'RoutinePop.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:health_app/Data_out.dart';

  class RoutinePost {  //리턴 값을 받을 모델 클래스
  String routine_name;
  String area;
  String workout_name ;
  String set_count ;

  

  RoutinePost({this.routine_name,this.area,this.workout_name, this.set_count,});

  factory RoutinePost.fromJson(Map<String,dynamic> json) { 
    //Map <String, dynamic>  을 Post 객체로 변환하는 방법
    return RoutinePost(
     routine_name : json['routine_name'],
     area : json['area'],
     workout_name: json['workout_name'],
     set_count: json['set_count'],
    );
  } 

}



class Routine extends StatefulWidget{
  Routine({Key key,}) : super(key: key);

     _RoutineState createState() => _RoutineState();
}


class _RoutineState extends State<Routine>{
Future<RoutinePost> post1;
List<RoutinePost> _posts = [];
List<String> modifierNames = List<String>();
bool loaded = false;

Future<RoutinePost> _fetchPost() async {
  final response =
      await http.post('http://dlwoduq789.dothome.co.kr/health/Routine_Cardmaker.php');
       if (response.statusCode == 200) {
  final List<RoutinePost> parasedResponse =jsonDecode(response.body) //parasedResponse = response 데이터
       .map<RoutinePost>((json) => RoutinePost.fromJson(json))
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
    post1=_fetchPost();
  }

   
//////////////////////////////////////////////////
    Widget build(BuildContext context){
     return Scaffold(
       //backgroundColor: Colors.red,
        body: SingleChildScrollView(
       child:Column(
        children: <Widget>[    
          Container( 
            padding: EdgeInsets.only(top: 20),
            width: double.infinity,
            height: 70,
          child:FlatButton(
            textColor: Colors.white,
            color: Colors.green,
            child: Text('Add New Routine'),
            onPressed: (){
           routine_new(context,new RoutinePopup());
          },              
            )),
       FutureBuilder<RoutinePost>(
       future :post1,
       builder: (BuildContext context, AsyncSnapshot snapshot){
      if(loaded)
       {
         return Column(
      children: <Widget>[   
         
////////////////////////////////////////////////////////////////////////레이아웃//////////////////////////////////////////////////////////////////////////
          if(_posts!= null)
          for(var i =0; i< this._posts.length; i++ ) 
          if (i==0)
          Stack(
          children: <Widget>[ 
          RoutineCard(posts:_posts,routine_name:_posts[0].routine_name,area: _posts[0].area,i:i),
          Positioned(
          top: 120,
          right: 50,
          child:
          GestureDetector( /////////////////////// 취소
          onTap: (){
             Delete_Routine delete = Delete_Routine(routine_name: _posts[0].routine_name);
            delete.postRequest();   
           
             Future.delayed(const Duration(milliseconds: 10), () { 
             setState(() {
               loaded = false;
             _fetchPost();
             });
             });
           
           
           
          },
          child:Text('Delete',
          style: TextStyle(   
          fontFamily: 'Langar',
          fontSize: 20.0,
          color: Colors.red,
          fontWeight: FontWeight.bold),),)),
          Positioned(
          top: 120,
          left: 50,
          child:
          GestureDetector( /////////////////////// 변경
          onTap: (){ 
             setState(() {         
           for(var j =i; j< _posts.length; j++ ) 
            {if( _posts[j].routine_name == _posts[i].routine_name)
            {modifierNames.add(_posts[j].workout_name);  
            }}
          });  
          routine_new(context,new RoutinePopup(modifierNames:modifierNames,routine_name:_posts[0].routine_name,area: _posts[0].area) );
          
           
          },
          child:Text('Modify',
          style: TextStyle(   
          fontFamily: 'Langar',
          fontSize: 20.0,
          color: Colors.blue,
          fontWeight: FontWeight.bold),),)),
          ])


          else
          _posts[i].routine_name == _posts[i-1].routine_name ?
          Row()
         : 
          Stack(
          children: <Widget>[ 
         RoutineCard(posts:_posts,routine_name:_posts[i].routine_name,area: _posts[i].area,i:i),
          Positioned(
          top: 120,
          right: 50,
          child:
          GestureDetector( /////////////////////// 취소
          onTap: (){
          Delete_Routine delete = Delete_Routine(routine_name: _posts[i].routine_name);
          delete.postRequest(); 
          Future.delayed(const Duration(milliseconds: 10), () {
             setState(() { 
               loaded = false;
             _fetchPost();
             });
             });
           
          },
          child:Text('Delete',
          style: TextStyle(   
          fontFamily: 'Langar',
          fontSize: 20.0,
          color: Colors.red,
          fontWeight: FontWeight.bold),),)),
          Positioned(
          top: 120,
          left: 50,
          child:
          GestureDetector( /////////////////////// 변경
          onTap: (){ 
            setState(() {         
             setState(() {         
           for(var j =i; j< _posts.length; j++ ) 
            {if( _posts[j].routine_name == _posts[i].routine_name)
            {modifierNames.add(_posts[j].workout_name);  
            }}
          });  
            
            routine_new(context,new RoutinePopup(modifierNames:modifierNames,routine_name:_posts[i].routine_name,area: _posts[i].area));
            
        
          });  
          },
          child:Text('Modify',
          style: TextStyle(   
          fontFamily: 'Langar',
          fontSize: 20.0,
          color: Colors.blue,
          fontWeight: FontWeight.bold),),)),
          ])
         
         
         
       ] );}
          else{ return CircularProgressIndicator();}
       }),
          
        ],

        ),
     )
     );
     

    }

    routine_new(BuildContext context, movepage) async {
    // Navigator.push는 Future를 반환합니다. Future는 선택 창에서 
    // Navigator.pop이 호출된 이후 완료될 것입니다.
    final inputs = 
    await Navigator.of(context).push( MaterialPageRoute(builder: (context) => movepage),);
     
    setState(() {
     loaded=false;
      _fetchPost();
     
    });
  }

}