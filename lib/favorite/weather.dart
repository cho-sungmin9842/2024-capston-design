import 'dart:async';
import 'package:flutter/widgets.dart';
import 'location.dart';
import 'networking.dart';

// https://api.openweathermap.org/data/2.5/forecast?q=Seoul&appid=***REMOVED_OWM_KEY***&units=metric&lang=kr&cnt=3

const apiKey = '***REMOVED_OWM_KEY***';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
const openForecastURL = 'https://api.openweathermap.org/data/2.5/forecast';
const addons = '&appid=$apiKey&lang=kr&units=metric';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$openWeatherMapURL?q=$cityName$addons';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location
            .longitude}$addons');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getCityForecast(String cityName) async {
    var url = '$openForecastURL?q=$cityName$addons&cnt=4';
    NetworkHelper networkHelper = NetworkHelper(url);
    var forecastData = await networkHelper.getData();
    return forecastData;
  }
  // cnt=4 : 3시간 간격 일기예보 데이터 중 맨 앞 4개 불러오기, 오류 방지 위해 4개 불러서 3개 보이게

  Future<dynamic> getLocationForecast() async{
    Location location = Location();
    await location.getCurrentLocation();
    var url = '$openForecastURL?lat=${location.latitude}&lon=${location.longitude}$addons&cnt=4';
    NetworkHelper networkHelper = NetworkHelper(url);
    var forecastData = await networkHelper.getData();
    return forecastData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧️';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  Image getWeatherImage(int condition){
    if (condition < 300) {
      return Image.asset('assets/weather_icons/storm.png');
    } else if (condition < 400) {
      return Image.asset('assets/weather_icons/rain_2x.png');
    } else if (condition < 600) {
      return Image.asset('assets/weather_icons/rain_2x.png');
    } else if (condition < 700) {
      return Image.asset('assets/weather_icons/snow_2x.png');
    } else if (condition < 800) {
      return Image.asset('assets/weather_icons/ptcl_2x.png');
    } else if (condition == 800) {
      return Image.asset('assets/weather_icons/sun_2x.png');
    } else if (condition <= 804) {
      return Image.asset('assets/weather_icons/cloud_2x.png');
    } else {
      return Image.asset('assets/weather_icons/ptcl_2x.png');
    }
  }

}
