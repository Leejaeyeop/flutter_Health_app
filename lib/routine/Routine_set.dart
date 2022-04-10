import 'package:flutter/material.dart';


class Routine_set extends StatefulWidget{
      
     _Routine_setState createState() => _Routine_setState();
}

class _Routine_setState extends State<Routine_set>{
   
  String inputs_2 ='';
  
  
  Widget build(BuildContext context){
 
           return Row( 
         children: <Widget>[
       Container(width: 100,child: Text('개수' ,style: TextStyle(fontSize: 15,color:Colors.black),),), 
         Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
             width: 200,
            child:TextField(
              style: TextStyle(fontSize: 16,color:Colors.black),
              textAlign: TextAlign.center,
              decoration: InputDecoration(hintText: '개수'),
              onChanged: (String quantity){
                setState(() => inputs_2 = quantity);
              },
            ),
          ),
         ]
      );
      
     
      //selectedQW==SelectedQW.both ? Routine_quantity() : Row()
      
 
  }
}