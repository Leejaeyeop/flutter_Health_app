
import 'package:flutter/material.dart';
import 'package:health_app/workout/Workout_maker.dart';
import 'myselect.dart';
import 'package:direct_select/direct_select.dart';
import 'package:health_app/workout/workoutLoad.dart';
import 'package:health_app/Data_out.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
enum Workout_load { //enum 변수 생성
  not,
  sel
}

class Post1 {  //리턴 값을 받을 모델 클래스
  String workout_name ;
  int set_count ;
  int weight  ;
  int count ;
  
  Post1({this.workout_name, this.set_count, this.weight,this.count, });

  factory Post1.fromJson(Map<String,dynamic> json) { 
    //Map <String, dynamic>  을 Post 객체로 변환하는 방법
    return Post1(
     workout_name: json['workout_name'],
      set_count: json['set_count'],
      weight: json['weight'],
      count : json['count'],
      
    );
  } 

}

 
class Routine_maker extends StatefulWidget{
 
 
  @override
  final List<String> popup; 
  String temp;
 

  List<String> modifierNames = List<String>();//modifier 용
  String routine_name;//modifier 용
  String area; //modifier 용

  Routine_maker({ Key key, this.popup,this.temp,
  this.modifierNames,this.routine_name,this.area,}) :super(key: key);
  

     Routine_makerState createState() => Routine_makerState();
 
    }
  



class Routine_makerState extends State<Routine_maker>  {
 
  
Map<String, List<List<dynamic>>> workout_list;  
Future<Post1> post1;
 List<Post1> posts = [];
  String temp;
  bool cancle_;
  Workout_load workout_load;
  List<String> savedList = List<String>(); 
  bool new1 =true;
  int k;
  bool newtemp =false;
  String workout_name1;
  int selectedIndex1 = 0;
            List<Widget> _buildItems1() {
            return widget.popup
            .map((val) => MySelectionItem(
               title: val,
              ))
                 .toList();
              }
String inputs=''; //루틴 이름
String inputs2 =''; //area 
bool work_modi = false;

                       //savedList.add(temp) 
 //***********************************************************************************//

Future<Post1> _fetchPost(String workout_name) async {
  
  final response =
      await http.post('http://dlwoduq789.dothome.co.kr/health/WorkoutLoad.php',
       headers: <String, String> {
         'Content-Type': 'application/x-www-form-urlencoded',},
           body: <String, String> {
           'workout_name': workout_name,
        },);
       if (response.statusCode == 200) {
  final List<Post1> parasedResponse =jsonDecode(response.body) //parasedResponse = response 데이터
       .map<Post1>((json) => Post1.fromJson(json))
       .toList();
        setState(() {
      posts.clear();
      posts.addAll(parasedResponse);  

    
      workout_list[workout_name] = 
      [ for (var q = 0; q < posts.length; q++) [
      posts[q].workout_name,
      posts[q].set_count,
      posts[q].weight,
      posts[q].count,
      ], ];
      
      if (savedList.contains(workout_name) == false) {
        savedList.add(workout_name);
      }
      
    
       });}
       else{
    // 만약 요청이 실패하면, 에러를 던집니다.
    throw Exception('Failed to load post');
  }
}
 
 @override
  void initState() {
    super.initState();
   workout_list = {};
   }

 

  
 

