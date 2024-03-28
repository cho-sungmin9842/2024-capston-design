import 'dart:developer';

import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:hansungcapstone_bugiweather/NaverMap/main.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:hansungcapstone_bugiweather/NaverMap/mylocation.dart';
import 'package:hansungcapstone_bugiweather/NaverMap/network.dart';
import 'package:hansungcapstone_bugiweather/NaverMap/main.dart';
import 'package:hansungcapstone_bugiweather/NaverMap/NaverMapApp.dart';

const apiKey = '***REMOVED_OWM_KEY***';

class LoadingMap extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<LoadingMap> {

  double? latitude3;
  double? longitude3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();

  }

  void getLocation() async {
    await _initialize();
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;
    print(latitude3);
    print(longitude3);

    //Network network = Network('https://api.openweathermap.org/data/2.5/weather''?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric');
    List<Network> networks = [
      Network('https://api.openweathermap.org/data/2.5/weather''?lat=37.5978&lon=127.0929&appid=$apiKey&units=metric'), // 중랑구
      Network('https://api.openweathermap.org/data/2.5/weather''?lat=37.5820&lon=127.0548&appid=$apiKey&units=metric'), // 동대문구
      Network('https://api.openweathermap.org/data/2.5/weather''?lat=37.6057&lon=127.0176&appid=$apiKey&units=metric'), // 성북구
      Network('https://api.openweathermap.org/data/2.5/weather''?lat=37.5949&lon=126.9773&appid=$apiKey&units=metric'), // 종로구
      Network('https://api.openweathermap.org/data/2.5/weather''?lat=37.5778&lon=126.9391&appid=$apiKey&units=metric'), // 서대문구
    ];

    //var weatherData = await network.getJsonData();
    List<dynamic> weatherDataList = await Future.wait(networks.map((network) => network.getJsonData()).toList());
    print(weatherDataList);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NaverMapApp(parseWeatherData: weatherDataList,);
    }));
    //NaverMapApp(parseWeatherData: weatherDataList,);
  }

  // void fetchData() async{
  //
  //
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: Scaffold(
          /*        appBar: AppBar(
            title: Text('아니'),
            leading: IconButton(
              onPressed: () { },
              icon: Icon(Icons.list),
            ),
            backgroundColor: Colors.cyan,
          ),*/
          body: Center(
            child: ElevatedButton(
              onPressed: (){},
              child: Text('위치 정보를 가져오는 중입니다...'),
            ),
          ),
          /*       bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.star),
                  onPressed:(){} ,
                ),
                Icon(Icons.add_chart),
                Icon(Icons.key),
              ],
            ),
          ),*/
        ),
      ),
    );
  }
}
Future<void> _initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(
      clientId: '***REMOVED_NAVER_CLIENT_ID***',     // 클라이언트 ID 설정
      onAuthFailed: (e) => log("네이버맵 인증오류 : $e", name: "onAuthFailed")
  );
}