import 'package:flutter/material.dart';
import 'package:health_app/user/homepage.dart';
import 'MyTabs.dart';

void main() {
  // runApp 실시시 이전화면으로 안돌아감 
 
  runApp(MaterialApp(home:Homepage()));
  //return  runApp(MyHealthApp());  
 }
   
class MyHealthApp extends StatelessWidget {

      Widget build(BuildContext context) {
        return MaterialApp(
          theme: ThemeData(
          primaryColor: Colors.teal[900],
          scaffoldBackgroundColor:Colors.teal,
          ),
        home:MyTabs()
        
        );
      }
}
