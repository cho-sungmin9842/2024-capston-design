import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hansungcapstone_bugiweather/httpnetwork.dart';
import 'package:hansungcapstone_bugiweather/weather_icon_icons.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:http/http.dart' as http;
import 'NaverMap/mylocation.dart';

class HSTodayWeatherScreen extends StatefulWidget {
  final dynamic addrData;
  final dynamic today2amData;
  final dynamic currentWeatherData;
  final dynamic currenthstodayData;
  final String todayTMN2;
  final String todayTMX2;
  final String skyState;

  const HSTodayWeatherScreen({
    super.key,
    this.addrData,
    this.today2amData,
    this.currenthstodayData,
    this.currentWeatherData,
    required this.todayTMN2,
    required this.todayTMX2,
    required this.skyState,
  });

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${DateFormat('yyyy년 M월 d일 ').format(DateTime.now())}(${daysFormat.format(DateTime.now())})",
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
                      height: 8,
                    ),
                    Text(
                      widget.addrData['documents'][0]['address']
                              ['region_2depth_name'] +
                          " " +
                          widget.addrData['documents'][0]['address']
                              ['region_3depth_name'],
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
                      height: 8,
                    ),
                    // 하늘 상태 정보 아이콘
                    (widget.skyState == "맑음")
                        ? Icon(
                            Icons.sunny,
                            color: Colors.orange,
                            size: 80,
                          )
                        : (widget.skyState == "구름 많음")
                            ? Icon(
                                WeatherIcon.clouds,
                                color: Colors.black12,
                                size: 80,
                              )
                            : Icon(
                                WeatherIcon.cloud_sun,
                                color: Colors.grey,
                                size: 80,
                              ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      // "맑음",
                      widget.skyState,
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
                      height: 3,
                    ),
                    // 시간당 강수량
                    (widget.currentWeatherData['response']['body']['items']
                                ['item'][2]['obsrValue'] ==
                            "0")
                        ? const Text(
                            "강수없음",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 18,
                              color: Color(0xff000000),
                            ),
                          )
                        : Text(
                            "${widget.currentWeatherData['response']['body']['items']['item'][2]['obsrValue']}mm",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 18,
                              color: Color(0xff000000),
                            ),
                          ),
                    const SizedBox(
                      height: 8,
                    ),
                    // 현재 기온
                    Text(
                      // "12°C",
                      "${widget.currentWeatherData['response']['body']['items']['item'][3]['obsrValue']}°C",
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
                      height: 8,
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
                          // '10°C',
                          "${widget.todayTMN2}°C",
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
                          // "10°C",
                          "${widget.todayTMX2}°C",
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
                    const SizedBox(
                      height: 8,
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
                      ],
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 10,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: getListViewItem(widget.currenthstodayData),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> getListViewItem(dynamic currenthstodayData) {
  List<Widget> childs = [];
  var tmp, pop, pcp, sky;
  for (var i = 1;
      i < currenthstodayData['response']['body']['totalCount'];
      i++) {
    if (currenthstodayData['response']['body']['items']['item'][i]
            ['category'] ==
        'SKY') {
      switch (currenthstodayData['response']['body']['items']['item'][i]
          ['fcstValue']) {
        case '1':
          sky = "맑음";
          break;
        case '3':
          sky = "구름 많음";
          break;
        case '4':
          sky = "흐림";
          break;
      }
    }
    if (currenthstodayData['response']['body']['items']['item'][i]
                ['category'] ==
            'TMP' ||
        currenthstodayData['response']['body']['items']['item'][i]
                ['category'] ==
            'POP' ||
        currenthstodayData['response']['body']['items']['item'][i]
                ['category'] ==
            'PCP') {
      if (currenthstodayData['response']['body']['items']['item'][i]
              ['category'] ==
          'TMP') {
        tmp = currenthstodayData['response']['body']['items']['item'][i]
            ['fcstValue'];
      } else if (currenthstodayData['response']['body']['items']['item'][i]
              ['category'] ==
          'POP') {
        pop = currenthstodayData['response']['body']['items']['item'][i]
            ['fcstValue'];
      } else if (currenthstodayData['response']['body']['items']['item'][i]
              ['category'] ==
          'PCP') {
        pcp = currenthstodayData['response']['body']['items']['item'][i]
            ['fcstValue'];
      }
      if (tmp != null && pop != null && pcp != null && sky != null) {
        childs.add(const SizedBox(
          width: 20,
        ));
        childs.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 예보 시간
              Text(
                "${DateFormat('M월 d일').format(getTime(currenthstodayData['response']['body']['items']['item'][i]['fcstDate'] + currenthstodayData['response']['body']['items']['item'][i]['fcstTime']))}" +
                    "(${DateFormat('E', 'ko_KR').format(getTime(currenthstodayData['response']['body']['items']['item'][i]['fcstDate'] + currenthstodayData['response']['body']['items']['item'][i]['fcstTime']))})\n"
                        " ${DateFormat("h:mm a").format(getTime(currenthstodayData['response']['body']['items']['item'][i]['fcstDate'] + currenthstodayData['response']['body']['items']['item'][i]['fcstTime']))}",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 25,
                  color: Color(0xff000000),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              // 하늘 상태 정보 아이콘
              (sky == "맑음")
                  ? Icon(
                      Icons.sunny,
                      color: Colors.orange,
                      size: 60,
                    )
                  : (sky == "구름 많음")
                      ? Icon(
                          WeatherIcon.clouds,
                          color: Colors.black12,
                          size: 60,
                        )
                      : Icon(
                          WeatherIcon.cloud_sun,
                          color: Colors.grey,
                          size: 60,
                        ),
              const SizedBox(
                height: 5,
              ),
              Text(
                sky,
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 18,
                  color: Color(0xff000000),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              // 시간별 기온
              Text(
                "$tmp°C",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 25,
                  color: Color(0xff000000),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              // 강수 확률
              Text(
                "$pop%",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 18,
                  color: Color(0xff000000),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              // 1시간당 강수량
              (pcp == "강수없음")
                  ? const Text(
                      "강수없음",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 18,
                        color: Color(0xff000000),
                      ),
                    )
                  : Text(
                      "${pcp}mm",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 18,
                        color: Color(0xff000000),
                      ),
                    ),
            ],
          ),
        );
        pop = null;
        pcp = null;
        tmp = null;
        sky = null;
      }
    }
  }
  return childs;
}

DateTime getTime(String dateString) {
  //ex 202207081130
  String date = dateString.substring(0, 8);
  String time = dateString.substring(8, 12);
  return DateTime.parse('${date}T$time');
}
