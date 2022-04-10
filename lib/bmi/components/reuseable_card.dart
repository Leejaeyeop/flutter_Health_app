import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
    ReusableCard({@required this.color, this.cardChild, this.onPress}); // 생성자 @required= 필수로 받아야 하는 값

    final Color color;
    final Widget cardChild;
    final Function onPress;

    Widget build(BuildContext context){
      return GestureDetector(
        onTap: onPress,
        child: Container( 
          child: cardChild, //icon이 들어갈 자리
           margin: EdgeInsets.all(10.0),
           decoration: BoxDecoration(color: color,
           borderRadius: BorderRadius.circular(10.0),
            ), ),);
    } 
}