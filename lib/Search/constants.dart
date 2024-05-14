import 'package:flutter/material.dart';

const kButtonTextStyle = TextStyle(
    fontSize: 30.0,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700
);

const kTempTextStyleNow = TextStyle(
  fontFamily: 'Inter',
  fontSize: 90.0,
);


const kConditionTextStyleNow = TextStyle(
  fontSize: 90.0,
);

const kTempTextStyleFore = TextStyle(
    fontSize: 35.0,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400
);

const kConditionTextStyleFore = TextStyle(
  fontSize: 40.0,
  fontFamily: 'Inter',
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_pin,
    color: Colors.white,
    size: 30.0,
  ),
  hintText: '도시 검색...',
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(35),
    ),
    borderSide: BorderSide.none,
  ),
);