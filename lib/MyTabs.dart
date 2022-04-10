import 'package:flutter/material.dart';
import 'package:health_app/bmi/screens/input_page.dart';
import 'package:health_app/user/homepage.dart';
import 'package:health_app/user/userRegister.dart';
import 'package:health_app/workout/workout.dart';
import 'routine/routine.dart';
import 'routine/RoutineLoad.dart';
import 'record/LoadingRecord.dart';


class MyTabs extends StatefulWidget{
 
  
   static const Tag = "Tabbar";
  
  List<RPost> routineList;
  MyTabs({Key key,this.routineList}) : super(key: key);

    
  MyTabsState createState() => MyTabsState();
}




class MyTabsState extends State<MyTabs> 
{ 
  


int  _selectedIndex = 0; //Widget currentScreen;
PageController pageController = PageController();

void _onItemTapped(int index) { pageController.jumpToPage(index); }
 void _onPageChanged(int index) { setState(() =>  _selectedIndex = index); }
  
 


   Widget build(BuildContext context){
     
    
    final List<Widget> _widgets = <Widget>[
    Workout(routineList:widget.routineList), 
    Routine(),
    LoadingRecord(),
    InputPage(),
    ];

     return Scaffold(
       appBar: AppBar(title: Text('헬스 App'),),
     bottomNavigationBar: BottomNavigationBar(
      fixedColor: Colors.blueAccent,
       iconSize: 30,
       type: BottomNavigationBarType.fixed, 
        
 
     items:<BottomNavigationBarItem>[
     BottomNavigationBarItem(
       icon:new Icon(Icons.sports_baseball),
       title: new Text("운동"
       , style: TextStyle(   
          fontSize: 15.0,
          fontWeight: FontWeight.bold),
       )
       
     ),
       BottomNavigationBarItem(
       icon:new Icon(Icons.sports_rounded),
       title: new Text("루틴" 
        , style: TextStyle(   
          fontSize: 15.0,
          fontWeight: FontWeight.bold),)
     ),
       BottomNavigationBarItem(
       icon:new Icon(Icons.book),
       title: new Text("기록&예약" 
       , style: TextStyle(   
         fontSize: 15.0,
         fontWeight: FontWeight.bold),)
     ),

     BottomNavigationBarItem(
       icon:new Icon(Icons.calculate),
       title: new Text("BMI" 
       , style: TextStyle(   
         fontSize: 15.0,
         fontWeight: FontWeight.bold),)
     )

    ,],
    currentIndex: _selectedIndex, 
    onTap: _onItemTapped, 
    backgroundColor: Colors.amber[100],
     ),
     body: PageView(
    controller: pageController,
     onPageChanged: _onPageChanged, 
     children: _widgets,
      physics: NeverScrollableScrollPhysics(),
     ),
     );
    
   }

 //  void onTabTapped(int index) { setState(() { _currentIndex = index; }); }

}



