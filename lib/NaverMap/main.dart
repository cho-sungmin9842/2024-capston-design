import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:hansungcapstone_bugiweather/NaverMap/mylocation.dart';
import 'package:hansungcapstone_bugiweather/NaverMap/network.dart';
import 'package:hansungcapstone_bugiweather/NaverMap/screens/loading.dart';
import 'package:hansungcapstone_bugiweather/NaverMap/NaverMapApp.dart';
final apiKey = dotenv.get("openweather_api_key");


/*void main() async {
  await _initialize();
  runApp(MaterialApp(home : Loading(),));
}*/
// 지도 초기화하기
