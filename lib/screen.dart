import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:hansungcapstone_bugiweather/favorites.dart';
import 'package:hansungcapstone_bugiweather/todayweatherscreen.dart';
import 'package:hansungcapstone_bugiweather/setting.dart';
import 'package:intl/intl.dart';
import 'NaverMap/mylocation.dart';
import 'dust.dart';
import 'hstodayweatherscreen.dart';
import 'loading.dart';
import 'package:hansungcapstone_bugiweather/NaverMap/screens/loading.dart';
import 'package:hansungcapstone_bugiweather/week_weather.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key,});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  late List<Widget> _widgetOptions;

  // = <Widget>[
  //   TodayWeatherScreen(),
  //   WeekWeather(),
  //   TodayWeatherScreen(),
  //   LoadingMap(),
  //   Favorites(),
  //   Favorites(),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    _widgetOptions = <Widget>[
      TodayWeatherScreen(),
      WeekWeather(),
      HSTodayWeatherScreen(),
      LoadingMap(),
      Favorites(),
      DustScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
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
                builder: (BuildContext context) => const Setting(),
              ),
            );
          },
          iconSize: 30.0,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: '단기 예보',
          ),
          BottomNavigationBarItem(
              icon: Image.asset("assets/bugi.png", width: 24, height: 24),
              label: "한성대 날씨"),
          const BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: '전국 날씨',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.pin_drop_outlined),
            label: '즐겨찾기',
          ),
          const BottomNavigationBarItem(
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
