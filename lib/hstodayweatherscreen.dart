import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hansungcapstone_bugiweather/httpnetwork.dart';
import 'package:hansungcapstone_bugiweather/todayweatherscreen.dart';
import 'package:hansungcapstone_bugiweather/weather_icon_icons.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:http/http.dart' as http;
import 'NaverMap/font.dart';
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

class HSTodayWeatherState extends State<HSTodayWeatherScreen>
    with SingleTickerProviderStateMixin {
  late DateFormat daysFormat; // 요일 한글로
  String skyStateUrl = "";
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    daysFormat = DateFormat('E', 'ko_KR'); //요일 한글 표현

    switch (widget.skyState) {
      case "맑음" :
        skyStateUrl="assets/Clear.png";
      case "흐림" :
        skyStateUrl="assets/Haze.png";
      case "구름 많음" :
        skyStateUrl="assets/Clouds.png";
      default :
        skyStateUrl="assets/backimg.png";
    }
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animationController);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(skyStateUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                flex: 12,
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/hansung.png"),
                        opacity: 0.4,
                        scale: 0.6),
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                    color: Colors.black.withOpacity(0.2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/bugi.png",
                            width: 60,
                          ),
                          Text(
                            "${DateFormat('yyyy년 M월 d일 ').format(DateTime.now())}(${daysFormat.format(DateTime.now())})",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "한성대학교",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: Title54Style(),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          (widget.skyState == "맑음")
                              ? Image.asset(
                                  "images/sun_1x.png",
                                  width: 130,
                                  height: 130,
                                )
                              : (widget.skyState == "구름 많음")
                                  ? Image.asset(
                                      "images/cloud_1x.png",
                                      width: 130,
                                      height: 130,
                                    )
                                  : (widget.skyState == "비")
                                      ? Image.asset(
                                          "images/rain_1x.png",
                                          width: 130,
                                          height: 130,
                                        )
                                      : (widget.skyState == "눈")
                                          ? Image.asset(
                                              "images/snow_1x.png",
                                              width: 130,
                                              height: 130,
                                            )
                                          : Image.asset(
                                              "images/sunc_1x.png",
                                              width: 130,
                                              height: 130,
                                            ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                      // 하늘 상태 정보 아이콘
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.skyState,
                            textAlign: TextAlign.center,
                            style: SubStyle(),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          // 시간당 강수량
                          (widget.currentWeatherData['response']['body']
                                      ['items']['item'][2]['obsrValue'] ==
                                  "0")
                              ? const Text(
                                  "강수없음",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 18,
                                    color: Colors.white,
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
                            "${widget.currentWeatherData['response']['body']['items']['item'][3]['obsrValue']}°C",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TempStyle(),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.todayTMN2}°C",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: MinTempStyle(),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                " / ",
                                style: TextStyle(
                                    fontSize: 26, color: Colors.white54),
                              ),
                              Text(
                                "${widget.todayTMX2}°C",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: MaxTempStyle(),
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
                                DateFormat("h:mm a").format(DateTime.now()),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 20,
                                  color: Colors.white54,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 10,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      //borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: getListViewItem(widget.currenthstodayData),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
    } else if (currenthstodayData['response']['body']['items']['item'][i]
            ['category'] ==
        'PTY') {
      switch (currenthstodayData['response']['body']['items']['item'][i]
          ['fcstValue']) {
        case '1':
          sky = "비";
          break;
        case '3':
          sky = "눈";
          break;
        case '4':
          sky = "비";
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
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 예보 시간
                Text(
                  "${DateFormat('M월 d일').format(getTime(currenthstodayData['response']['body']['items']['item'][i]['fcstDate'] + currenthstodayData['response']['body']['items']['item'][i]['fcstTime']))}" +
                      "(${DateFormat('E', 'ko_KR').format(getTime(currenthstodayData['response']['body']['items']['item'][i]['fcstDate'] + currenthstodayData['response']['body']['items']['item'][i]['fcstTime']))})\n"
                          "${DateFormat("h:mm a").format(getTime(currenthstodayData['response']['body']['items']['item'][i]['fcstDate'] + currenthstodayData['response']['body']['items']['item'][i]['fcstTime']))}",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    shadows: [myShadow()],
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                // 하늘 상태 정보 아이콘
                (sky == "맑음")
                    ? Image.asset(
                        "images/sun_1x.png",
                        width: 70,
                        height: 70,
                      )
                    : (sky == "구름 많음")
                        ? Image.asset(
                            "images/cloud_1x.png",
                            width: 70,
                            height: 70,
                          )
                        : (sky == "비")
                            ? Image.asset(
                                "images/rain_1x.png",
                                width: 70,
                                height: 70,
                              )
                            : (sky == "눈")
                                ? Image.asset(
                                    "images/snow_1x.png",
                                    width: 70,
                                    height: 70,
                                  )
                                : Image.asset(
                                    "images/sunc_1x.png",
                                    width: 70,
                                    height: 70,
                                  ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 5,
                ),
                // 시간별 기온
                Text(
                  "$tmp°C",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 25,
                    fontFamily: 'NanumSquareRoundB',
                    shadows: [myShadow()],
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                // 강수 확률
                Row(
                  children: [
                    Image.asset(
                      "assets/rainicon.png",
                      width: 30,
                      height: 30,
                      color: Colors.white70,
                    ),
                    Text(
                      " $pop%",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 25,
                          color: Colors.white,
                          shadows: [myShadow()]),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                // 1시간당 강수량
                (pcp == "강수없음")
                    ? Text(
                        "강수없음",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 18,
                            fontFamily: 'NanumSquareRoundB',
                            color: Color(0xff000000),
                            shadows: [myShadow()]),
                      )
                    : Text(
                        "$pcp",
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

class TempShadow extends Shadow {
  @override
  // TODO: implement color
  Color get color => Colors.grey;

  @override
  // TODO: implement blurRadius
  double get blurRadius => 5;

  @override
  // TODO: implement offset
  Offset get offset => Offset(0, 2);
}
