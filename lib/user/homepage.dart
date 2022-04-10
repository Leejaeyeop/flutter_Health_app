import 'package:flutter/material.dart';
import 'package:health_app/user/userRegister.dart';
import 'package:health_app/main.dart';
import 'package:health_app/MyTabs.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class Post_login {  //리턴 값을 받을 모델 클래스
  bool success;
  Post_login(this.success);

  factory Post_login.fromJson(dynamic json) { 
    //Map <String, dynamic>  을 Post 객체로 변환하는 방법
    return Post_login(
     json['success'] as bool,
    );
  } 

}


class Homepage extends StatefulWidget {
  _HomepageState createState() => _HomepageState();
 }

 class _HomepageState extends State<Homepage>{
   Future<Post_login> post1;
 bool login_ = true;

Future<Post_login> login() async {
   
  final response =
       await http.post('http://dlwoduq789.dothome.co.kr/health/login.php',
          headers: <String, String> {
         'Content-Type': 'application/x-www-form-urlencoded',},
           body: <String, String> {
           'userID': user_id,
           'userPassword': user_pass,
        },
    );
       if (response.statusCode == 200) {
  final Post_login post_login = Post_login.fromJson(jsonDecode(response.body));
        setState(() {
      print(post_login);    
      if(post_login.success == true)
      {  Fluttertoast.showToast(
        msg: "로그인 성공",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM // also possible "TOP" and "CENTER"
        );
       return  runApp(MyHealthApp());  
   
       }
      else{
          Fluttertoast.showToast(
        msg: "로그인 실패",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM // also possible "TOP" and "CENTER"
        );
      }  
       });}
       else{
    // 만약 요청이 실패하면, 에러를 던집니다.
    throw Exception('Failed to load post');
  }
}
  String user_id;
  String user_pass;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: Center(
          child:SingleChildScrollView(
          child: Column(
          children: <Widget>[
            SizedBox(height: 90.0,),
            CircleAvatar(
             radius: 70.0,
             backgroundImage: AssetImage('images/004.jpg'),
            ),
            SizedBox(height:10),
            Row(
           children: <Widget>[
             SizedBox(width: 140,),
            Container(
            width: 150,
            child:Text(
              'Fuel  Your ',
            style: TextStyle(
              fontFamily: 'Langar',
              fontSize: 30.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              ),
            ),),],),
            Row(
           mainAxisAlignment: MainAxisAlignment.center,    
           children: <Widget>[
            Container(
            child:Text(
              'Ambition!',
            style: TextStyle(
              fontFamily: 'Langar',
              fontSize: 60.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              ),
            ),),],),
            Text('Developed by Lee Jaeyeop',     
            style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            ),), 
            SizedBox(width: 10.0,),
              
           Container(   
          // padding: EdgeInsets.all(18.0),
           margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
           color: Colors.white,
             width: 200,
            child:TextField(
         style: TextStyle(fontSize: 15,color:Colors.black),
         textAlign: TextAlign.center,
          decoration: InputDecoration(
          hintText: '아이디'
                
         ),
        onChanged: (String input){
        setState(() => user_id = input.trim());
        },
            )
          ),
           Container(   
          // padding: EdgeInsets.all(18.0),
           margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
           color: Colors.white,
             width: 200,
            child:TextField(
                obscureText: true,
         style: TextStyle(fontSize: 15,color:Colors.black),
         textAlign: TextAlign.center,
          decoration: InputDecoration(
          hintText: '비밀번호'
         ),
        onChanged: (String input1){
        setState(() => user_pass= input1.trim());
        },
            )
          ),
  
        RaisedButton(
        child: Text('Login'),   
         onPressed: () { 
         post1=login();
        
        },
        ),
        RaisedButton(
        child: Text('Register'),   
         onPressed: () { 
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserRegister()),
        );},
        ),
          ],
        )
        
        ),),
      ),
    );
  }
}