 @override
Widget build(BuildContext context){


if(widget.modifierNames != null && new1 == true)  ///////// 루틴 변경시
{ inputs= widget.routine_name;
  inputs2 = widget.area;
  for(var i=0; i<widget.modifierNames.length; i++){
    
    _fetchPost(widget.modifierNames[i]);
  }
  new1=false;
}


if(newtemp ==true)  /////////새로 재작시
{_fetchPost(workout_name1); newtemp=false; k= savedList.length;
widget.popup.add(workout_name1);
}

if (cancle_ ==true) { //운동 취소
      Future.delayed(const Duration(milliseconds: 20), () {
      setState(() { k = savedList.length;  });
       });
   //    k = savedList.length; 
     
    cancle_ = false; 
}


if (work_modi == true) {
  k=0;
  Future.delayed(const Duration(milliseconds: 100), () {
      setState(() { k = savedList.length;  });
       });
  work_modi = false;     
}
else{k = savedList.length;}

//print(workout_name);
//print(cancle_);
//print(k);


  return Scaffold(
       appBar: AppBar(title: Text('헬스 App'),),
       backgroundColor: Colors.white,
        body: SingleChildScrollView(
        child:Column(
        
        children: <Widget>[
          Row(
            children: <Widget>[
             Row(   
           children: <Widget>[     
             SizedBox(width: 20.0,),
            Container(
              width: 60,
              child:Text(
            '루틴 이름'
             ,style: TextStyle(fontSize: 15,color:Colors.black),
           ),) ,
             Container(
           margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
           color: Colors.white,
            width: 200,
        child:TextField(
         style: TextStyle(fontSize: 15,color:Colors.black),
         textAlign: TextAlign.center,
          decoration: InputDecoration(
           hintText: widget.modifierNames !=null?
               widget.routine_name
                 :'루틴 이름'   
         ),
       onChanged: (String routine_name){
                setState(() => inputs = routine_name);
              },
            )
          ),]),
         
          widget.modifierNames != null?
            Container( 
             padding: EdgeInsets.only(right:10 ,top: 30),
            width: 80,
            height: 70,
          child:FlatButton(
            textColor: Colors.white,
            color: Colors.teal,
            child: Text('수정'),
            onPressed: (){

              Delete_Routine delete = Delete_Routine(routine_name: widget.routine_name);
              delete.postRequest();

              Future.delayed(const Duration(milliseconds: 100), () {
              for (var i = 0; i <  savedList.length; i++) {
              RoutineData_out out = RoutineData_out( routine_name: inputs, workout_name: savedList[i], area: inputs2,);
              out.rpostRequest();
              }
              //Navigator.of(context).pop();
                  
            });
              Future.delayed(const Duration(milliseconds: 20), () {
              Navigator.pop(context,inputs);   
               } );
               
           },))
          :Container( 
             padding: EdgeInsets.only(right:10 ,top: 30),
            width: 80,
            height: 70,
          child:FlatButton(
            textColor: Colors.white,
            color: Colors.teal,
            child: Text('저장'),
            onPressed: (){
              for (var i = 0; i <  savedList.length; i++) {
              RoutineData_out out = RoutineData_out( routine_name: inputs, workout_name: savedList[i], area: inputs2,);
              out.rpostRequest();
              }
               Navigator.pop(context, inputs); 
           
               
           },)),
          ]
          ),
                    Row(   
           children: <Widget>[     
             SizedBox(width: 20.0,),
            Container(
              width: 60,
              child:Text(
            '운동 부위'
             ,style: TextStyle(fontSize: 15,color:Colors.black),
           ),) ,
             Container(
           margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
           color: Colors.white,
            width: 200,
 
        child:TextField(
         style: TextStyle(fontSize: 15,color:Colors.black),
         textAlign: TextAlign.center,
          decoration: InputDecoration(
        hintText: widget.modifierNames !=null?
               widget.area
                 :'운동 부위'  
         ),
          onChanged: (String area){
                setState(() => inputs2 = area);
              },
            )
          ),]),      

           Container( 
             padding: EdgeInsets.only(top: 30),
            width: 150,
            height: 80,
          child:FlatButton(
            textColor: Colors.white,
            color: Colors.teal,
            child: Text('운동 추가'),
            onPressed: (){
            workout_new(context);
           /* Navigator.push(context,
            MaterialPageRoute(
            builder: (context) => Workout_maker(),  
            )
            );*/
            
            },)),

           
           
            Container( 
             padding: EdgeInsets.only(top: 30),
            width: 150,
            height: 80,
          child:FlatButton(
            textColor: Colors.white,
            color: Colors.teal,
            child: Text('운동 불러오기'),
            onPressed: (){
             setState(() { ////////////////////////////////////////////////////.//////////////////////////////////
             _fetchPost(temp);
            // savedList.add(temp);
            
          
             });
           

            },)),

            DirectSelect(
           itemExtent: 55.0,
             selectedIndex: selectedIndex1,
             child: MySelectionItem(
              isForList: false,
              title: widget.popup[selectedIndex1],
             ),
               onSelectedItemChanged: (index) {
               setState(() {
                 selectedIndex1 = index;
                 temp = widget.popup[index];
               });
             },
              items: _buildItems1()),


           for (var i = 0; i < k; i++) //  k = savedList.length; 
              Stack(
            children: <Widget>[
         // new  WorkoutLoad(workout_name1: savedList[i]), 
         new WorkoutLoad(workout_list : workout_list[savedList[i]]),
          Positioned(
          top: 120,
          right: 50,
          child:
          GestureDetector( /////////////////////// 취소
          onTap: (){
         setState(() {         
             savedList.remove(savedList[i]); 
             cancle_ = true;
             k=0;
       
          });         
          },
          child:Text('Cancel',
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
           // WorkoutLoadState workoutLoad = new WorkoutLoadState();
           // print(workoutLoad.posts1.toString());
            modifier(context, workout_list[savedList[i]]);
      
          },
          child:Text('Modify',
          style: TextStyle(   
          fontFamily: 'Langar',
          fontSize: 20.0,
          color: Colors.blue,
          fontWeight: FontWeight.bold),),)),
          
       
            ]) 
        ]
        
        ))
        
        
  ); }

// SelectionScreen을 띄우고 navigator.pop으로부터 결과를 기다리는 메서드
  workout_new(BuildContext context) async {
    // Navigator.push는 Future를 반환합니다. Future는 선택 창에서 
    // Navigator.pop이 호출된 이후 완료될 것입니다.
    final inputs = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Workout_maker()),
    );

    if (inputs != null) {
    setState(() {
      newtemp =true;
      workout_name1 = inputs;
    });}
  }

  modifier(BuildContext context, List<List<dynamic>> _posts) async {
  final inputs = await Navigator.push(
  context,
   MaterialPageRoute(builder: (context) =>Workout_maker(modifier_list:_posts)),
  );
  if (inputs != null) {
  setState(() {
    _fetchPost(inputs);
    work_modi = true;
   //  k=0; 
    
  });}
          
 
 }
}