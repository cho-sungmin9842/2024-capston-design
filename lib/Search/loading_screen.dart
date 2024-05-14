import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hansungcapstone_bugiweather/Search/weather.dart';
import 'package:hansungcapstone_bugiweather/Search/constants.dart';
import 'package:hansungcapstone_bugiweather/Search/city_screen.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;
  final locationForecast;
  LocationScreen({this.locationWeather, this.locationForecast});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel(); // 현재 날씨
  WeatherModel forecast = WeatherModel(); // 일기 예보

  late int temperature;
  late String cityName;
  late String weatherIcon;
  late Image weatherPic;
  // 현재 날씨

  late int foreTemp1;
  late int foreTemp2;
  late int foreTemp3; // 예보

  late String forecastIcon1, forecastIcon2, forecastIcon3;
  late Image forecastPic;

  late DateTime stamp1;
  late DateTime stamp2;
  late DateTime stamp3; // 기상 예보 발표 시각

  @override
  void initState() {
    super.initState();
    updateUIW(widget.locationWeather);
    updateUIF(widget.locationForecast);
  }

  void updateUIW(var weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        cityName = '';
        return;
      }

      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      int condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      cityName = weatherData['name'];
    });
  }

  void updateUIF(var forecastData){
    setState(() {
      if(forecastData == null){
        foreTemp1 = 0;
        foreTemp2 = 0;
        forecastIcon1= "🫧";
        forecastIcon2 = "🫧";
        forecastIcon3 = "🫧";
        return;
      }

      double foretemp1= forecastData['list'][0]["main"]["temp"];
      foreTemp1 = foretemp1.toInt();

      double foretemp2= forecastData['list'][1]["main"]["temp"];
      foreTemp2 = foretemp2.toInt();

      double foretemp3= forecastData['list'][2]["main"]["temp"];
      foreTemp3 = foretemp3.toInt();


      int condition1 = forecastData['list'][0]['weather'][0]['id'];
      forecastIcon1 = forecast.getWeatherIcon(condition1);

      int condition2 = forecastData['list'][1]['weather'][0]['id'];
      forecastIcon2 = forecast.getWeatherIcon(condition2);

      int condition3 = forecastData['list'][2]['weather'][0]['id'];
      forecastIcon3 = forecast.getWeatherIcon(condition3);


      cityName = forecastData['city']['name'];
      //stamp1 = forecastData['list'][0]['dt_txt'].toString() as DateTime;
      //stamp는 일단 보류...
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(0.0,-1.0),
                end: Alignment(0,1),
                colors: [Color(0xff73d5ff), Color(0xffbed5de)]
            )
        ),

        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUIW(weatherData);
                      var forecastData = await forecast.getLocationForecast();
                      updateUIF(forecastData);
                    },
                    child: const Icon(
                      Icons.near_me_rounded,
                      size: 50.0,
                      color: Colors.indigoAccent,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) {
                          return CityScreen();
                        }),
                      );
                      if (typedName != null) {
                        var weatherData =
                        await weather.getCityWeather(typedName);
                        updateUIW(weatherData);
                        var forecastData =
                        await forecast.getCityForecast(typedName);
                        updateUIF(forecastData);
                      }
                    },
                    child: const Icon(
                      Icons.search_rounded,
                      size: 50.0,
                      color: Colors.indigoAccent,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child:
                Column(
                  children: <Widget>[
                    Text(
                      cityName,
                      style: kButtonTextStyle,
                    ),
                    Text(
                      '$temperature°',
                      style: kTempTextStyleNow,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyleNow,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Text(
                        '$foreTemp1°',
                        style: kTempTextStyleFore,
                      ),
                      Text(
                        forecastIcon1,
                        style: kConditionTextStyleFore,
                      )
                    ],
                  ),
                  SizedBox(width: 40),
                  Column(
                    children: [
                      Text(
                        '$foreTemp2°',
                        style: kTempTextStyleFore,
                      ),
                      Text(
                        forecastIcon2,
                        style: kConditionTextStyleFore,
                      )
                    ],
                  ),
                  SizedBox(width: 40),
                  Column(
                    children: [
                      Text(
                        '$foreTemp3°',
                        style: kTempTextStyleFore,
                      ),
                      Text(
                        forecastIcon3,
                        style: kConditionTextStyleFore,
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}