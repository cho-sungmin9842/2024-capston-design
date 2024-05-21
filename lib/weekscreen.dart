import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hansungcapstone_bugiweather/NaverMap/font.dart';
import 'package:hansungcapstone_bugiweather/SkyStateImg.dart';
import 'model.dart';

class weekScreen extends StatefulWidget {
  weekScreen({this.parseWeatherData, this.parseWeatherData2, required this.skyStateCode});

  final dynamic parseWeatherData;
  final dynamic parseWeatherData2;
  final String skyStateCode;

  @override
  State<weekScreen> createState() => _backscreen();
}

class _backscreen extends State<weekScreen> with SingleTickerProviderStateMixin {
  Model model = Model();
  final Color backgroundColor = Colors.blue;

  List<String> weekDays = [];
  List<int> mornTempList = [];
  List<int> eveTempList = [];
  List<Widget> icon = [];
  String? textForecast;

  String? text;
  String? forestText;

  String skyState="";

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    //getLocation();
    updateData(widget.parseWeatherData);
    updateData2(widget.parseWeatherData2);
    skyState=getSkyState(widget.skyStateCode);
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

  void updateData(dynamic weatherData) {
    for (var dayForecast in weatherData) {
      //print(dayForecast);
      double mornTemp = (dayForecast['temp']['morn'] as num).toDouble();
      //double mornTemp = dayForecast['temp']['morn'];
      mornTempList.add(kelvinToCelsius(mornTemp));

      double eveTemp = (dayForecast['temp']['eve'] as num).toDouble();
      //double eveTemp = dayForecast['temp']['eve'];
      eveTempList.add(kelvinToCelsius(eveTemp));

      int dt = dayForecast['dt'];
      DateTime date = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
      weekDays.add(getWeekDay(date.weekday));

      int condition = dayForecast['weather'][0]['id'];
      //print(dayForecast['weather'][0]['id']);
      // print(condition);
      Widget? weatherIcon = model.getWeatherIcon(condition);
      if (weatherIcon != null) {
        //print(condition);
        icon.add(weatherIcon); // Only add if not null.
      }
    }
    print(weatherData[0]['weather'][0]['id']);
    skyState=getSkyState(weatherData[0]['weather'][0]['id'].toString());
  }
  void updateData2(dynamic weatherTextdata){
    text = weatherTextdata;

    StringBuffer result = StringBuffer();
    if (text != null) {
      for (int i = 0; i < text!.length; i++) {
        if (text![i] == '*') {
          break;
        }
        result.write(text![i]);

        // \n을 찾으면 하나 더 추가
        if (text![i] == '\n') {
          result.write('\n');
        }
      }
    }

    setState(() {
      forestText = result.toString().trim();
    });
  }

  String getWeekDay(int weekday) {
    List<String> weekDays = [
      "월(Mon)",
      "화(Tue)",
      "수(Wed)",
      "목(Thu)",
      "금(Fri)",
      "토(Sat)",
      "일(Sun)"
    ];
    return weekDays[weekday - 1]; // Dart에서 주의 요일은 1부터 시작합니다.
  }


  int kelvinToCelsius(double kelvin) {
    return (kelvin - 273.15).round();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(skyState) ,fit: BoxFit.cover
              )
          ),
        ),
        SingleChildScrollView(
          child: FadeTransition(
            opacity: _animation,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                    color: Colors.black.withOpacity(0.2),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 230,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            '$forestText',
                            style: SubStyle(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                    width: 380,
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey.shade400,
                    )
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                    color: Colors.black.withOpacity(0.2),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Row(
                            children: [
                              SizedBox(width: 10),
                              Container(
                                width: 95,
                                height: 38,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    '${weekDays[0]}',
                                    style: Title54Style()
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                alignment: Alignment.center,
                                child: icon[0],
                                height: 70,
                                width: 70,
                              ),
                              SizedBox(width: 10),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "${mornTempList[0]}°/${eveTempList[0]}°",
                                  style: SubStyle(),
                                ),
                              ),
                              SizedBox(width: 10),
                            ]),
                      ),
                      //SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Row(
                            children: [
                              SizedBox(width: 10),
                              Container(
                                width: 95, // Specify the width
                                height: 38, // Specify the height
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    '${weekDays[1]}',
                                    style: Title54Style()
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                alignment: Alignment.center,
                                child: icon[1],
                                height: 70,
                                width: 70,
                              ),
                              SizedBox(width: 10),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "${mornTempList[1]}°/${eveTempList[1]}°",
                                  style: Title54Style(),
                                ),
                              ),
                              SizedBox(width: 10),
                            ]),
                      ),
                      //SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Row(children: [
                          SizedBox(width: 10),
                          Container(
                            width: 95, // Specify the width
                            height: 38, // Specify the height
                            alignment: Alignment.centerLeft,
                            child: Text(
                                '${weekDays[2]}',
                                style: Title54Style()
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            alignment: Alignment.center,
                            child: icon[2],
                            height: 70,
                            width: 70,
                          ),
                          SizedBox(width: 10),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "${mornTempList[2]}°/${eveTempList[2]}°",
                              style: Title54Style(),
                            ),
                          ),
                          SizedBox(width: 10),
                        ]),
                      ),
                      //SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Row(children: [
                          SizedBox(width: 10),
                          Container(
                            width: 95, // Specify the width
                            height: 38, // Specify the height
                            alignment: Alignment.centerLeft,
                            child: Text(
                                '${weekDays[3]}',
                                style: Title54Style()
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            alignment: Alignment.center,
                            child: icon[3],
                            height: 70,
                            width: 70,
                          ),
                          SizedBox(width: 10),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "${mornTempList[3]}°/${eveTempList[3]}°",
                              style: Title54Style(),
                            ),
                          ),
                          SizedBox(width: 10),
                        ]),
                      ),
                      //SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Row(children: [
                          SizedBox(width: 10),
                          Container(
                            width: 95, // Specify the width
                            height: 38, // Specify the height
                            alignment: Alignment.centerLeft,
                            child: Text(
                                '${weekDays[4]}',
                                style: Title54Style()
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            alignment: Alignment.center,
                            child: icon[4],
                            height: 70,
                            width: 70,
                          ),
                          SizedBox(width: 10),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                                "${mornTempList[4]}°/${eveTempList[4]}°",
                                style: Title54Style()
                            ),
                          ),
                          SizedBox(width: 10),
                        ]),
                      ),
                      //SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Row(children: [
                          SizedBox(width: 10),
                          Container(
                            width: 100, // Specify the width
                            height: 38, // Specify the height
                            alignment: Alignment.centerLeft,
                            child: Text(
                                '${weekDays[5]}',
                                style: Title54Style()
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            alignment: Alignment.center,
                            child: icon[5],
                            height: 70,
                            width: 70,
                          ),
                          SizedBox(width: 10),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "${mornTempList[5]}°/${eveTempList[5]}°",
                              style: Title54Style(),
                            ),
                          ),
                          SizedBox(width: 10),
                        ]),
                      ),
                      //SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Row(children: [
                          SizedBox(width: 10),
                          Container(
                            width: 100, // Specify the width
                            height: 38, // Specify the height
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${weekDays[6]}',
                              style: Title54Style(),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            alignment: Alignment.center,
                            child: icon[6],
                            height: 70,
                            width: 70,
                          ),
                          SizedBox(width: 10),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "${mornTempList[6]}°/${eveTempList[6]}°",
                              style: Title54Style(),
                            ),
                          ),
                          SizedBox(width: 10),
                        ]),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        )
      ]),
    );
  }
}