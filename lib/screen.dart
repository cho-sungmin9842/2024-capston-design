import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:hansungcapstone_bugiweather/favorites.dart';
import 'package:hansungcapstone_bugiweather/todayweatherscreen.dart';
import 'package:hansungcapstone_bugiweather/setting.dart';
import 'dust_screen.dart';
import 'loading.dart';
import 'package:hansungcapstone_bugiweather/NaverMap/screens/loading.dart';
import 'package:hansungcapstone_bugiweather/week_weather.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen(
      {super.key,
      this.parse2amData,
      this.parseShortTermWeatherData,
      this.parseCurrentWeatherData,
      this.parseSuperShortWeatherData,
      this.parseAirConditionData,
      this.parseAddrData});

  // 오늘 단기 예보 json
  final dynamic parse2amData;

  // 단기 예보 json
  final dynamic parseShortTermWeatherData;

  // 초단기 실황 json
  final dynamic parseCurrentWeatherData;

  // 초단기 예보 json
  final dynamic parseSuperShortWeatherData;

  // 측정소별 실시간 대기오염 정보 json
  final dynamic parseAirConditionData;

  // 현재 위치 정보 json
  final dynamic parseAddrData;

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // 오늘 단기 예보 json
  late final dynamic parse2amData;

  // 단기 예보 json
  late final dynamic parseShortTermWeatherData;

  // 초단기 실황 json
  late final dynamic parseCurrentWeatherData;

  // 초단기 예보 json
  late final dynamic parseSuperShortWeatherData;

  // 측정소별 실시간 대기오염 정보 json
  late final dynamic parseAirConditionData;

  // 현재 위치 정보 json
  late final dynamic parseAddrData;

  final List<Widget> _widgetOptions = <Widget>[
    TodayWeatherScreen(),
    WeekWeather(),
    TodayWeatherScreen(),
    LoadingMap(),
    Favorites(),
    dustScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    updateData(
      widget.parse2amData,
      widget.parseShortTermWeatherData,
      widget.parseCurrentWeatherData,
      widget.parseSuperShortWeatherData,
      widget.parseAirConditionData,
      widget.parseAddrData,
    );
  }

  void updateData(
    dynamic today2amData,
    dynamic shortTermWeatherData,
    dynamic currentWeatherData,
    dynamic superShortWeatherData,
    dynamic airConditionData,
    dynamic addrData,
  ) {
    parse2amData = today2amData;
    parseShortTermWeatherData = shortTermWeatherData;
    parseCurrentWeatherData = currentWeatherData;
    parseSuperShortWeatherData = superShortWeatherData;
    parseAirConditionData = airConditionData;
    parseAddrData = addrData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => Setting(),
              ),
            );
          },
          iconSize: 30.0,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: '단기 예보',
          ),
          BottomNavigationBarItem(
              icon: Image.asset("assets/bugi.png", width: 24, height: 24),
              label: "한성대 날씨"),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: '전국 날씨',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pin_drop_outlined),
            label: '즐겨찾기',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: '대기질 정보',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}

Future<void> _initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(
      clientId: '***REMOVED_NAVER_CLIENT_ID***', // 클라이언트 ID 설정
      onAuthFailed: (e) => log("네이버맵 인증오류 : $e", name: "onAuthFailed"));
}
