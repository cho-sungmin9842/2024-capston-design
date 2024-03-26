import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class screen2 extends StatefulWidget {
  @override
  State<screen2> createState() => _screen2State();
}

class _screen2State extends State<screen2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weathr app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Page2(),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(''),
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
            child: Column(children: <Widget>[
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
                      borderRadius:
                      BorderRadius.circular(4.0),
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
                  child: Image.asset(
                    'images/img.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 45.5,
                  height: 57.0,
                  alignment: Alignment.center,
                  child: Text(
                    "13",
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                SizedBox(width: 50),
                Container(
                  width: 30,
                  height: 40,
                  alignment: Alignment.center,
                  child: Image.asset(
                    'images/img.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 45.5,
                  height: 57.0,
                  alignment: Alignment.center,
                  child: Text(
                    "6",
                    style: TextStyle(fontSize: 40), // Example text size
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
                    child: Image.asset(
                      'images/img.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 45.5,
                    height: 57.0,
                    alignment: Alignment.center,
                    child: Text(
                      "9",
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                  SizedBox(width: 50),
                  Container(
                    width: 30,
                    height: 40,
                    alignment: Alignment.center,
                    child: Image.asset(
                      'images/img.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 45.5,
                    height: 57.0,
                    alignment: Alignment.center,
                    child: Text(
                      "5",
                      style: TextStyle(fontSize: 40), // Example text size
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
                    child: Image.asset(
                      'images/img.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 45.5,
                    height: 57.0,
                    alignment: Alignment.center,
                    child: Text(
                      "12",
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                  SizedBox(width: 50),
                  Container(
                    width: 30,
                    height: 40,
                    alignment: Alignment.center,
                    child: Image.asset(
                      'images/img.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 45.5,
                    height: 57.0,
                    alignment: Alignment.center,
                    child: Text(
                      "6",
                      style: TextStyle(fontSize: 40), // Example text size
                    ),
                  )
                ],
              ),
              SizedBox(height: 50),

            ]))
    );

  }
}
