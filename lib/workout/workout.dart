import 'package:flutter/material.dart';
import 'package:health_app/Data_out.dart';
import 'package:health_app/record/showRecord.dart';
import 'package:provider/provider.dart';
import 'aboutTime.dart';
import 'package:health_app/routine/RoutineLoad.dart';
import 'dart:math' as math;
import 'package:health_app/record/CustomAletDialog.dart';
import 'package:intl/intl.dart';
import 'package:audioplayers/audio_cache.dart';

enum SelectedTimer { //enum 변수 생성
  notstart,start,endstart
  
}

class Workout extends StatelessWidget 
{ 
List<RPost> routineList;
bool start;
  Workout({Key key,this.routineList,this.start}) : super(key: key);
  
  Widget build(BuildContext context){
  return ChangeNotifierProvider<AboutTime>(
   create: (BuildContext context) => AboutTime(),
   child: MaterialApp(
     
   home: StopWatch(routineList:routineList),
      theme: ThemeData(
      
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
       accentColor: Colors.red,
      ),
   ),
  );
  }
}

class StopWatch extends StatelessWidget{
  List<RPost> routineList;
  StopWatch({Key key,this.routineList}) : super(key: key);
  
      Widget build(BuildContext context){
       AboutTime timer = Provider.of<AboutTime>(context);
       return Scaffold(
       
       body: WorkoutPage(routineList:routineList)
       );}}

class WorkoutPage extends StatefulWidget {
 List<RPost> routineList;
 
