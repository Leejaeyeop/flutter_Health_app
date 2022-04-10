import 'package:flutter/material.dart';

enum SelectedQW { //enum 변수 생성
  only,both
  
}

class WorkoutLoad extends StatefulWidget {
    List<List<dynamic>> workout_list;
   
  
    WorkoutLoad({Key key,this.workout_list}) : super(key: key);
   
  @override
  WorkoutLoadState createState() => WorkoutLoadState();
}

class WorkoutLoadState extends State<WorkoutLoad> {

int k = 0;
SelectedQW selectedQW;

//0 = workout_name
//1 = set_count
//2 =weight
//3 = count 





  

  @override
  Widget build(BuildContext context) {
      
          
           if(widget.workout_list[0][2] == 9999){
            selectedQW = SelectedQW.only;} /////////맨몸 운동 전용
          else{selectedQW = SelectedQW.both;} ///둘다

/////////////////////////////////////////////////////////////////////////레이아웃//////////////////////////////////////////////////////////////////////////
       final cardContent = Container(
         margin: EdgeInsets.fromLTRB(
           76.0 , 42.0, 16.0, 16.0),
         //constraints: BoxConstraints.expand(),
        child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
         children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
         
         Text(widget.workout_list[0][0],  //운동 이름
          style: TextStyle(   
            fontFamily: 'Langar',
              fontSize: 30.0,
              color: Colors.white,
              fontWeight: FontWeight.bold),),
          Container(width: 30.0),

          Text('세트수'+widget.workout_list[0][1].toString(),
          style: TextStyle(   
            fontFamily: 'Langar',
              fontSize: 15.0,
              color: Colors.white,
              fontWeight: FontWeight.bold),
          ),
          
          Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              width: 18.0,
              color: Color(0xff00c6ff)),]),
          SizedBox(height: 40), 
          Row(children: <Widget>[  
 
         
 
         ]),
           //////////////////////////////////////////////////////   
           SizedBox(height: 10),   
          for (var i = 0; i < widget.workout_list.length; i++)
          Row( children: <Widget>[

            selectedQW==SelectedQW.both ? //맨몸 운동 삼중 연산문
            Container(width: 70,child: Text('무계  '+widget.workout_list[i][2].toString() ,style: TextStyle(fontFamily: 'Langar',fontSize: 15,color:Colors.white, fontWeight: FontWeight.bold),),)
           : Container(width: 100),
            SizedBox(width: 100),
            Container(child: Text('개수  '+widget.workout_list[i][3].toString(),style: TextStyle(fontFamily: 'Langar',fontSize: 15,color:Colors.white, fontWeight: FontWeight.bold),),), 
            ] )
         ],
      ),
    );
       final card = Container(
      child: cardContent,
        margin:
          EdgeInsets.only(left: 10.0,right: 10.0), 
         decoration: BoxDecoration(
          color: Color(0xFF333366),
           shape: BoxShape.rectangle,
           borderRadius: BorderRadius.circular(8.0),
               boxShadow: <BoxShadow>[
             BoxShadow(
                   color: Colors.black12,
            blurRadius: 10.0,
             offset: Offset(0.0, 10.0),
             ),
          ],
         ),
          );
/////////////////////////////////////////////////////////////////////////레이아웃//////////////////////////////////////////////////////////////////////////
              return Padding(
          padding: const EdgeInsets.only(top:25,bottom: 15),
          child: GestureDetector(
            child: Stack(children: <Widget>[
          card,

            ],) ,
            
            
            ) 
          
          
          );
          
          
     }}



