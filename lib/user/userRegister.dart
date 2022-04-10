import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:health_app/bmi/components/icon_content.dart';
import 'package:health_app/bmi/components/reuseable_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_app/Data_out.dart';
import 'package:health_app/bmi/constants.dart';
import 'package:health_app/bmi/components/round_icon_button.dart';
import 'package:fluttertoast/fluttertoast.dart';


const bottomContainerHeight = 80.0;
const activeCardColor = Colors.teal;
const bottomContainerColor = Color(0xFFEB1555);
const inActiveCardColor = Colors.amber;

enum Gender { //enum 변수 생성
  male,
  female,
}

class Post_register {  //리턴 값을 받을 모델 클래스
  String success;
  Post_register(this.success);

  factory Post_register.fromJson(dynamic json) { 
    //Map <String, dynamic>  을 Post 객체로 변환하는 방법
    return Post_register(
     json['success'] as String,
    );
  } 

}

class UserRegister extends StatefulWidget{
_UserRegisterState createState() => _UserRegisterState();

}

class _UserRegisterState extends State<UserRegister>{
Gender selectedGender;
int height = 180;
int weight = 80;
int age = 30;
String user_id;
String user_pass;
String user_name;
String user_gender; 
Future<Post_register> post1;      


Widget build(BuildContext context){

Future<Post_register> register() async {
   
  final response =
       await http.post('http://dlwoduq789.dothome.co.kr/health/UserRegister.php',
          headers: <String, String> {
         'Content-Type': 'application/x-www-form-urlencoded',},
           body: <String, String> {
         'userID': user_id,
           'userPassword': user_pass,
           'userName': user_name,
           'userGender': user_gender,
           'userAge': '$age',
           'userWeight': '$weight',
            'userHeight': '$height',
        },
    );
       if (response.statusCode == 200) {
  final Post_register post_register = Post_register.fromJson(jsonDecode(response.body));
        setState(() {
      print(post_register);    
      if(post_register.success == "true")
      {  Fluttertoast.showToast(
        msg:  "가입 성공",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM // also possible "TOP" and "CENTER"
        );
      Navigator.of(context).pop();
   
       }
       else if(post_register.success == "overlap")
      {  Fluttertoast.showToast(
        msg:  "아이디 중복",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM // also possible "TOP" and "CENTER"
        );
   
   
       }
      else{
          Fluttertoast.showToast(
        msg: "가입 실패",
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

 return Scaffold(

       backgroundColor: Colors.teal,
      body:SingleChildScrollView(
      child:Column(
     // crossAxisAlignment: CrossAxisAlignment.stretch,// 좌우로 꽉 채우기
      mainAxisAlignment: MainAxisAlignment.center, 
      children: <Widget>[
          SizedBox(height: 40.0,),
            Row(   
           
           children: <Widget>[     
             SizedBox(width: 20.0,),
            Container(
              width: 60,
              child:Text(
            '아이디'
             ,style: TextStyle(fontSize: 15,color:Colors.white),
           ),) ,
             Container(
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
        setState(() => user_id= input);
        },
            )
          ),]),
             Row( 
        
           children: <Widget>[  
             SizedBox(width: 20.0,),   
            Container(width: 60,
            child:Text(
            '비밀번호'
             ,style: TextStyle(fontSize: 15,color:Colors.white),
           ),) ,
             Container(
           margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
           color: Colors.white,
            width: 200,
 
        child:TextField(
          obscureText: true, //비밀번호 숨기기
         style: TextStyle(fontSize: 15,color:Colors.black),
         textAlign: TextAlign.center,
          decoration: InputDecoration(
          hintText: '비밀번호'
               
         ),
        onChanged: (String input1){
        setState(() => user_pass= input1);
        },
            )
          ),]),
           Row(   
           children: <Widget>[   
             SizedBox(width: 20.0,),  
            Container(width: 60,
            child:Text(
            '이름'
             ,style: TextStyle(fontSize: 15,color:Colors.white),
           ),) ,
             Container(
           margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
           color: Colors.white,
            width: 200,
 
        child:TextField(
         style: TextStyle(fontSize: 15,color:Colors.black),
         textAlign: TextAlign.center,
          decoration: InputDecoration(
          hintText: '이름'
                
         ),
       onChanged: (String input2){
        setState(() => user_name= input2);
        },
            )
          ),]),
             

        // 2개의 row 포함
         Row(
           mainAxisAlignment: MainAxisAlignment.center, 
           children: <Widget>[
           GestureDetector(
             onTap: (){
             setState(() {
               selectedGender = Gender.male;
               user_gender = 'male';
             }); },
             child: ReusableCard(
              color: selectedGender == Gender.male
               ? activeCardColor
                : inActiveCardColor, //3항 연산자
             cardChild: IconContent(icon: FontAwesomeIcons.mars,
             label: 'MALE', 
             
             )),),
           GestureDetector(
             onTap: (){
               setState(() {
               selectedGender = Gender.female;
                 user_gender = 'female';
             }); },
             child: ReusableCard(
            color: selectedGender == Gender.female
             ? activeCardColor
             : inActiveCardColor,
             cardChild: IconContent(icon: FontAwesomeIcons.venus,
             label: 'FEMALE',)),), 
           ], ), 
       ReusableCard( //슬라이더
        color: activeCardColor,
        cardChild: Column(
     mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[         
          Text(
          'Height',
          style: labelTextStyle_2,),
          Row(
        mainAxisAlignment: MainAxisAlignment.center,
        
          textBaseline: TextBaseline.alphabetic,
           children: <Widget>[
           Text(
             height.toString(),
            
         ),
           Text(
          'cm',
          style: labelTextStyle_2,), 
          SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      inactiveTrackColor: Color(0xFF8D8E98),
                      thumbColor: Color(0xFFEB1555),
                      activeTrackColor: Colors.white,
                      overlayColor: Color(0x29EB1555),
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 15.0),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 30.0),
                    ),
           child:Slider(
          value:height.toDouble(), //기본값
           min: 120.0,
           max: 220.0,
            onChanged: (double newValue){
            setState(() {
            height = newValue.round(); //round = 반올림
            });}),),
            
        RoundIconButton(
          icon: FontAwesomeIcons.minus,
          onPressed: () {
            setState(() {
              height--;
            });
          },
        ),
        SizedBox(
          width: 10.0,
        ),
        RoundIconButton(
          icon: FontAwesomeIcons.plus,
          onPressed: () {
            setState(() {
              height++;
            });
          },
        ),
      ], ),],),
      ),
      //
     //
           ReusableCard( //슬라이더
        color: activeCardColor,
        cardChild: Column(
     mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[         
          Text(
          'Weight',
          style: labelTextStyle_2,),
          Row(
        mainAxisAlignment: MainAxisAlignment.center,
        
          textBaseline: TextBaseline.alphabetic,
           children: <Widget>[
           Text(
             weight.toString(),
            
         ),
           Text(
          'KG',
          style: labelTextStyle_2,), 
          SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      inactiveTrackColor: Color(0xFF8D8E98),
                      thumbColor: Color(0xFFEB1555),
                      activeTrackColor: Colors.white,
                      overlayColor: Color(0x29EB1555),
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 15.0),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 30.0),
                    ),
           child:Slider(
          value:weight.toDouble(), //기본값
           min: 30.0,
           max: 200.0,
            onChanged: (double newValue){
            setState(() {
            weight = newValue.round(); //round = 반올림
            });}),),
               
      
      
        RoundIconButton(
          icon: FontAwesomeIcons.minus,
          onPressed: () {
            setState(() {
              weight--;
            });
          },
        ),
        SizedBox(
          width: 10.0,
        ),
        RoundIconButton(
          icon: FontAwesomeIcons.plus,
          onPressed: () {
            setState(() {
              weight++;
            });
          },
        ),
      ]
    
       ),],),
      ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: <Widget>[
         
           ReusableCard(
             color: activeCardColor,            
           cardChild: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    Text(
      'AGE',
      style: labelTextStyle_2,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Text(
          age.toString(),
          
        ),
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RoundIconButton(
          icon: FontAwesomeIcons.minus,
          onPressed: () {
            setState(() {
              age--;
            });
          },
        ),
        SizedBox(
          width: 10.0,
        ),
        RoundIconButton(
          icon: FontAwesomeIcons.plus,
          onPressed: () {
            setState(() {
              age++;
            });
          },
        ),
      ],
    )
  ],
),
 ),
           ],
        ),
        Container( 
            padding: EdgeInsets.only(top: 20),
            width: double.infinity,
            height: 90,
          child:FlatButton(
            textColor: Colors.white,
            color: Colors.blue[900],
            child: Text('회원 가입'),
            onPressed: (){
            post1=register();
          },              
            )),
  ],),

    
  ) );
} 
}