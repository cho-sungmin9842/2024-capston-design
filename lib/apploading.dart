import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hansungcapstone_bugiweather/screen.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'NaverMap/mylocation.dart';
import 'httpnetwork.dart';

class AppLoading extends StatefulWidget {
  const AppLoading({super.key});

  @override
  _AppLoadingState createState() => _AppLoadingState();
}

class _AppLoadingState extends State<AppLoading> {

  void getLocation() async {
    Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return HomeScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitWave(
              color: Colors.white,
              size: 60.0,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '위치 정보 업데이트 중',
              style: TextStyle(
                  fontFamily: 'tmon', fontSize: 20.0, color: Colors.black87),
            )
          ],
        ),
      ),
    );
  }
}
