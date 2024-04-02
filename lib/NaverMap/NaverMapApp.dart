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
  List<String> cityName = [];
  List<double> temp = [];
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
    updateData(widget.parseWeatherData);
  }

  void updateData(List<dynamic> weatherData) {
    /*temp = weatherData[0]['main']['temp'];
    cityName = weatherData[0]['name'];*/

    for (int i = 0; i < weatherData.length; i++) {
      double temp2 = weatherData[i]['main']['temp'].toDouble();
      String cityName2 = weatherData[i]['name'];

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
      canPop: true,
      onPopInvoked: (bool didPop) {
        //didPop == true , 뒤로가기 제스쳐가 감지되면 호출 된다.
        if (didPop) {
          print('didPop호출');
          return;
        }
        _showBackDialog();
      },
      child: Center(
        child: Scaffold(
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
          bottomNavigationBar: BottomAppBar(
            child: TextButton(
              child: Text("뒤로가기"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: NaverMap(
            onMapTapped: (point, latLng) {
              print(latLng);
            },
            options: const NaverMapViewOptions(
              initialCameraPosition: NCameraPosition(
                  target: NLatLng(36.76446613297395, 128.0022937962076),
                  zoom: 6.5),
              indoorEnable: true,
              // 실내 맵 사용 가능 여부 설정
              locationButtonEnable: true,
              //  위치 버튼 표시 여부 설정
              consumeSymbolTapEvents: false,
              // 심볼 탭 이벤트 소비 여부 설정
              extent: NLatLngBounds(
                southWest: NLatLng(31.43, 122.37),
                northEast: NLatLng(44.35, 132.0),
              ),
              minZoom: 6,
              maxZoom: 13,
              tiltGesturesEnable: false,
              rotationGesturesEnable: false,
            ),
            onMapReady: (controller) async {
              // 지도 준비 완료 시 호출되는 콜백 함수

              // 한성대학교
              final hansungLogo =
                  NOverlayImage.fromAssetImage('assets/hansung.png');
              final markerHansung = NMarker(
                  id: 'hansung',
                  position: NLatLng(37.5828, 127.0106),
                  icon: hansungLogo); // 한성대학교
              controller.addOverlay(markerHansung);

              //서울 시내
              final markerGangnam = NMarker(
                  id: 'gangnam', position: NLatLng(37.4967, 127.0630)) // 강남
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true);
              final markerGangdong = NMarker(
                  id: 'gangdong', position: NLatLng(37.5504, 127.1470)) // 강동
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true);
              final markerGangbuk = NMarker(
                  id: 'gangbuk', position: NLatLng(37.6435, 127.0112)) // 강북
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true);
              final markerGangseo = NMarker(
                  id: 'gangseo', position: NLatLng(37.5612, 126.8228)) // 강서
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true);
              final markerGwanak = NMarker(
                  id: 'gwanak', position: NLatLng(37.4674, 126.9453)) // 관악
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true);
              final markerGwangjin = NMarker(
                  id: 'gwangjin', position: NLatLng(37.5467, 127.0858)) // 광진
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true);
              final markerGuro = NMarker(
                  id: 'guro', position: NLatLng(37.4944, 126.8563)) // 구로
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true);
              final markerGeumcheon = NMarker(
                  id: 'geumcheon', position: NLatLng(37.4606, 126.9008)) // 금천
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true);
              final markerNowon = NMarker(
                  id: 'Nowon', position: NLatLng(37.6525, 127.0750)) // 노원
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true);
              final markerDobong = NMarker(
                  id: 'dobong', position: NLatLng(37.6691, 127.0324)) // 도봉
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true);
              final markerDongdaemun = NMarker(
                  id: 'dongdaemun', position: NLatLng(37.5820, 127.0548)) // 동대문
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true);
              final markerDongjak = NMarker(
                  id: 'dongjak', position: NLatLng(37.4989, 126.9516)) // 동작
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true);
              final markerMapo = NMarker(
                  id: 'mapo', position: NLatLng(37.5593, 126.9083)) // 마포
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true);
              final markerSeodaemun = NMarker(
                  id: 'seodaemun', position: NLatLng(37.5778, 126.9391)) // 서대문
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true);
              final markerSeocho = NMarker(
                  id: 'seocho', position: NLatLng(37.4733, 127.0312)) // 서초
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true);
              final markerSeongdong = NMarker(
                  id: 'seongdong', position: NLatLng(37.5510, 127.0410)) // 성동
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true);
              final markerSeongbuk = NMarker(
                  id: 'seongbuk', position: NLatLng(37.6057, 127.0176)) // 성북
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true);
              final markerSongpa = NMarker(
                  id: 'songpa', position: NLatLng(37.5056, 127.1153)) // 송파
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true);
              final markerYangcheon = NMarker(
                  id: 'yangcheon', position: NLatLng(37.5247, 126.8554)) // 양천
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true);
              final markerYeongdeungpo = NMarker(
                  id: 'yeongdeungpo',
                  position: NLatLng(37.5223, 126.9102)) // 영등포
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true);
              final markerYongsan = NMarker(
                  id: 'yongsan', position: NLatLng(37.5314, 126.9799)) // 용산
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true);
              final markerEunpyeong = NMarker(
                  id: 'eunpyeong', position: NLatLng(37.6192, 126.9270)) // 은평
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true);
              final markerJongno = NMarker(
                  id: 'jongno', position: NLatLng(37.5949, 126.9773)) // 종로
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true);
              final markerJung = NMarker(
                  id: 'jung', position: NLatLng(37.5601, 126.9960)) // 중구
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true);
              final markerJungrang = NMarker(
                  id: 'jungrang', position: NLatLng(37.5978, 127.0929)) // 중랑
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true);
              // 광역시
              final markerSeoul = NMarker(
                  id: 'seoul', position: NLatLng(37.5519, 126.9918)) // 서울
                ..setMinZoom(6)
                ..setMaxZoom(10);
              final markerBusan = NMarker(
                  id: 'busan', position: NLatLng(35.2100, 129.0689)) // 부산
                ..setMinZoom(6)
                ..setMaxZoom(10);
              final markerGwangju = NMarker(
                  id: 'gwangju', position: NLatLng(35.1557, 126.8354)) // 광주
                ..setMinZoom(6)
                ..setMaxZoom(10);
              final markerIncheon = NMarker(
                  id: 'incheon', position: NLatLng(37.4563, 126.7052)) // 인천
                ..setMinZoom(8);
              //..setMaxZoom(10);
              final markerUlsan = NMarker(
                  id: 'ulsan', position: NLatLng(35.5537, 129.2381)) // 울산
                ..setMinZoom(6)
                ..setMaxZoom(10);
              final markerDaejeon = NMarker(
                  id: 'daejeon', position: NLatLng(36.3398, 127.3940)) // 대전
                ..setMinZoom(6)
                ..setMaxZoom(10);
              final markerDaegu = NMarker(
                  id: 'Daegu', position: NLatLng(35.8294, 128.5655)) // 대구
                ..setMinZoom(6)
                ..setMaxZoom(10);
              // 시
              final markerGangneung = NMarker(
                  id: 'gangneung', position: NLatLng(37.7091, 128.8324)) // 강릉
                ..setMinZoom(6)
                ..setMaxZoom(10);
              final markerChungju = NMarker(
                  id: 'chungju', position: NLatLng(37.0151, 127.8957)) // 충주
                ..setMinZoom(6)
                ..setMaxZoom(10);
              final markerChuncheon = NMarker(
                  id: 'chuncheon', position: NLatLng(37.8898, 127.7399)) // 춘천
                ..setMinZoom(6)
                ..setMaxZoom(10);
              final markerSokcho = NMarker(
                  id: 'sokcho', position: NLatLng(38.1760, 128.5195)) // 속초
                ..setMinZoom(6)
                ..setMaxZoom(10);
              final markerJeonju = NMarker(
                  id: 'jeonju', position: NLatLng(35.8280, 127.1160)) // 전주
                ..setMinZoom(6)
                ..setMaxZoom(10);
              final markerYeosu = NMarker(
                  id: 'yeosu', position: NLatLng(34.7604, 127.6622)) // 여수
                ..setMinZoom(6)
                ..setMaxZoom(10);
              final markerTaebaek = NMarker(
                  id: 'teabaek', position: NLatLng(37.1723, 128.9800)) // 태백
                ..setMinZoom(6)
                ..setMaxZoom(10);
              final markerPohang = NMarker(
                  id: 'pohang', position: NLatLng(36.0929, 129.3053)) // 포항
                ..setMinZoom(6)
                ..setMaxZoom(10);
              final markerAndong = NMarker(
                  id: 'andong', position: NLatLng(36.5802, 128.7800)) // 안동
                ..setMinZoom(6)
                ..setMaxZoom(10);
              final markerGimcheon = NMarker(
                  id: 'gimcheon', position: NLatLng(36.0604, 128.0777)) // 김천
                ..setMinZoom(6)
                ..setMaxZoom(10);
              final markerPyeongtaek = NMarker(
                  id: 'pyeongtaek', position: NLatLng(37.0160, 126.9942)) // 평택
                ..setMinZoom(6)
                ..setMaxZoom(10);
              final markerSeongnam = NMarker(
                  id: 'seongnam', position: NLatLng(37.4074, 127.1162)); // 성남
              final markerGwangmyeong = NMarker(
                  id: 'gwangmyeong',
                  position: NLatLng(37.4452, 126.8647)); // 광명
              final markerSuwon = NMarker(
                  id: 'suwon', position: NLatLng(37.2804, 127.0078)); // 수원
              final markerHanam = NMarker(
                  id: 'hanam', position: NLatLng(37.5229, 127.2060)); // 하남
              controller.addOverlayAll({
                markerGangnam,
                markerGangdong,
                markerGangbuk,
                markerGangseo,
                markerGwanak,
                markerGwangjin,
                markerGuro,
                markerGeumcheon,
                markerNowon,
                markerDobong,
                markerDongdaemun,
                markerDongjak,
                markerMapo,
                markerSeodaemun,
                markerSeocho,
                markerSeongdong,
                markerSeongbuk,
                markerSongpa,
                markerYangcheon,
                markerYangcheon,
                markerYeongdeungpo,
                markerYongsan,
                markerEunpyeong,
                markerJongno,
                markerJung,
                markerJungrang
              });
              controller.addOverlayAll({
                markerSeoul,
                markerBusan,
                markerGwangju,
                markerIncheon,
                markerUlsan,
                markerDaejeon,
                markerDaegu
              }); // 광역시 마커 추가
              controller.addOverlayAll({
                markerGangneung,
                markerChungju,
                markerChuncheon,
                markerSokcho,
                markerJeonju,
                markerYeosu,
                markerTaebaek,
                markerPohang,
                markerAndong,
                markerGimcheon,
                markerPyeongtaek
              });
              //controller.addOverlayAll({markerSeoul, markerSeongnam, markerGwangmyeong, markerIncheon, markerSuwon, markerHanam});

              setState(() {
                // 서울 25개 구
                final onMarkerInfoWindowGangnam = NInfoWindow.onMarker(
                    id: markerGangnam.info.id, text: '강남구 ${temp[0]} °C');
                final onMarkerInfoWindowGangdong = NInfoWindow.onMarker(
                    id: markerGangdong.info.id, text: '강동구 ${temp[1]} °C');
                final onMarkerInfoWindowGangbuk = NInfoWindow.onMarker(
                    id: markerGangbuk.info.id, text: '강북구 ${temp[2]} °C');
                final onMarkerInfoWindowGangseo = NInfoWindow.onMarker(
                    id: markerGangseo.info.id, text: '강서구 ${temp[3]} °C');
                final onMarkerInfoWindowGwanak = NInfoWindow.onMarker(
                    id: markerGwanak.info.id, text: '관악구 ${temp[4]} °C');
                final onMarkerInfoWindowGwangjin = NInfoWindow.onMarker(
                    id: markerGwangjin.info.id, text: '광진구 ${temp[5]} °C');
                final onMarkerInfoWindowGuro = NInfoWindow.onMarker(
                    id: markerGuro.info.id, text: '구로구 ${temp[6]} °C');
                final onMarkerInfoWindowGeumcheon = NInfoWindow.onMarker(
                    id: markerGeumcheon.info.id, text: '금천구 ${temp[7]} °C');
                final onMarkerInfoWindowNowon = NInfoWindow.onMarker(
                    id: markerNowon.info.id, text: '노원구 ${temp[8]} °C');
                final onMarkerInfoWindowDobong = NInfoWindow.onMarker(
                    id: markerDobong.info.id, text: '도봉구 ${temp[9]} °C');
                final onMarkerInfoWindowDongdaemun = NInfoWindow.onMarker(
                    id: markerDongdaemun.info.id, text: '동대문구 ${temp[10]} °C');
                final onMarkerInfoWindowDongjak = NInfoWindow.onMarker(
                    id: markerDongjak.info.id, text: '동작구 ${temp[11]} °C');
                final onMarkerInfoWindowMapo = NInfoWindow.onMarker(
                    id: markerMapo.info.id, text: '마포구 ${temp[12]} °C');
                final onMarkerInfoWindowSeodaemun = NInfoWindow.onMarker(
                    id: markerSeodaemun.info.id, text: '서대문구 ${temp[13]} °C');
                final onMarkerInfoWindowSeocho = NInfoWindow.onMarker(
                    id: markerSeocho.info.id, text: '서초구 ${temp[14]} °C');
                final onMarkerInfoWindowSeongdong = NInfoWindow.onMarker(
                    id: markerSeongdong.info.id, text: '성동구 ${temp[15]} °C');
                final onMarkerInfoWindowSeongbuk = NInfoWindow.onMarker(
                    id: markerSeongbuk.info.id, text: '성북구 ${temp[16]} °C');
                final onMarkerInfoWindowSongpa = NInfoWindow.onMarker(
                    id: markerSongpa.info.id, text: '송파구 ${temp[17]} °C');
                final onMarkerInfoWindowYangcheon = NInfoWindow.onMarker(
                    id: markerYangcheon.info.id, text: '양천구 ${temp[18]} °C');
                final onMarkerInfoWindowYeongdeungpo = NInfoWindow.onMarker(
                    id: markerYeongdeungpo.info.id,
                    text: '영등포구 ${temp[19]} °C');
                final onMarkerInfoWindowYongsan = NInfoWindow.onMarker(
                    id: markerYongsan.info.id, text: '용산구 ${temp[20]} °C');
                final onMarkerInfoWindowEunpyeong = NInfoWindow.onMarker(
                    id: markerEunpyeong.info.id, text: '은평구 ${temp[21]} °C');
                final onMarkerInfoWindowJongno = NInfoWindow.onMarker(
                    id: markerJongno.info.id, text: '종로구 ${temp[22]} °C');
                final onMarkerInfoWindowJung = NInfoWindow.onMarker(
                    id: markerJung.info.id, text: '중구 ${temp[23]} °C');
                final onMarkerInfoWindowJungrang = NInfoWindow.onMarker(
                    id: markerJungrang.info.id, text: '중랑구 ${temp[24]} °C');

                // 광역시 설명 추가
                final onMarkerInfoWindowSeoul = NInfoWindow.onMarker(
                    id: markerSeoul.info.id, text: '서울특별시 ${temp[25]} °C');
                final onMarkerInfoWindowBusan = NInfoWindow.onMarker(
                    id: markerBusan.info.id, text: '부산광역시 ${temp[26]} °C');
                final onMarkerInfoWindowGwangju = NInfoWindow.onMarker(
                    id: markerGwangju.info.id, text: '광주광역시 ${temp[27]} °C');
                final onMarkerInfoWindowIncheon = NInfoWindow.onMarker(
                    id: markerIncheon.info.id, text: '인천광역시 ${temp[28]} °C');
                final onMarkerInfoWindowUlsan = NInfoWindow.onMarker(
                    id: markerUlsan.info.id, text: '울산광역시 ${temp[29]} °C');
                final onMarkerInfoWindowDaejeon = NInfoWindow.onMarker(
                    id: markerDaejeon.info.id, text: '대전광역시 ${temp[30]} °C');
                final onMarkerInfoWindowDaegu = NInfoWindow.onMarker(
                    id: markerDaegu.info.id, text: '대구광역시 ${temp[31]} °C');
                //시 설명 추가
                final onMarkerInfoWindowGangneung = NInfoWindow.onMarker(
                    id: markerGangneung.info.id, text: '강릉시 ${temp[32]} °C');
                final onMarkerInfoWindowChungju = NInfoWindow.onMarker(
                    id: markerChungju.info.id, text: '충주시 ${temp[33]} °C');
                final onMarkerInfoWindowChuncheon = NInfoWindow.onMarker(
                    id: markerChuncheon.info.id, text: '춘천시 ${temp[34]} °C');
                final onMarkerInfoWindowSokcho = NInfoWindow.onMarker(
                    id: markerSokcho.info.id, text: '속초시 ${temp[35]} °C');
                final onMarkerInfoWindowJeonju = NInfoWindow.onMarker(
                    id: markerJeonju.info.id, text: '전주시 ${temp[36]} °C');
                final onMarkerInfoWindowYeosu = NInfoWindow.onMarker(
                    id: markerYeosu.info.id, text: '여수시 ${temp[37]} °C');
                final onMarkerInfoWindowTaebaek = NInfoWindow.onMarker(
                    id: markerTaebaek.info.id, text: '태백시 ${temp[38]} °C');
                final onMarkerInfoWindowPohang = NInfoWindow.onMarker(
                    id: markerPohang.info.id, text: '포항시 ${temp[39]} °C');
                final onMarkerInfoWindowAndong = NInfoWindow.onMarker(
                    id: markerAndong.info.id, text: '안동시 ${temp[40]} °C');
                final onMarkerInfoWindowGimcheon = NInfoWindow.onMarker(
                    id: markerGimcheon.info.id, text: '김천시 ${temp[41]} °C');
                final onMarkerInfoWindowPyeongtaek = NInfoWindow.onMarker(
                    id: markerPyeongtaek.info.id, text: '평택시 ${temp[42]} °C');

                markerGangnam.openInfoWindow(onMarkerInfoWindowGangnam);
                markerGangdong.openInfoWindow(onMarkerInfoWindowGangdong); // 강동
                markerGangbuk.openInfoWindow(onMarkerInfoWindowGangbuk); // 강북
                markerGangseo.openInfoWindow(onMarkerInfoWindowGangseo); // 강서
                markerGwanak.openInfoWindow(onMarkerInfoWindowGwanak); // 관악
                markerGwangjin.openInfoWindow(onMarkerInfoWindowGwangjin); // 광진
                markerGuro.openInfoWindow(onMarkerInfoWindowGuro); // 구로
                markerGeumcheon
                    .openInfoWindow(onMarkerInfoWindowGeumcheon); // 금천
                markerNowon.openInfoWindow(onMarkerInfoWindowNowon); // 노원
                markerDobong.openInfoWindow(onMarkerInfoWindowDobong); // 도봉
                markerDongdaemun
                    .openInfoWindow(onMarkerInfoWindowDongdaemun); // 동대문
                markerDongjak.openInfoWindow(onMarkerInfoWindowDongjak); // 동작
                markerMapo.openInfoWindow(onMarkerInfoWindowMapo); // 마포
                markerSeodaemun
                    .openInfoWindow(onMarkerInfoWindowSeodaemun); // 서대문
                markerSeocho.openInfoWindow(onMarkerInfoWindowSeocho); // 서초
                markerSeongdong
                    .openInfoWindow(onMarkerInfoWindowSeongdong); // 성동
                markerSeongbuk.openInfoWindow(onMarkerInfoWindowSeongbuk); // 성북
                markerSongpa.openInfoWindow(onMarkerInfoWindowSongpa); // 송파
                markerYangcheon
                    .openInfoWindow(onMarkerInfoWindowYangcheon); // 양천
                markerYeongdeungpo
                    .openInfoWindow(onMarkerInfoWindowYeongdeungpo); // 영등포
                markerYongsan.openInfoWindow(onMarkerInfoWindowYongsan); // 용산
                markerEunpyeong
                    .openInfoWindow(onMarkerInfoWindowEunpyeong); // 은평
                markerJongno.openInfoWindow(onMarkerInfoWindowJongno); // 종로
                markerJung.openInfoWindow(onMarkerInfoWindowJung); // 중구
                markerJungrang
                    .openInfoWindow(onMarkerInfoWindowJungrang); // 중랑구

                markerSeoul.openInfoWindow(onMarkerInfoWindowSeoul); // 서울
                markerBusan.openInfoWindow(onMarkerInfoWindowBusan); // 부산
                markerGwangju.openInfoWindow(onMarkerInfoWindowGwangju); // 광주
                markerIncheon.openInfoWindow(onMarkerInfoWindowIncheon); // 인천
                markerUlsan.openInfoWindow(onMarkerInfoWindowUlsan); // 울산
                markerDaejeon.openInfoWindow(onMarkerInfoWindowDaejeon); // 대전
                markerDaegu.openInfoWindow(onMarkerInfoWindowDaegu); // 대구

                markerGangneung
                    .openInfoWindow(onMarkerInfoWindowGangneung); // 강릉
                markerChungju.openInfoWindow(onMarkerInfoWindowChungju); // 청주
                markerChuncheon
                    .openInfoWindow(onMarkerInfoWindowChuncheon); // 춘천
                markerSokcho.openInfoWindow(onMarkerInfoWindowSokcho); // 속초
                markerJeonju.openInfoWindow(onMarkerInfoWindowJeonju); // 전주
                markerYeosu.openInfoWindow(onMarkerInfoWindowYeosu); // 여수
                markerTaebaek.openInfoWindow(onMarkerInfoWindowTaebaek); // 태백
                markerPohang.openInfoWindow(onMarkerInfoWindowPohang); // 포항
                markerAndong.openInfoWindow(onMarkerInfoWindowAndong); // 안동
                markerGimcheon.openInfoWindow(onMarkerInfoWindowGimcheon); // 김천
                markerPyeongtaek
                    .openInfoWindow(onMarkerInfoWindowPyeongtaek); // 평택
              });

              final locationOverlay = await controller.getLocationOverlay();
              locationOverlay.setIsVisible(true);

              mapControllerCompleter
                  .complete(controller); // Completer에 지도 컨트롤러 완료 신호 전송\
              log("onMapReady", name: "onMapReady");
            },
          ),
        ),
      ),
    );
  }
}
