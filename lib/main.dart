import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:hansungcapstone_bugiweather/mainscreen.dart';
import 'package:hansungcapstone_bugiweather/screen.dart';
import 'package:hansungcapstone_bugiweather/NaverMap/screens/loading.dart';
import 'loading.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: Loading(),
      home: Screen(),
    );
  }
}
