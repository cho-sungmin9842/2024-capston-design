import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hansungcapstone_bugiweather/httpnetwork.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:http/http.dart' as http;
import 'NaverMap/mylocation.dart';

class HSTodayWeatherScreen extends StatefulWidget {

  const HSTodayWeatherScreen({super.key,});

  @override
  State<StatefulWidget> createState() => HSTodayWeatherState();
}

class HSTodayWeatherState extends State<HSTodayWeatherScreen> {
  late DateFormat daysFormat; // 요일 한글로

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    daysFormat = DateFormat('E', 'ko_KR'); //요일 한글 표현
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backimg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              flex: 12,
              child: Container(
                // color: Color(0xff74d5ff),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${DateFormat('yyy년 M월 d일 ').format(DateTime.now())}(${daysFormat.format(DateTime.now())})",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        color: Color(0xff000000),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                      width: 16,
                    ),
                    Text(
                      "강남구 논현동",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        color: Color(0xff000000),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                      width: 16,
                    ),
                    Icon(
                      Icons.sunny,
                      size: 80,
                    ),
                    SizedBox(
                      height: 16,
                      width: 16,
                    ),
                    Text(
                      "맑음",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        color: Color(0xff000000),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                      width: 16,
                    ),
                    Text(
                      "12°C",
                      // "${widget.currentWeatherData['response']['body']['items']['item'][3]['obsrValue']}°C",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 35,
                        color: Color(0xff000000),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                      width: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "최저",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                            color: Color(0xff000000),
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          '10°C',
                          // "${widget.todayTMN2}°C",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                            color: Color(0xff000000),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "최고",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                            color: Color(0xff000000),
                          ),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          "10°C",
                          // "${widget.todayTMX2}°C",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                            color: Color(0xff000000),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                          width: 16,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                      width: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('M월 d일 ').format(DateTime.now()) +
                              DateFormat("h:mm a").format(DateTime.now()),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            color: Color(0xff000000),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        // Icon(Icons.update)
                      ],
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 10,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(width: 10),
                    ListViewItem(),
                    SizedBox(width: 20),
                    ListViewItem(),
                    SizedBox(width: 20),
                    ListViewItem(),
                    SizedBox(width: 20),
                    ListViewItem(),
                    SizedBox(width: 20),
                  ],
                ),
                // child: ListView(
                //   padding: const EdgeInsets.all(12),
                //   scrollDirection: Axis.horizontal,
                //   shrinkWrap: false,
                //   physics: ScrollPhysics(),
                //   children: [
                //     SizedBox(width: 10),
                //     ListViewItem(),
                //     SizedBox(width: 20),
                //     ListViewItem(),
                //     SizedBox(width: 20),
                //     ListViewItem(),
                //     SizedBox(width: 20),
                //     ListViewItem(),
                //     SizedBox(width: 20),
                //   ],
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget ListViewItem() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text(
        "지금",
        textAlign: TextAlign.start,
        overflow: TextOverflow.clip,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 25,
          color: Color(0xff000000),
        ),
      ),
      SizedBox(
        height: 16,
      ),
      Icon(
        Icons.sunny,
        size: 60,
        color: Color(0xff212435),
      ),
      SizedBox(
        height: 16,
      ),
      Text(
        "15°C",
        textAlign: TextAlign.start,
        overflow: TextOverflow.clip,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 25,
          color: Color(0xff000000),
        ),
      ),
      SizedBox(
        height: 16,
      ),
      Text(
        "90%",
        textAlign: TextAlign.start,
        overflow: TextOverflow.clip,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 18,
          color: Color(0xff000000),
        ),
      ),
    ],
  );
}
