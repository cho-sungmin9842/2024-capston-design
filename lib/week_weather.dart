import 'package:flutter/material.dart';

class WeekWeather extends StatefulWidget {
  const WeekWeather({super.key});

  @override
  State<WeekWeather> createState() => _WeekWeatherState();
}

class _WeekWeatherState extends State<WeekWeather> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF74D5FF),
              Color(0xFFBFD5FF),
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Column(
              children: [
                Container(
                  width: 500,
                  height: 250,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  padding: EdgeInsets.only(
                      left: 20.0, top: 16.0, right: 20.0, bottom: 16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFE1F5FE),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    "화요일인 19일은 종국 발해만 부근의 동쪽으로"
                    "이동하는 저기압의 영향을 받으면서 전국이 대체로 흐리고,"
                    "오후(12~18)에 중부지장에 비가 오는 곳이 있겠습니다.",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    softWrap: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(children: [
              SizedBox(width: 50),
              Text(
                '금',
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(width: 50),
              Container(
                width: 30,
                height: 40,
                alignment: Alignment.center,
                child: const Icon(Icons.sunny),
              ),
              SizedBox(width: 10),
              Container(
                width: 45.5,
                height: 57.0,
                alignment: Alignment.center,
                child: Text(
                  "13°C",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              SizedBox(width: 50),
              Container(
                width: 30,
                height: 40,
                alignment: Alignment.center,
                child: const Icon(Icons.sunny)
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 45.5,
                height: 57.0,
                alignment: Alignment.center,
                child: Text(
                  "6°C",
                  style: TextStyle(fontSize: 30), // Example text size
                ),
              )
            ]),
            SizedBox(height: 50),
            Row(
              children: [
                SizedBox(width: 50),
                Text(
                  '토',
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(width: 50),
                Container(
                  width: 30,
                  height: 40,
                  alignment: Alignment.center,
                  child: const Icon(Icons.sunny),
                ),
                SizedBox(width: 10),
                Container(
                  width: 45.5,
                  height: 57.0,
                  alignment: Alignment.center,
                  child: Text(
                    "9°C",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                SizedBox(width: 50),
                Container(
                  width: 30,
                  height: 40,
                  alignment: Alignment.center,
                  child: const Icon(Icons.sunny)
                ),
                SizedBox(width: 10),
                Container(
                  width: 45.5,
                  height: 57.0,
                  alignment: Alignment.center,
                  child: Text(
                    "5°C",
                    style: TextStyle(fontSize: 30), // Example text size
                  ),
                )
              ],
            ),
            SizedBox(height: 50),
            Row(
              children: [
                SizedBox(width: 50),
                Text(
                  '일',
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(width: 50),
                Container(
                  width: 30,
                  height: 40,
                  alignment: Alignment.center,
                  child: const Icon(Icons.sunny),
                ),
                SizedBox(width: 10),
                Container(
                  width: 45.5,
                  height: 57.0,
                  alignment: Alignment.center,
                  child: Text(
                    "12°C",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                SizedBox(width: 50),
                Container(
                  width: 30,
                  height: 40,
                  alignment: Alignment.center,
                  child: const Icon(Icons.sunny),
                ),
                SizedBox(width: 10),
                Container(
                  width: 45.5,
                  height: 57.0,
                  alignment: Alignment.center,
                  child: Text(
                    "6°C",
                    style: TextStyle(fontSize: 30), // Example text size
                  ),
                )
              ],
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
