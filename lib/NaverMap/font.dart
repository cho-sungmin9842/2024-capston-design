import 'dart:ui';

import 'package:flutter/material.dart';

class TitleStyle extends TextStyle {
  @override
  // TODO: implement fontSize
  double? get fontSize => 32;
  @override
  // TODO: implement fontFamily
  String? get fontFamily => 'NanumSquareRoundB';
  @override
  // TODO: implement color
  Color? get color => Colors.white;
  @override
  // TODO: implement shadows
  List<Shadow>? get shadows => [
    myShadow(),
  ];
}
class SubStyle extends TextStyle {
  @override
  // TODO: implement fontSize
  double? get fontSize => 26;

  @override
  // TODO: implement fontFamily
  String? get fontFamily => 'NanumSquareRoundB';

  @override
  // TODO: implement color
  Color? get color => Colors.white;
  List<Shadow>? get shadows => [
    myShadow(),
  ];
}
class DateStyle extends TextStyle {
  @override
  // TODO: implement fontSize
  double? get fontSize => 20;

  @override
  // TODO: implement fontFamily
  String? get fontFamily => 'NanumSquareRoundL';

  @override
  // TODO: implement color
  Color? get color => Colors.white;
  List<Shadow>? get shadows => [
    myShadow(),
  ];
}
class MinTempStyle extends TextStyle {
  @override
  // TODO: implement fontSize
  double? get fontSize => 26;

  @override
  // TODO: implement fontFamily
  String? get fontFamily => 'NanumSquareRoundB';

  @override
  // TODO: implement color
  Color? get color => Colors.blueAccent;
  List<Shadow>? get shadows => [
    myShadow(),
  ];
}
class MaxTempStyle extends TextStyle {
  @override
  // TODO: implement fontSize
  double? get fontSize => 26;

  @override
  // TODO: implement fontFamily
  String? get fontFamily => 'NanumSquareRoundB';

  @override
  // TODO: implement color
  Color? get color => Colors.redAccent;
  List<Shadow>? get shadows => [
    myShadow(),
  ];
}
Shadow myShadow() {
  return Shadow(
    color: Colors.grey,
    offset: Offset(0,2),
    blurRadius: 5,
  );
}