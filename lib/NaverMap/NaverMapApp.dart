
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:hansungcapstone_bugiweather/NaverMap/mylocation.dart';
import 'package:hansungcapstone_bugiweather/NaverMap/network.dart';
import 'package:hansungcapstone_bugiweather/NaverMap/screens/loading.dart';
import 'package:fluttertoast/fluttertoast.dart';
const apiKey = '***REMOVED_OWM_KEY***';

class NaverMapApp extends StatefulWidget {
  const NaverMapApp({Key? key, required this.parseWeatherData});
  final List<dynamic> parseWeatherData;
  @override
  State<NaverMapApp> createState() => _NaverMapAppState();
}
class _NaverMapAppState extends State<NaverMapApp> {
  List<String> cityName=[];
  List<double> temp=[];
  DateTime? currentBackPressTime;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateData(widget.parseWeatherData);
  }
  void updateData(List<dynamic> weatherData) {
    /*temp = weatherData[0]['main']['temp'];
    cityName = weatherData[0]['name'];*/

    for(int i=0; i<weatherData.length; i++ ) {
      double temp2=weatherData[i]['main']['temp'];
      String cityName2=weatherData[i]['name'];

      temp.add(temp2);
      cityName.add(cityName2);
      print(temp);
      print(temp2);
    }
  }
  void _showBackDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('정말 뒤로 가시겠습니까?'),
          content: const Text(
            '현재 페이지를 나가시겠습니까?',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('아니오'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('네'),
              onPressed: () {
                exit(0);
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    // NaverMapController 객체의 비동기 작업 완료를 나타내는 Completer 생성
    final Completer<NaverMapController> mapControllerCompleter = Completer();
    String city;
    return PopScope(
      canPop: true ,
      onPopInvoked: (bool didPop) {

        //didPop == true , 뒤로가기 제스쳐가 감지되면 호출 된다.
        if (didPop) {
          print('didPop호출');
          return;
        }
        _showBackDialog();
      },
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Seoul Weather', style: new TextStyle(fontFamily: 'Poppins', fontSize: 36.0, fontWeight: FontWeight.w600, color: Colors.white),),
            leading: IconButton(
              onPressed: () { },
              icon: Icon(Icons.list),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color(0xff74d5ff),
                    Color(0xffbfd5ff),
                  ]
                )
              ),
            ),
          ),
          body: Center(
            child: Container(
              color: Colors.blue,
              //height: 500,
              //margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: NaverMap(
                onMapTapped: (point, latLng) {
                  print(latLng);
                },
                options: const NaverMapViewOptions(
                  initialCameraPosition: NCameraPosition(target: NLatLng(37.5665, 126.9780), zoom:10.0),
                  indoorEnable: true,             // 실내 맵 사용 가능 여부 설정
                  locationButtonEnable: true,   //  위치 버튼 표시 여부 설정
                  consumeSymbolTapEvents: false,  // 심볼 탭 이벤트 소비 여부 설정
                  extent: NLatLngBounds(
                    southWest: NLatLng(31.43, 122.37),
                    northEast: NLatLng(44.35, 132.0),
                  ),
                  minZoom: 6,
                  maxZoom: 8,
                  tiltGesturesEnable: false,
                  rotationGesturesEnable: false,
                ),
                onMapReady: (controller) async {                // 지도 준비 완료 시 호출되는 콜백 함수
                  final markerJungrang = NMarker(id: 'jungrang', position: NLatLng(37.5978,127.0929));
                  markerJungrang
                  ..setMinZoom(7.5)
                  ..setMaxZoom(10)
                  ..setIsMinZoomInclusive(true)
                  ..setIsMaxZoomInclusive(true);
                  /*markerJungrang.setMinZoom(8);
                  markerJungrang.setMaxZoom(10);
                  markerJungrang.setIsMaxZoomInclusive(true);
                  markerJungrang.setIsMinZoomInclusive(true);*/
                  final markerDongdaemun = NMarker(id: 'Dongdaemun', position: NLatLng(37.5820,127.0548));
                  final markerSeongbuk = NMarker(id: 'Seongbuk', position: NLatLng(37.6057,127.0176));
                  final markerJongno = NMarker(id: 'Jongno', position: NLatLng(37.5949,126.9773));
                  final markerSeodaemun = NMarker(id: 'Seodaemun', position: NLatLng(37.5778,126.9391));
                  controller.addOverlay(markerJungrang);
                  //controller.addOverlayAll({markerJungrang, markerSeodaemun, markerDongdaemun, markerSeongbuk, markerJongno});

                  setState(() {
                    final onMarkerInfoWindowJungrang = NInfoWindow.onMarker(id: markerJungrang.info.id, text: '중랑구 ${temp[0]} °C');
                    final onMarkerInfoWindowDongdaemun = NInfoWindow.onMarker(id: markerDongdaemun.info.id, text: '동대문구 ${temp[1]} °C');
                    final onMarkerInfoWindowSeongbuk = NInfoWindow.onMarker(id: markerSeongbuk.info.id, text: '성북구 ${temp[2]} °C');
                    final onMarkerInfoWindowJongno = NInfoWindow.onMarker(id: markerJongno.info.id, text: '종로구 ${temp[3]} °C');
                    final onMarkerInfoWindowSeodaemun = NInfoWindow.onMarker(id: markerSeodaemun.info.id, text: '서대문구 ${temp[4]} °C');
                    markerJungrang.openInfoWindow(onMarkerInfoWindowJungrang);
                    //markerDongdaemun.openInfoWindow(onMarkerInfoWindowDongdaemun);
                    //markerSeongbuk.openInfoWindow(onMarkerInfoWindowSeongbuk);
                    //markerJongno.openInfoWindow(onMarkerInfoWindowJongno);
                    //markerSeodaemun.openInfoWindow(onMarkerInfoWindowSeodaemun);
                  });

                  final locationOverlay = await controller.getLocationOverlay();
                  locationOverlay.setIsVisible(true);

                  mapControllerCompleter.complete(controller);  // Completer에 지도 컨트롤러 완료 신호 전송\
                  log("onMapReady", name: "onMapReady");
                },
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Color(0xA9C0FFFF),
            child: Container(
              /*decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Colors.blue,
                        Color(0xC1E6F3FF),
                      ]
                  )
              ),*/
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
            ),
          ),
        ),
      ),
    );
  }
}