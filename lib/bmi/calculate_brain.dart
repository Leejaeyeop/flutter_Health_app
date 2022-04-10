
import 'package:flutter/material.dart';
import 'dart:math';
 
class CalculatorBrain {
  CalculatorBrain({@required this.height, @required this.weight});
 
  final int height;
  final int weight;
 
  double _bmi;
 
  String calculateBMI() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }
 
  String getResult() {
    if (_bmi > 25) {
      return '과체중';
    } else if (_bmi > 18.5) {
      return '보통';
    } else {
      return '저체중';
    }
  }
 
  String getInterpretation() {
    if (_bmi > 25) {
      return '살뺍시다 꿀꿀이여';
    } else if (_bmi > 18.5) {
      return '보통 이네요. 운동합시다';
    } else {
      return '저체중 이네요, 먹으면서 운동합시다';
    }
  }
}