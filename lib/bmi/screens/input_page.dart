import 'package:health_app/bmi/components/icon_content.dart';
import 'package:flutter/material.dart';
import '../components/reuseable_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/bottom_button.dart';
import 'package:health_app/bmi/constants.dart';
import 'package:health_app/bmi/calculate_brain.dart';
import 'result_page.dart';
import 'package:health_app/bmi/components/bottom_button.dart';
import 'package:health_app/bmi/components/round_icon_button.dart';


const bottomContainerHeight = 80.0;
const activeCardColor = Color(0xFF00695C);
const bottomContainerColor = Color(0xFFEB1555);
const inActiveCardColor = Colors.amber;


enum Gender { //enum 변수 생성
  male,
  female,
}

class InputPage extends StatefulWidget{
_InputPageState createState() => _InputPageState();

}

class _InputPageState extends State<InputPage>{
Gender selectedGender;
int height = 180;
int weight = 80;
int age = 30;
 
       


Widget build(BuildContext context){

 return Scaffold(
   
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, // 좌우로 꽉 채우기
      children: <Widget>[
        Expanded( // 2개의 row 포함
         child: Row(children: <Widget>[
           Expanded(child: GestureDetector(
             onTap: (){
             setState(() {
               selectedGender = Gender.male;
             }); },
             child: ReusableCard(
              color: selectedGender == Gender.male
               ? activeCardColor
                : inActiveCardColor, //3항 연산자
             cardChild: IconContent(icon: FontAwesomeIcons.mars,
             label: 'MALE',)),),),
           Expanded(child: GestureDetector(
             onTap: (){
               setState(() {
               selectedGender = Gender.female;
               
             }); },
             child: ReusableCard(
            color: selectedGender == Gender.female
             ? activeCardColor
             : inActiveCardColor,
             cardChild: IconContent(icon: FontAwesomeIcons.venus,
             label: 'FEMALE',)),),), 
           ], ), ),
      Expanded(child: ReusableCard( //슬라이더
        color: activeCardColor,
        cardChild: Column(
     mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[         
          Text(
          'Height',
          style: labelTextStyle,),
          Row(
        mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
           children: <Widget>[
           Text(
             height.toString(),
            
         ),
           Text(
          'cm',
          style: labelTextStyle,), 
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
            });}),)
      ], ),],),
      ),
      ), //
        Expanded( //
         child: Row(children: <Widget>[
           Expanded(child: ReusableCard(
             color: activeCardColor,            
           cardChild: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    Text(
      'WEIGHT',
      style: labelTextStyle,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Text(
          weight.toString(),
          
        ),
        Text(
          'kg',
          style: labelTextStyle,
        )
      ],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
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
      ],
    )
  ],
),
 ),),
           Expanded(child: ReusableCard(
             color: activeCardColor,            
           cardChild: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    Text(
      'AGE',
      style: labelTextStyle,
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
 ),),
           ],
        ),
        ),
          BottomButton(
            buttonTitle: '계산하기',
            onTap: () {
              CalculatorBrain calc =
                  CalculatorBrain(height: height, weight: weight);
 
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => new ResultPage(
                    bmiResult: calc.calculateBMI(),
                    resultText: calc.getResult(),
                    interpretation: calc.getInterpretation(),
                  ),
                ),
              );

             
            },
          ),
  ],),

    
 );
} 
}