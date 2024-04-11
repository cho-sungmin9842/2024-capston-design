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
      //서울 25개 구
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.4967&lon=127.0630&appid=$apiKey&units=metric'), // 강남구0
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.5504&lon=127.1470&appid=$apiKey&units=metric'), // 강동구1
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.6435&lon=127.0112&appid=$apiKey&units=metric'), // 강북구2
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.5612&lon=126.8228&appid=$apiKey&units=metric'), // 강서구3
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.4674&lon=126.9453&appid=$apiKey&units=metric'), // 관악구4
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.5467&lon=127.0858&appid=$apiKey&units=metric'), // 광진구5
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.4944&lon=126.8563&appid=$apiKey&units=metric'), // 구로구6
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.4606&lon=126.9008&appid=$apiKey&units=metric'), // 금천구7
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.6525&lon=127.0750&appid=$apiKey&units=metric'), // 노원구8
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.6691&lon=127.0324&appid=$apiKey&units=metric'), // 도봉구9
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.5820&lon=127.0548&appid=$apiKey&units=metric'), // 동대문구10
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.4989&lon=126.9516&appid=$apiKey&units=metric'), // 동작구11
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.5593&lon=126.9083&appid=$apiKey&units=metric'), // 마포구12
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.5778&lon=126.9391&appid=$apiKey&units=metric'), // 서대문구13
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.4733&lon=127.0312&appid=$apiKey&units=metric'), // 서초구14
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.5510&lon=127.0410&appid=$apiKey&units=metric'), // 성동구15
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.6057&lon=127.0176&appid=$apiKey&units=metric'), // 성북구16
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.5056&lon=127.1153&appid=$apiKey&units=metric'), // 송파구17
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.5247&lon=126.8554&appid=$apiKey&units=metric'), // 양천구18
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.5223&lon=126.9102&appid=$apiKey&units=metric'), // 영등포구19
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.5314&lon=126.9799&appid=$apiKey&units=metric'), // 용산구20
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.6192&lon=126.9270&appid=$apiKey&units=metric'), // 은평구21
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.5949&lon=126.9773&appid=$apiKey&units=metric'), // 종로구22
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.5601&lon=126.9960&appid=$apiKey&units=metric'), // 중구23
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.5978&lon=127.0929&appid=$apiKey&units=metric'), // 중랑구24
      // 광역시
      Network('https://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=$apiKey&units=metric'), // 서울25
      Network('https://api.openweathermap.org/data/2.5/weather?lat=35.2100&lon=129.0689&appid=$apiKey&units=metric'), // 부산26
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.1557&lon=126.8354&appid=$apiKey&units=metric'), // 광주27
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.4563&lon=126.7052&appid=$apiKey&units=metric'), // 인천28
      Network('https://api.openweathermap.org/data/2.5/weather?lat=35.5537&lon=129.2381&appid=$apiKey&units=metric'), // 울산29
      Network('https://api.openweathermap.org/data/2.5/weather?lat=36.3398&lon=127.3940&appid=$apiKey&units=metric'), // 대전30
      Network('https://api.openweathermap.org/data/2.5/weather?lat=35.8294&lon=128.5655&appid=$apiKey&units=metric'), // 대구31
      // 시
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.7091&lon=128.8324&appid=$apiKey&units=metric'), // 강릉32
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.0151&lon=127.8957&appid=$apiKey&units=metric'), // 충주33
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.8898&lon=127.7399&appid=$apiKey&units=metric'), // 춘천34
      Network('https://api.openweathermap.org/data/2.5/weather?lat=38.1760&lon=128.5195&appid=$apiKey&units=metric'), // 속초35
      Network('https://api.openweathermap.org/data/2.5/weather?lat=35.8280&lon=127.1160&appid=$apiKey&units=metric'), // 전주36
      Network('https://api.openweathermap.org/data/2.5/weather?lat=34.7604&lon=127.6622&appid=$apiKey&units=metric'), // 여수37
      Network('https://api.openweathermap.org/data/2.5/weather?q=Taebaek,kr&appid=$apiKey&units=metric'), // 태백38
      Network('https://api.openweathermap.org/data/2.5/weather?q=Pohang&appid=$apiKey&units=metric'), // 포항39
      Network('https://api.openweathermap.org/data/2.5/weather?q=Andong&appid=$apiKey&units=metric'), // 안동40
      Network('https://api.openweathermap.org/data/2.5/weather?q=Gimcheon&appid=$apiKey&units=metric'), // 김천41
      Network('https://api.openweathermap.org/data/2.5/weather?q=Pyeongtaek&appid=$apiKey&units=metric'), // 평택42
      // 한성대학교
      Network('https://api.openweathermap.org/data/2.5/weather?lat=37.5828&lon=127.0106&appid=$apiKey&units=metric'), // 한성대학교43


    ];

    //var weatherData = await network.getJsonData();
    List<dynamic> weatherDataList = await Future.wait(networks.map(
            (network) => network.getJsonData()).toList()
    );
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
      debugShowCheckedModeBanner: false,
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