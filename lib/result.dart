import 'package:flutter/material.dart';
import 'package:health_app/routine/RoutineLoad.dart';


class Result extends StatefulWidget {
    Result({Key key,this.resultTime,this.routineList,this.totalRestTime,this.state}) : super(key: key);
    String resultTime;
    List<RPost>routineList;
    String totalRestTime;
    List<String>state;
  @override
  _ResultState createState() => _ResultState();

  
  }
  
  class _ResultState extends State<Result> {
   Widget build(BuildContext context) {
     return  Column(
        children: <Widget>[
          Column(children: <Widget>[
            Text(widget.routineList[0].routine_name),
            Text(widget.totalRestTime),
            Text(widget.resultTime)
        /*   Row(
            children: <Widget>[
            Text(widget.routineList[0].routine_name),
            Text(widget.totalRestTime),
            Text(widget.resultTime)
            ]
            )*/
          ]
          )
        ]
     );
  


   }


  }