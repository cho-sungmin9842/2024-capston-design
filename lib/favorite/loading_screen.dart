import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hansungcapstone_bugiweather/favorite/weather.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();
    var forecastData = await WeatherModel().getLocationForecast();

    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) {
        return LocationScreen(locationWeather: weatherData, locationForecast: forecastData);
      }),  // MaterialPageRoute
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: SpinKitRing(
            color: Colors.indigoAccent,
            size: 100,
          ),  // SpinKitDoubleBounce
        ),
    );  // Scaffold
  }
}