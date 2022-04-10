import 'package:flutter/material.dart';
import 'package:direct_select/direct_select.dart';
import 'package:health_app/routine/myselect.dart';
import 'package:health_app/Data_out.dart';


const activeCardColor = Colors.blue;
const inActiveCardColor = Colors.white;

enum SelectedQW { //enum 변수 생성
  only,
  both
}

enum SelectedSET{
  each, unity //전세트 동일 or 각각
}



class Workout_maker extends StatefulWidget{
List<List<dynamic>> modifier_list;       ///workout_name, set_count, weight, count
 Workout_maker({Key key,this.modifier_list,}) : super(key: key);  
     _Workout_makerState createState() => _Workout_makerState();
}

class _Workout_makerState extends State<Workout_maker>{
  
  SelectedQW selectedQW;
  SelectedSET selectedSET;
 
  int selectedIndex1 = 0;


String inputs=''; //운동이름
int set_num = 5;
int layout_num = 1;
int weight =5;
int k =1;
bool newtemp = true; //저장시 바로 show
List<int> weights = List<int>(20);
List<String> quantities = List<String>(20);


Widget build(BuildContext context){

  if (widget.modifier_list !=null && k==1) {
    //0 = workout_name
    //1 = set_count
    //2 =weight
    //3 = count 
    /////////////////////////////////////////////////////////////modifier_list;       ///workout_name, set_count, weight, count
    for (var i = widget.modifier_list[0][1]; i < 20; i++) // set_count
    {weights[i] = 5;}
    if(widget.modifier_list[0][2]==9999)
    { selectedQW = SelectedQW.only;}
    else{selectedQW = SelectedQW.both;}
    selectedSET = SelectedSET.each;
    inputs = widget.modifier_list[0][0];
    set_num = widget.modifier_list[0][1];
    layout_num = set_num;
    for (var i = 0; i < widget.modifier_list[0][1]; i++) 
    {
    weights[i] = widget.modifier_list[i][2];
    quantities[i] = widget.modifier_list[i][3].toString();
    }
   k=2;
  }

 if (k==1)   ////////첫 스타트
 { 
   k =2;
 for (var i = 0; i < 20; i++) 
 {weights[i] = 5;}
 selectedQW = SelectedQW.only;
 selectedSET = SelectedSET.unity;
 };

return Scaffold(
  
       appBar: AppBar(title: Text('헬스 App'),),
       backgroundColor: Colors.white,
        body: SingleChildScrollView(
       child: Column(
       children: <Widget>[
       Row(
            children: <Widget>[
                   Row(   
           children: <Widget>[     
             SizedBox(width: 20.0,),
            Container(
              width: 60,
              child:Text(
            '운동 이름'
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
              hintText: widget.modifier_list !=null?
               widget.modifier_list[0][0]
                 :'운동 이름'   
         ),
        onChanged: (String exercise_name){
                setState(() => inputs = exercise_name);
              },
            )
          ),]),
         
              
            Container( 
             padding: EdgeInsets.only(right:10,top: 30),
            width: 80,
            height: 70,
          child:
          widget.modifier_list !=null?
             FlatButton(        ///////////////////////수정 
            textColor: Colors.white,
            color: Colors.teal,
            child: Text('수정'),
            onPressed: (){
             
              Delete delete = Delete(workout_name: widget.modifier_list[0][0]); //name
              delete.postRequest();
            
               Future.delayed(const Duration(milliseconds: 10), () {
              for (var k = 0; k < set_num; k++) {
                if (selectedQW == SelectedQW.only) {
                  weights[k] = 9999;
                }
                 if (selectedSET == SelectedSET.unity) {
                  weights[k] = weights[0];
                  quantities[k] = quantities[0];
                }
              Data_out out = Data_out(workout_name: inputs, set_count: set_num, weight: weights[k], count: quantities[k]);
              out.postRequest();
              }

             
              } );
               Future.delayed(const Duration(milliseconds: 20), () {
               Navigator.pop(context,inputs);
               } );
           },)
          :FlatButton(     //////////////////새로 만들기
            textColor: Colors.white,
            color: Colors.teal,
            child: Text('저장'),
          
            onPressed: (){
              
              
              for (var i = 0; i < set_num; i++) {
                if (selectedQW == SelectedQW.only) {
                  weights[i] = 9999;
                }
                if (selectedSET == SelectedSET.unity) {
                  weights[i] = weights[0];
                  quantities[i] = quantities[0];
                }
                
              Data_out out = Data_out(workout_name: inputs, set_count: set_num, weight: weights[i], count: quantities[i]);
              out.postRequest();
              }
               Navigator.pop(context, inputs); 
            
           },)
         
           
           
           ),
          ]
          ),
    
      Container(     
      margin : EdgeInsets.all(15.0),
       child:Column(
       mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [  
      Row(
       children: <Widget>[
         

         GestureDetector( 
         onTap: (){
          setState(() {
          selectedQW = SelectedQW.both; });},
       child: Container(
        decoration: BoxDecoration(
       color: selectedQW == SelectedQW.both
       ? activeCardColor
       : inActiveCardColor
       ,
       borderRadius: BorderRadius.circular(10.0),),
         child: Text('무계 + 개수'),
       ),),

      GestureDetector( 
         onTap: (){
          setState(() {
          selectedQW = SelectedQW.only;
          
           }); },
        child:Container(
         margin : EdgeInsets.only(left: 20),
         decoration: BoxDecoration(
       color: selectedQW == SelectedQW.only
       ? activeCardColor
       : inActiveCardColor
       ,
       borderRadius: BorderRadius.circular(10.0),),
         child: Text('개수만'),
       ),
      ),
      ]
      ),
      
       Row(  
       children: <Widget>[
         GestureDetector( 
         onTap: (){
          setState(() {
          layout_num = 1;
          selectedSET = SelectedSET.unity;
           }); },
       child:Container(
         margin : EdgeInsets.only(top:15.0),
        decoration: BoxDecoration(
        color: selectedSET == SelectedSET.unity
       ? activeCardColor
       : inActiveCardColor
       ,
       borderRadius: BorderRadius.circular(10.0),),
         child: Text('전세트 동일'),
       ),),

       GestureDetector( 
         onTap: (){
          setState(() {
          layout_num = set_num; 
          selectedSET = SelectedSET.each;}); },
       child: Container(
         margin : EdgeInsets.only(top:15.0,left: 20),
         decoration: BoxDecoration(
       color: selectedSET == SelectedSET.each
       ? activeCardColor
       : inActiveCardColor
       ,
       borderRadius: BorderRadius.circular(10.0),),
         child: Text('세트 각각'),
       ),),

      ]
      ),
            Row(
         children: <Widget>[
       Container(width: 100,child: Text('세트 수' ,style: TextStyle(fontSize: 15,color:Colors.black),),), 
          
         ] 
      ),
      //슬라이더
      GestureDetector(
        child: Container(
        child: Column(
     mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[         
          Row(
        mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
           children: <Widget>[
           Text(
             set_num.toString(),
         ),
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
          value:set_num.toDouble(), //기본값
           min: 1.0,
           max: 20.0,
            activeColor: Color(0xFFEB1555),
            inactiveColor: Color(0xFF8D8E98),
            onChanged: (double newValue){
            setState(() {
            set_num = newValue.round(); 
            if ( selectedSET == SelectedSET.each) { //실시간 상호작용
              layout_num = set_num;
            }
             //round = 반올림
            });}),)
      ], ),],),
      ),),
      //
      
        for (var i = 0; i < layout_num; i++) 
        Column(
        children: <Widget>[
       Row( 
         children: <Widget>[
       Container(width: 100,child: Text('개수' ,style: TextStyle(fontSize: 15,color:Colors.black),),), 
         Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
             width: 200,
            child:TextField(
              style: TextStyle(fontSize: 16,color:Colors.black),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
               hintText: 
             widget.modifier_list !=null ?
                 quantities[i]
                 :'개수'
                
                ),
              keyboardType: TextInputType.number,
              onChanged: (String quantity){
                setState(() => {quantities[i]= quantity, //quantities[i] = 개수 순번 
        if(layout_num ==1 && set_num >1){ ////////////////////////////////
        for(var j =0; j< set_num; j++)  /////////////세트 통일시 
         quantities[j] = quantities[0]           
         }  }
                );
              },
            ),
          ),
         ]
      ),
       selectedQW==SelectedQW.both ? 
       Column(children: <Widget>[ 
         Row(
         children: <Widget>[          
        Container(width: 100,child: Text('무계' ,style: TextStyle(fontSize: 15,color:Colors.black),),), 
              SizedBox(
        width: 100,
        child: Text(
          weights[i].toString(),/////////중요!
           style: TextStyle(fontSize: 30),
        ),
      ),
        FlatButton(
            textColor: Colors.white,
            color: Colors.orange,
            child: Text('+1KG'),
            onPressed: (){
         setState(() {
         weights[i] = weights[i] +1;
         if(layout_num ==1 && set_num >1){ ////////////////////////////////
           for(var j =0; j< set_num; j++) /////////////////////////////
         weights[j] = weights[0];             ////////////////////
         }  
        });
       },),
         FlatButton(
            textColor: Colors.white,
            color: Colors.blue,
            child: Text('+5KG'),
            onPressed: (){
         setState(() {
        weights[i] = weights[i] +5;
        if(layout_num ==1 && set_num >1){ ////////////////////////////////
        for(var j =0; j< set_num; j++) /////////////////////////////
         weights[j] = weights[0];             ////////////////////
         }  
        }  
        );},),  
         ]
         ),
         Row( children: <Widget>[    
           SizedBox(width: 200,),
         FlatButton(
            textColor: Colors.white,
            color: Colors.orange,
            child: Text('-1KG'),
            onPressed: (){
         setState(() {
         weights[i] = weights[i] -1;
          if(weights[i] <0){
           weights[i] = 0;
         }
         if(layout_num ==1 && set_num >1){ ////////////////////////////////
           for(var j =0; j< set_num; j++) /////////////////////////////
         weights[j] = weights[0];             ////////////////////
         }  
        });
       },),
       FlatButton(
            textColor: Colors.white,
            color: Colors.blue,
            child: Text('-5KG'),
            onPressed: (){
         setState(() {
         weights[i] = weights[i] -5;
         if(weights[i] <0){
           weights[i] = 0;
         }
         if(layout_num ==1 && set_num >1){ ////////////////////////////////
           for(var j =0; j< set_num; j++) /////////////////////////////
         weights[j] = weights[0];             ////////////////////
         }  
        });
       },),
          ] )
         ]) 
      : Row()]),
      ]
      )
      ),

 

       ]
       
        ),
        ),
        );

}
}

