import 'package:flutter/material.dart';
import 'routine.dart';
import 'RoutineLoad.dart';




class RoutineCard extends StatefulWidget {
List<RoutinePost> posts;  /////////////////본 posts는 간략화된 버전! 운동이름과 세트의 중복이 없다. 
String routine_name;
String area;


var i;

    RoutineCard({Key key,@required this.i,@required this.routine_name,@required this.area,@required this.posts}) : super(key: key);
   
  @override
  _RoutineCardState createState() => _RoutineCardState();
}

class _RoutineCardState extends State<RoutineCard>{
List<String> modifierNames = List<String>();



Widget build(BuildContext context){ 
            
                
////////////////////////////////////////////////////////////////////////레이아웃//////////////////////////////////////////////////////////////////////////
                   return Padding(
          padding: const EdgeInsets.only(top:25,bottom: 15),
         
            
           /////////////////////////////////////////////////////card/////////////////////////////////////////////////////////
           child:  Container(
          child: Container(

         margin: EdgeInsets.fromLTRB(
           30.0 , 42.0, 16.0, 16.0),
         //constraints: BoxConstraints.expand(),
        child: 
        Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
         children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Container(height: 4.0,),
           GestureDetector(
            onTap: () {
              setState(() {
              Navigator.push(
              context,
             MaterialPageRoute(
              builder: (context) => new RoutineLoad(routine_name1:widget.routine_name), // new 중요!
                ),
             );  
                 /////
                 });},
          child:Text('루틴 시작', //////////////////////// 루틴 시작
          style: TextStyle(   
          fontFamily: 'Langar',
          fontSize: 15.0,
          color: Colors.amber,
          fontWeight: FontWeight.bold),
          ),),

         Container(width: 15.0),
          Text(widget.routine_name, //////////////////////// 루틴 이름
          style: TextStyle(   
            fontFamily: 'Langar',
              fontSize: 30.0,
              color: Colors.white,
              fontWeight: FontWeight.bold),),
          Container(width: 30.0),
          Text('운동 부위'+widget.area, //////////////////////////운동 부위
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
           Row( children: <Widget>[
      
           ]),
          //////////////////// 운동이름 +세트 수 관리
        for(var j =widget.i; j< this.widget.posts.length; j++ ) 
         widget.posts[j].routine_name ==  widget.posts[widget.i].routine_name ?
          Row( children: <Widget>[
            ////////운동 이름 
            Container(width: 150,child: Text('운동이름  '+widget.posts[j].workout_name ,style: TextStyle(fontFamily: 'Langar',fontSize: 15,color:Colors.white, fontWeight: FontWeight.bold),),),
            
           SizedBox(width: 100),
           //////////세트 수
            Container(child: Text('세트 수  '+widget.posts[j].set_count,style: TextStyle(fontFamily: 'Langar',fontSize: 15,color:Colors.white, fontWeight: FontWeight.bold),),), 
            ] )
            : Row(),
         ],
      ),
    ),
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
          ),
          ///////////////////////////////////////////////////////////////////////card////////////////////////////////////////////////////
             
            
          );
          
          
             
           


}    
}