  WorkoutPage({Key key,this.routineList}) : super(key: key);
    _WorkoutPageState createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> with TickerProviderStateMixin ,AutomaticKeepAliveClientMixin
  {
    @override bool get wantKeepAlive => true;


  SelectedTimer selectedTimer ;
   AnimationController controller;
   

  ///////////타이머
  String get timerString { 
    Duration duration = controller.duration * controller.value;
   return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}'; }

    void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
     // duration: Duration(seconds: 5),
    );
  

  }
     @override
   void countdown(int seconds,int minutes) {         /////////////매소드 사용
   controller = AnimationController(
   vsync: this,
   duration: Duration(seconds: seconds,minutes: minutes),);
   controller.reverse( ////에니메이션 실행
      from: controller.value == 0.0         //value = 1부터 0까지
       ? 1.0
     : controller.value);
     if(selectedTimer == SelectedTimer.notstart )
     {  setState(() {
      selectedTimer = SelectedTimer.notstart; 
       });}
     }

      void time_rule(){
    if(cd_seconds >= 60)
    {  cd_minutes = cd_minutes+1;
       cd_seconds = cd_seconds-60;
    }
 }
  /////////타이머       
  

  /////////////////popup 창/////////////////////
  void showAlertDialog(BuildContext context, int _i,) {
    
  var inputs;
  var inputs2;
  TextEditingController _emailController = new TextEditingController();
   TextEditingController _emailController2 = new TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final field1 = TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
         hintText: widget.routineList[_i].weight.toString(),
          labelText: '무계(Kg)',
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          hintStyle: TextStyle(
            color: Colors.black,
          ),
        ),
         onChanged: (String weight){
        setState(() => inputs = weight,         
        );
              },
      );
         final field2 = TextFormField(
        controller: _emailController2,
        keyboardType: TextInputType.number,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: widget.routineList[_i].count.toString(),
          labelText: '개수',
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          hintStyle: TextStyle(
            color: Colors.black,
          ),
        ),
           onChanged: (String count){
        setState(() => inputs2 = count);
              },
      );

      return CustomAlertDialog(
        content: Container(
          width: MediaQuery.of(context).size.width / 1.3,
          height: MediaQuery.of(context).size.height / 3.5,
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            color: const Color(0xFFFFFF),
            borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              field1,field2,
              MaterialButton(
                onPressed: () async {
                  setState(() {
                    int weight = int.parse(inputs);
                     int count = int.parse(inputs2);
                 widget.routineList[_i].weight = weight;
                 widget.routineList[_i].count = count;
                  });
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/12,
                  padding: EdgeInsets.all(15.0),
                  child: Material(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '확인',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontFamily: 'helvetica_neue_light',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
  /////////////////popup 창/////////////////////

  var i =0; 
  var j =0; //박스의 갯수에 해당 클릭시 1씩 증가
  var k =0; // 운동이름의 분기점에 해당하는 분기값 이지만 
            // list.length까지 자동으로 올라감
  var m=0; // 박스 색깔 비교용 
  var a=0; // 운동이름의 분기점에 해당하는 분기값
  var q =0; //저장용
  var n =0;
  int totalRestTime = 0;
  String resultTime;
  int cd_seconds =0;
  int cd_minutes =0;
  bool endstart =false;
  List<int> complete = List<int>(100);
  List<String> successORfail= List<String>();


Widget build(BuildContext context){
  
AboutTime timer = Provider.of<AboutTime>(context);

if(endstart == true) /////////cjswoek sksms //종료시 시작!
{       
     setState(() {
      i++; m++; 
      if (widget.routineList[i].workout_name != widget.routineList[i-1].workout_name) {
       m=0; j=0; }});
       endstart = false;
       timer.countStop();
}
 if(widget.routineList !=null && n==0 )
 {for (var i = 0; i < widget.routineList.length; i++) {
     
     successORfail.add('미실시'); 
   }
   n=1;
   }


return Padding(
  
  padding: const EdgeInsets.only(top:20),
 

       child:
  Column(
     crossAxisAlignment: CrossAxisAlignment.start,
    
    children: <Widget> [
     //스톱워치///
     Container(
     child: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
    
    children: <Widget> [
       
     Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
      SizedBox(
        width: 120,
        child: Text(
          '${timer.minutes ~/ 60}.',
           style: TextStyle(fontSize: 60),
           textAlign: TextAlign.center,
        ),
      ),   
      SizedBox(
        width: 100,
        child: Text(
          '${timer.minutes % 60}.',
           style: TextStyle(fontSize: 60),
        ),
      ),  
      SizedBox(
        width: 90,
        child: Text(
          '${timer.seconds ~/ 100}.',
           style: TextStyle(fontSize: 60),
        ),
      ),
      SizedBox(
        width: 90,
        child: Text(
          '${timer.seconds % 100}'.padRight(2,'0'),
           style: TextStyle(fontSize: 30),     
        ),
      ),
      ],
     ),
    Padding(padding: const EdgeInsets.only(top:15),), 

    
       Row(         
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,//간격
      children: <Widget>[       
       Expanded(child: GestureDetector(
       onTap: (){
         if (!timer.isRunning){
           timer.startTimer();}
        else{timer.pauseTimer();}
       
       },
       child:Container( 
        alignment: Alignment.center,
        child: Text(
          timer.isRunning ? '일시정지' : '운동시작',
            style: TextStyle(   
            fontFamily: 'Langar',
              fontSize: 15.0,
              color: Colors.blue,
              fontWeight: FontWeight.bold),
          ),
       ),),
       ),
       Expanded(child: GestureDetector(
       onTap: (){
         
       timer.resetTimer();
       },
       child: Icon(
          Icons.autorenew_rounded,size: 25,
       ),
       ),),
      
      
      
//////////////////////////////////////운동 종료(저장) 버튼
      Expanded(child: GestureDetector(
       onTap: (){
      
       timer.recordtime();
       resultTime = timer.laptime[0];
      
        for(q =0; q<widget.routineList.length; q++)
         { Resultrecord resultrecord=
           new Resultrecord(routine_name: widget.routineList[q].routine_name, area: widget.routineList[q].area, workout_name: widget.routineList[q].workout_name,
         set_count:widget.routineList[q].set_count ,weight: widget.routineList[q].weight ,count:widget.routineList[q].count , resultTime: resultTime,totalRestTime:totalRestTime
          ,state:successORfail[q]
         );
         resultrecord.resultpost();
         }
         
          Future.delayed(const Duration(milliseconds: 10), () { 
          final _selectedDay = DateFormat('yyyy,MM,dd').format(new DateTime.now()); 
          Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => ShowRecord(today:_selectedDay)
          // Result(routineList:widget.routineList, resultTime:resultTime, totalRestTime:totalRestTime.toString(),state:successORfail) // new 중요!
                  ),
              );  });
      
    },
       child:Container( 
        alignment: Alignment.center,
        child: Text(                             
          '운동종료' ,
            style: TextStyle(   
            fontFamily: 'Langar',
              fontSize: 15.0,
              color: Colors.blue,
              fontWeight: FontWeight.bold),
          ),
       ),
       ),),
    /*Container(child: ListView(children: timer.laptimes.map((e) => ListTile(title: Text(e))).toList()),
    height: 100, width: 100,),*/
       ],),
    Padding(padding: const EdgeInsets.only(top:30),),


   ])),

 

    
      //////////////////////////////////////////타이머//////////////////////////////////////////////////////////////
     
    Expanded(
      child: Container(
        child: SingleChildScrollView(
          child:Column(
     crossAxisAlignment: CrossAxisAlignment.start,
    
    children: <Widget> [
    
    AnimatedBuilder(
          animation: controller,
          
          builder: (context, child) {
             if(controller.value ==0.0 && selectedTimer == SelectedTimer.start)
             { 
                final player = AudioCache();
               player.play('alram.mp3');
             }
                 if(controller.value ==0.0 && selectedTimer == SelectedTimer.endstart)
             { endstart = true; 
                
             }
              if(controller.value == 0.0 )
            { selectedTimer = SelectedTimer.notstart; ///제일 중요함
            
             }  

        
            return 
             selectedTimer!=SelectedTimer.notstart?
          Stack(
            
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child:
                  Container(
                    color: Colors.white, ///배경색
                    height: 500
                  ),
                ),
                
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                    
                        Align(
                          alignment: FractionalOffset.center,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: CustomPaint(
                                      painter: CustomTimerPainter(
                                        animation: controller,
                                        backgroundColor: Colors.blue,
                                        color:  Colors.amber
                                      )),
                                ),
                                Align(
                                  alignment: FractionalOffset.center,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Count Down Timer",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.black),),
                                      Text(
                                        timerString, ///// 시간 나오는곳
                                        style: TextStyle(
                                            fontSize: 112.0,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  
                     AnimatedBuilder(
                          animation: controller,
                          builder: (context, child) {
                            return FloatingActionButton.extended(
                                onPressed: () {
                                  if (controller.isAnimating)
                                    controller.stop();
                                  else {
                                    controller.reverse(
                                        from: controller.value == 0.0
                                            ? 1.0
                                            : controller.value);
                                  }
                                },
                                icon: Icon(controller.isAnimating
                                    ? Icons.pause
                                    : Icons.play_arrow),
                                label: Text(
                                    controller.isAnimating ? "Pause" : "Play"));
                          }),
                          
                    ],
                  ),
                )

                
              ],
            )
       
       :Container(     
   //Container 안에는 child column -children 그리고 row 삽입!
     margin : EdgeInsets.all(15.0),
     decoration: BoxDecoration(
       color: Colors.lightBlue,
       borderRadius: BorderRadius.circular(10.0),),
       child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [  
      Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[        
      SizedBox(
        width: 100,
        child: Text(
           '${cd_minutes}.',
           style: TextStyle(fontSize: 60),
        ),
      ),  
      SizedBox(
        width: 90,
        child: Text(
          '${cd_seconds}.',
           style: TextStyle(fontSize: 60),
        ),
      ),
      SizedBox(
        width: 90,
        child: Text(
          '0'.padRight(2,'0'),
           style: TextStyle(fontSize: 30),     
        ),
      ),
      ],
     ),
      Row(         
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[  
       Expanded(child: GestureDetector(
       onTap: (){
      
         setState(() {
      
       countdown( cd_seconds,cd_minutes);
       selectedTimer = SelectedTimer.start; /////////////////////////////////////selectedTimer ///////////////////////////////////////    
       totalRestTime = totalRestTime + cd_seconds;
       });
       },
        child: Icon(
          timer.isRunning_2 ? Icons.pause_sharp : Icons.arrow_right,
          size: 30,
          ),
       ), ),



       Expanded(child: GestureDetector(
       onTap: (){
      timer.count();
       countdown(cd_seconds,cd_minutes);
       selectedTimer = SelectedTimer.endstart;
       },
        child: Text('종료시 다음 운동 시작'),
          ),
       ),



       Expanded(child: GestureDetector(
       onTap: (){

       setState(() {
       cd_seconds =0;
       cd_minutes =0;
        });
      
       },
       child: Icon(
          Icons.autorenew_rounded,size: 25,
       ),
       ),),

       ],),
      Row(         
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[       
       Expanded(child: GestureDetector(
       onTap: (){
         setState(() {
         cd_seconds =  cd_seconds + 5;
         
         time_rule();
        });
       },
        child: Text('5초')
       ),
       ),
       Expanded(child: GestureDetector(
       onTap: (){
         setState(() {
        cd_seconds =  cd_seconds + 15;
        time_rule();
         });
       },
        child: Text('15초')
       ),),
       Expanded(child: GestureDetector(
       onTap: (){
         setState(() { //변화 적용
        cd_seconds =  cd_seconds + 30;
        time_rule();
         });
       },
      child: Text('30초')
       ),),
      Expanded(child: GestureDetector(
       onTap: (){
         setState(() {
        cd_minutes =   cd_minutes + 1;
         });
       },
        child: Text('1분')
       ),),


       ],),
       ]),);
            
          }),

    ///////////////////////////////////////타이머//////////////////////////////////////////////////
    
    
     widget.routineList != null?
      Padding(
      padding: const EdgeInsets.only(top:25,bottom: 15),
      child: Container(
        child: 
        Column(
        crossAxisAlignment:CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        ////////////////////////////전체 운동 리스트 ///////////////////////
             Container(
             width: double.infinity,
             color: Colors.blue,
              child: Text('루틴이름:  ' + widget.routineList[0].routine_name ,   
              style: TextStyle(   
            fontFamily: 'Langar',
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.bold),)
           ),
           
            for(var k=0; k<widget.routineList.length; k++)
         
            if (k==0 || widget.routineList[k].workout_name != widget.routineList[k-1].workout_name)
            GestureDetector(
            onTap: (){
          setState(() {
           if(complete[k] != 1)
           {i = k; a =k; m=0;} 
           });},
             child:Container(
             width: double.infinity,
             color: Colors.blue,
              child: Text( complete[k] !=1 ? 
                widget.routineList[k].workout_name + "   세트수   " + widget.routineList[k].set_count.toString()   
                :widget.routineList[k].workout_name + '   완료',
              style: TextStyle(   
            fontFamily: 'Langar',
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.bold),)
           )), 

      ////////////////////////////전체 운동 리스트 ///////////////////////
      ////////////////////////////현재 운동이름////////////////////////////////
        Row(  
            mainAxisAlignment: MainAxisAlignment.center,   
            children: <Widget>[
              Text(widget.routineList[i].workout_name ,   style: TextStyle(   
            fontFamily: 'Langar',
              fontSize: 30.0,
              color: Colors.orange,
              fontWeight: FontWeight.bold),)
            ]
            ),
          Container(height: 50,),

           //////////////////////////////박스///////////////
          Center( 
          child:Wrap(
            direction: Axis.horizontal, // 정렬 방향
           alignment: WrapAlignment.center, //정렬 방식
           
             spacing: 10,  //상하 공간
            runSpacing: 10, //좌우 공간
            children: <Widget>[ 
              
         for (var j=0 ; j< widget.routineList[i].set_count; j++) 
         Container( 
          height: 40,width: 20,
         color:
         j<m?
          Colors.orange
          :Colors.blue
          ),
         ]),  ),
        //////////////////////////////박스 //////////////////////  
       
         Container(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('개수   ' + widget.routineList[i].count.toString(),   style: TextStyle(   //widget.routineList[i].count
            fontFamily: 'Langar',
              fontSize: 30.0,
              color: Colors.orange,
              fontWeight: FontWeight.bold),)
            ]
            ),
            Container(height: 25,),
             Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text( widget.routineList[i].weight == 9999?
                ''
                :'무계   '+widget.routineList[i].weight.toString() + 'KG',   
              style: TextStyle(   //widget.routineList[i].weight
            fontFamily: 'Langar',
              fontSize: 30.0,
              color: Colors.orange,
              fontWeight: FontWeight.bold),)
            ]
            ), 
            Container(height: 20,),
            /////////////////////////////버튼들!!!!!!!!///////////////
            complete[a] !=1 ? //세트를 구분하는 분기값 리스트를 1로 채울시
             Row(
                mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
             FloatingActionButton.extended(
               heroTag: "btn1",
             onPressed: () {
              setState(() {
                 showAlertDialog(context,i);
              /////////실패   
                if (i==widget.routineList.length-1) {
                complete[a] = 1;   successORfail[i] = '실패';       ///////////완료시 list(a)(k와 같음)을 1로 설정 
                m++;    }
                else if (widget.routineList[i].workout_name == widget.routineList[i+1].workout_name) {
                successORfail[i] = '실패'; i++; m++;
                }
                else{m++;   complete[a] = 1;successORfail[i] = '실패'; }
  
         });},
              backgroundColor:Colors.red,
             icon: Icon(Icons.next_plan,size: 40,),
              label: Text( "실패")
             ),
              Container(width: 10,),

              FloatingActionButton.extended(
                heroTag: "btn2",
             onPressed: () {
               setState(() {
                
              /////////성공  
              ///
                if (i==widget.routineList.length-1) {
                successORfail[i] = '성공'; m++; complete[a] = 1;
                }
                else if (widget.routineList[i].workout_name == widget.routineList[i+1].workout_name) {
                successORfail[i] = '성공'; i++; m++; 
                }
                else{successORfail[i] = '성공';m++;  complete[a] = 1;}
   
              });},
               backgroundColor:Colors.blue,
               icon: Icon(Icons.next_plan,size: 40,),
              label: Text( "성공")
             ),
             Container(width: 10,),

            FloatingActionButton.extended(
              heroTag: "btn3",
             onPressed: () {
              setState(() {
                
                 showAlertDialog(context,i);
              /////////초과 성공   
                if (i==widget.routineList.length-1) {
                 complete[a] = 1;successORfail[i] = '초과달성';
                m++;
                
                }
                else if (widget.routineList[i].workout_name == widget.routineList[i+1].workout_name) {
                 successORfail[i] = '초과달성'; i++; m++;  
                }
                else{m++;
                 complete[a] = 1;successORfail[i] = '초과달성';
                }

              });},
               backgroundColor:Colors.purple,
               icon: Icon(Icons.next_plan,size: 30,),
              label: Text( "초과 달성"),
             )],)
             
             
             ])
             :Row(), 
              
              
          /////////////////////버튼끝///////////

            Container(height: 30,),
     


            ]) ))
      :Row()
       
    ])))),],),   
  );
  
  

}       
}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
 
       
       
  }



  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
       backgroundColor != old.backgroundColor;
  }
}



