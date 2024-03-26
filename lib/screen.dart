import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:hansungcapstone_bugiweather/mainscreen.dart';
import 'loading.dart';
import 'package:hansungcapstone_bugiweather/NaverMap/screens/loading.dart';
import 'package:hansungcapstone_bugiweather/week_weather.dart';
class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<StatefulWidget> createState() => ScreenState();
}

class ScreenState extends State<Screen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    Loading(), screen2(), Loading(), LoadingMap() , MainScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
          onPressed: () {},
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
              icon: Image.asset("assets/bugi.png",width: 24 , height: 24),
              label: "한성대 날씨"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: '전국 날씨',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pin_drop_outlined),
            label: '즐겨찾기',
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
      clientId: '***REMOVED_NAVER_CLIENT_ID***',     // 클라이언트 ID 설정
      onAuthFailed: (e) => log("네이버맵 인증오류 : $e", name: "onAuthFailed")
  );
}