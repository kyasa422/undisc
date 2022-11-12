import 'package:flutter/material.dart';

class Themes{
  late Color primary;
  late Color transparent;
  late Color dark;
  late Color white;
  late Color grey300;
  late Color grey200;
  late Color grey100;
  late Color black54;
  late Color grey400;
  late Color grey500;
  late Color success;
  late Color danger;
  late Color grey;

  Themes(){
    primary = const Color(0xFF310064);
    transparent = Colors.transparent;
    dark = Colors.black;
    white = Colors.white;
    grey300 = Colors.grey.shade300;
    grey100 = Colors.grey.shade100;
    black54 = Colors.black54;
    grey400 = Colors.grey.shade400;
    grey500 = Colors.grey.shade500;
    success = Colors.green.shade400;
    danger = Colors.red.shade400;
    grey = Colors.grey;
    grey200 = Colors.grey.shade200;
  }
}