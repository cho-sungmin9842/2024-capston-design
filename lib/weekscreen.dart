import 'dart:ui';
import 'package:flutter/material.dart';
import 'model.dart';

class weekScreen extends StatefulWidget {
  weekScreen({this.parseWeatherData});

  final dynamic parseWeatherData;

  @override
  State<weekScreen> createState() => _backscreen();
}

class _backscreen extends State<weekScreen> {
  Model model = Model();
  final Color backgroundColor = Colors.blue;

  List<String> weekDays = [];
  List<int> mornTempList = [];
  List<int> eveTempList = [];
  List<Widget> icon = [];

  @override
  void initState() {
    super.initState();
    //getLocation();
    updateData(widget.parseWeatherData);
  }

  void updateData(dynamic weatherData) {
    for (var dayForecast in weatherData) {
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
      Widget? weatherIcon = model.getWeatherIcon(condition);
      if (weatherIcon != null) {
        icon.add(weatherIcon); // Only add if not null.
      }
    }
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Stack(children: [
        Container(
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
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(16), // Add margin
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), // Rounded corners
              color: Colors.white.withOpacity(0.3),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(children: [
                    SizedBox(width: 30),
                    Container(
                      width: 95,
                      height: 38,
                      alignment: Alignment.center,
                      child: Text(
                        '${weekDays[0]}',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                    //SizedBox(width: 10,),
                    Container(
                      alignment: Alignment.center,
                      child: icon[0],
                    ),
                    SizedBox(width: 40),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "${mornTempList[0]}/${eveTempList[0]}",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ]),
                  SizedBox(height: 20),
                  Row(children: [
                    SizedBox(width: 30),
                    Container(
                      width: 95, // Specify the width
                      height: 38, // Specify the height
                      alignment: Alignment.center,
                      child: Text(
                        '${weekDays[1]}',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                    //SizedBox(width: 10,),
                    Container(
                      alignment: Alignment.center,
                      child: icon[1],
                    ),
                    SizedBox(width: 40),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "${mornTempList[1]}/${eveTempList[1]}",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ]),
                  SizedBox(height: 20),
                  Row(children: [
                    SizedBox(width: 30),
                    Container(
                      width: 95, // Specify the width
                      height: 38, // Specify the height
                      alignment: Alignment.center,
                      child: Text(
                        '${weekDays[2]}',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                    //SizedBox(width: 10,),
                    Container(
                      alignment: Alignment.center,
                      child: icon[2],
                    ),
                    SizedBox(width: 40),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "${mornTempList[2]}/${eveTempList[2]}",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ]),
                  SizedBox(height: 20),
                  Row(children: [
                    SizedBox(width: 30),
                    Container(
                      width: 95, // Specify the width
                      height: 38, // Specify the height
                      alignment: Alignment.center,
                      child: Text(
                        '${weekDays[3]}',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                    //SizedBox(width: 10,),
                    Container(
                      alignment: Alignment.center,
                      child: icon[3],
                    ),
                    SizedBox(width: 40),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "${mornTempList[3]}/${eveTempList[3]}",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ]),
                  SizedBox(height: 20),
                  Row(children: [
                    SizedBox(width: 30),
                    Container(
                      width: 95, // Specify the width
                      height: 38, // Specify the height
                      alignment: Alignment.center,
                      child: Text(
                        '${weekDays[4]}',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                    //SizedBox(width: 10,),
                    Container(
                      alignment: Alignment.center,
                      child: icon[4],
                    ),
                    SizedBox(width: 40),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "${mornTempList[4]}/${eveTempList[4]}",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ]),
                  SizedBox(height: 20),
                  Row(children: [
                    SizedBox(width: 30),
                    Container(
                      width: 95, // Specify the width
                      height: 38, // Specify the height
                      alignment: Alignment.center,
                      child: Text(
                        '${weekDays[5]}',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                    //SizedBox(width: 10,),
                    Container(
                      alignment: Alignment.center,
                      child: icon[5],
                    ),
                    SizedBox(width: 40),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "${mornTempList[5]}/${eveTempList[5]}",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ]),
                  SizedBox(height: 20),
                  Row(children: [
                    SizedBox(width: 30),
                    Container(
                      width: 95, // Specify the width
                      height: 38, // Specify the height
                      alignment: Alignment.center,
                      child: Text(
                        '${weekDays[6]}',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                    //SizedBox(width: 10,),
                    Container(
                      alignment: Alignment.center,
                      child: icon[6],
                    ),
                    SizedBox(width: 40),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "${mornTempList[6]}/${eveTempList[6]}",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ]),
                  SizedBox(height: 20),
                  Row(children: [
                    SizedBox(width: 30),
                    Container(
                      width: 95, // Specify the width
                      height: 38, // Specify the height
                      alignment: Alignment.center,
                      child: Text(
                        '${weekDays[7]}',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                    //SizedBox(width: 10,),
                    Container(
                      alignment: Alignment.center,
                      child: icon[7],
                    ),
                    SizedBox(width: 40),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "${mornTempList[7]}/${eveTempList[7]}",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ]),
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}