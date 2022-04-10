
import 'package:flutter/material.dart';
import 'package:health_app/bmi/constants.dart';
 
class BottomButton extends StatelessWidget {
  BottomButton({@required this.onTap, @required this.buttonTitle});
 
  final Function onTap;
  final String buttonTitle;
 
  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Text(
            buttonTitle,
            style: kLargeButtonTextStyle,
          ),
        ),
        color: bottomContainerColor,
        padding: EdgeInsets.only(bottom: 20.0),
        margin: EdgeInsets.all(10.0),
        width: double.infinity,
        height: bottomContainerHeight,
      ),
    );
  }
}