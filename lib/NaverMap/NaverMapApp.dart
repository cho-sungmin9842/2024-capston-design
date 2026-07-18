
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hansungcapstone_bugiweather/NaverMap/font.dart';
import 'package:hansungcapstone_bugiweather/NaverMap/screens/weatherIcon.dart';
import 'package:http/http.dart';
final apiKey = dotenv.get("openweather_api_key");

class NaverMapApp extends StatefulWidget {
  const NaverMapApp({Key? key, required this.parseWeatherData});
  final List<dynamic> parseWeatherData;
  @override
  State<NaverMapApp> createState() => _NaverMapAppState();
}
class _NaverMapAppState extends State<NaverMapApp> {
  List<String> cityNameList=[];
  List<double> tempList=[];
  List<double> feelsLikeList=[];
  List<double> humidityList=[];
  List<double> minTempList=[];
  List<double> maxTempList=[];
  List<String> conditionList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateData(widget.parseWeatherData);
  }
  void updateData(List<dynamic> weatherData) {
    /*temp = weatherData[0]['main']['temp'];
    cityName = weatherData[0]['name'];*/

    for(int i=0; i<weatherData.length; i++) {
      double temp=weatherData[i]['current']['temp'].toDouble();
      //String cityName=weatherData[i]['name'];
      double feelsLike=weatherData[i]['current']['feels_like'].toDouble();
      double humidity=weatherData[i]['current']['humidity'].toDouble();
      double minTemp=weatherData[i]['daily'][0]['temp']['min'].toDouble();
      double maxTemp=weatherData[i]['daily'][0]['temp']['max'].toDouble();
      String condition=weatherData[i]['current']['weather'][0]['main'];

      tempList.add(temp);
      //cityNameList.add(cityName);
      feelsLikeList.add(feelsLike);
      humidityList.add(humidity);
      minTempList.add(minTemp);
      maxTempList.add(maxTemp);
      conditionList.add(condition);
      //print(temp);
      //print(condition);
      //print(temp2);
    }
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
      },
      child: Center(
        child: Scaffold(
          appBar: AppBar(
            title: Text("전국 날씨", style: TitleStyle(),),
            elevation: 4,
            centerTitle: true,
            automaticallyImplyLeading: false,
            flexibleSpace: new Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Color(0xffbfd5ff),
                    Color(0xff74d5ff),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: TextButton(
              child: Text("뒤로가기", style: SubStyle(),),
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
              initialCameraPosition: NCameraPosition(target: NLatLng(36.76446613297395, 128.0022937962076), zoom:6.5),
              indoorEnable: true,             // 실내 맵 사용 가능 여부 설정
              locationButtonEnable: true,   //  위치 버튼 표시 여부 설정
              consumeSymbolTapEvents: false,  // 심볼 탭 이벤트 소비 여부 설정
              extent: NLatLngBounds(
                southWest: NLatLng(31.43, 122.37),
                northEast: NLatLng(44.35, 132.0),
              ),
              minZoom: 6,
              maxZoom: 13,
              tiltGesturesEnable: false,
              rotationGesturesEnable: false,
            ),
            onMapReady: (controller) async {                // 지도 준비 완료 시 호출되는 콜백 함수

              // 한성대학교
              final hansungLogo = await NOverlayImage.fromAssetImage("assets/boogiepin.png");
              final markerHansung = NMarker(id: 'hansung', position: NLatLng(37.5828, 127.0106), icon: hansungLogo) // 한성대학교
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "한성대학교", temp: tempList[43], feelsLike: feelsLikeList[43], humidity: humidityList[43],
                        minTemp: minTempList[43], maxTemp: maxTempList[43], condition: conditionList[43] )
                );
              controller.addOverlay(markerHansung);

              //서울 시내
              final logoGangnam = getImage(conditionList[0]);
              final markerGangnam = NMarker(id: 'gangnam', position: NLatLng(37.4967, 127.0630), icon: logoGangnam) // 강남
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "강남구", temp: tempList[0], feelsLike: feelsLikeList[0], humidity: humidityList[0],
                        minTemp: minTempList[0], maxTemp: maxTempList[0], condition: conditionList[0] )
                );
              final logoGangdong = getImage(conditionList[1]);
              final markerGangdong = NMarker(id: 'gangdong', position: NLatLng(37.5504, 127.1470), icon: logoGangdong) // 강동
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "강동구", temp: tempList[1], feelsLike: feelsLikeList[1], humidity: humidityList[1],
                        minTemp: minTempList[1], maxTemp: maxTempList[1], condition: conditionList[1] )
                );
              final logoGangbuk = getImage(conditionList[2]);
              final markerGangbuk = NMarker(id: 'gangbuk', position: NLatLng(37.6435, 127.0112), icon: logoGangbuk) // 강북
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "강북구", temp: tempList[2], feelsLike: feelsLikeList[2], humidity: humidityList[2],
                        minTemp: minTempList[2], maxTemp: maxTempList[2], condition: conditionList[2] )
                );
              final logoGangseo = getImage(conditionList[3]);
              final markerGangseo = NMarker(id: 'gangseo', position: NLatLng(37.5612, 126.8228), icon: logoGangseo) // 강서
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "강서구", temp: tempList[3], feelsLike: feelsLikeList[3], humidity: humidityList[3],
                        minTemp: minTempList[3], maxTemp: maxTempList[3], condition: conditionList[3] )
                );
              final logoGwanak = getImage(conditionList[4]);
              final markerGwanak = NMarker(id: 'gwanak', position: NLatLng(37.4674, 126.9453), icon: logoGwanak) // 관악
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "관악구", temp: tempList[4], feelsLike: feelsLikeList[4], humidity: humidityList[4],
                        minTemp: minTempList[4], maxTemp: maxTempList[4], condition: conditionList[4] )
                );
              final logoGwangjin = getImage(conditionList[5]);
              final markerGwangjin = NMarker(id: 'gwangjin', position: NLatLng(37.5467, 127.0858), icon: logoGwangjin) // 광진
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "광진구", temp: tempList[5], feelsLike: feelsLikeList[5], humidity: humidityList[5],
                        minTemp: minTempList[5], maxTemp: maxTempList[5], condition: conditionList[5] )
                );
              final logoGuro = getImage(conditionList[6]);
              final markerGuro = NMarker(id: 'guro', position: NLatLng(37.4944, 126.8563), icon:logoGuro) // 구로
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "구로구", temp: tempList[6], feelsLike: feelsLikeList[6], humidity: humidityList[6],
                        minTemp: minTempList[6], maxTemp: maxTempList[6], condition: conditionList[6] )
                );
              final logoGeumchoen = getImage(conditionList[7]);
              final markerGeumcheon = NMarker(id: 'geumcheon', position: NLatLng(37.4606, 126.9008), icon: logoGeumchoen) // 금천
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "금천구", temp: tempList[7], feelsLike: feelsLikeList[7], humidity: humidityList[7],
                        minTemp: minTempList[7], maxTemp: maxTempList[7], condition: conditionList[7] )
                );
              final logoNowon = getImage(conditionList[8]);
              final markerNowon = NMarker(id: 'Nowon', position: NLatLng(37.6525, 127.0750), icon: logoNowon) // 노원
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true)..setOnTapListener((overlay) =>
                    myBottom(cityName: "노원구", temp: tempList[8], feelsLike: feelsLikeList[8], humidity: humidityList[8],
                        minTemp: minTempList[8], maxTemp: maxTempList[8], condition: conditionList[8] )
                );
              final logoDobong = getImage(conditionList[9]);
              final markerDobong = NMarker(id: 'dobong', position: NLatLng(37.6691, 127.0324), icon: logoDobong) // 도봉
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "도봉구", temp: tempList[9], feelsLike: feelsLikeList[9], humidity: humidityList[9],
                        minTemp: minTempList[9], maxTemp: maxTempList[9], condition: conditionList[9] )
                );
              final logoDongdaemun = getImage(conditionList[10]);
              final markerDongdaemun = NMarker(id: 'dongdaemun', position: NLatLng(37.5820, 127.0548), icon: logoDongdaemun) // 동대문
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "동대문구", temp: tempList[10], feelsLike: feelsLikeList[10], humidity: humidityList[10],
                        minTemp: minTempList[10], maxTemp: maxTempList[10], condition: conditionList[10] )
                );
              final logoDongjak = getImage(conditionList[11]);
              final markerDongjak = NMarker(id: 'dongjak', position: NLatLng(37.4989, 126.9516), icon: logoDongjak) // 동작
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "동작구", temp: tempList[11], feelsLike: feelsLikeList[11], humidity: humidityList[11],
                        minTemp: minTempList[11], maxTemp: maxTempList[11], condition: conditionList[11] )
                );
              final logoMapo = getImage(conditionList[12]);
              final markerMapo = NMarker(id: 'mapo', position: NLatLng(37.5593, 126.9083), icon:logoMapo) // 마포
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "마포구", temp: tempList[12], feelsLike: feelsLikeList[12], humidity: humidityList[12],
                        minTemp: minTempList[12], maxTemp: maxTempList[12], condition: conditionList[12] )
                );
              final logoSeodaemun = getImage(conditionList[13]);
              final markerSeodaemun = NMarker(id: 'seodaemun', position: NLatLng(37.5778, 126.9391), icon: logoSeodaemun) // 서대문
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "서대문구", temp: tempList[13], feelsLike: feelsLikeList[13], humidity: humidityList[13],
                        minTemp: minTempList[13], maxTemp: maxTempList[13], condition: conditionList[13] )
                );
              final logoSeocho = getImage(conditionList[14]);
              final markerSeocho = NMarker(id: 'seocho', position: NLatLng(37.4733, 127.0312), icon: logoSeocho) // 서초
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "서초구", temp: tempList[14], feelsLike: feelsLikeList[14], humidity: humidityList[14],
                        minTemp: minTempList[14], maxTemp: maxTempList[14], condition: conditionList[14] )
                );
              final logoSeongdong = getImage(conditionList[15]);
              final markerSeongdong = NMarker(id: 'seongdong', position: NLatLng(37.5510, 127.0410), icon: logoSeongdong) // 성동
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "성동구", temp: tempList[15], feelsLike: feelsLikeList[15], humidity: humidityList[15],
                        minTemp: minTempList[15], maxTemp: maxTempList[15], condition: conditionList[15] )
                );
              final logoSeongbuk = getImage(conditionList[16]);
              final markerSeongbuk = NMarker(id: 'seongbuk', position: NLatLng(37.6057, 127.0176), icon: logoSeongbuk) // 성북
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "성북구", temp: tempList[16], feelsLike: feelsLikeList[16], humidity: humidityList[16],
                        minTemp: minTempList[16], maxTemp: maxTempList[16], condition: conditionList[16] )
                );
              final logoSongpa =getImage(conditionList[17]);
              final markerSongpa = NMarker(id: 'songpa', position: NLatLng(37.5056, 127.1153), icon: logoSongpa) // 송파
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "송파구", temp: tempList[17], feelsLike: feelsLikeList[17], humidity: humidityList[17],
                        minTemp: minTempList[17], maxTemp: maxTempList[17], condition: conditionList[17] )
                );
              final logoYangcheon = getImage(conditionList[18]);
              final markerYangcheon = NMarker(id: 'yangcheon', position: NLatLng(37.5247, 126.8554), icon: logoYangcheon) // 양천
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "양천구", temp: tempList[18], feelsLike: feelsLikeList[18], humidity: humidityList[18],
                        minTemp: minTempList[18], maxTemp: maxTempList[18], condition: conditionList[18] )
                );
              final logoYeongdeungpo = getImage(conditionList[19]);
              final markerYeongdeungpo = NMarker(id: 'yeongdeungpo', position: NLatLng(37.5223, 126.9102), icon: logoYeongdeungpo) // 영등포
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "영등포구", temp: tempList[19], feelsLike: feelsLikeList[19], humidity: humidityList[19],
                        minTemp: minTempList[19], maxTemp: maxTempList[19], condition: conditionList[19] )
                );
              final logoYongsan = getImage(conditionList[20]);
              final markerYongsan = NMarker(id: 'yongsan', position: NLatLng(37.5314, 126.9799), icon: logoYongsan) // 용산
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "용산구", temp: tempList[20], feelsLike: feelsLikeList[20], humidity: humidityList[20],
                        minTemp: minTempList[20], maxTemp: maxTempList[20], condition: conditionList[20] )
                );
              final logoEunpyeong = getImage(conditionList[21]);
              final markerEunpyeong = NMarker(id: 'eunpyeong', position: NLatLng(37.6192, 126.9270), icon: logoEunpyeong) // 은평
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "은평구", temp: tempList[21], feelsLike: feelsLikeList[21], humidity: humidityList[21],
                        minTemp: minTempList[21], maxTemp: maxTempList[21], condition: conditionList[21] )
                );
              final logoJongno = getImage(conditionList[22]);
              final markerJongno = NMarker(id: 'jongno', position: NLatLng(37.5949, 126.9773), icon: logoJongno) // 종로
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "종로구", temp: tempList[22], feelsLike: feelsLikeList[22], humidity: humidityList[22],
                        minTemp: minTempList[22], maxTemp: maxTempList[22], condition: conditionList[22] )
                );
              final logoJung = getImage(conditionList[23]);
              final markerJung = NMarker(id: 'jung', position: NLatLng(37.5601, 126.9960), icon:logoJung) // 중구
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "중구", temp: tempList[23], feelsLike: feelsLikeList[23], humidity: humidityList[23],
                        minTemp: minTempList[23], maxTemp: maxTempList[23], condition: conditionList[23] )
                );
              final logoJungrang = getImage(conditionList[24]);
              final markerJungrang = NMarker(id: 'jungrang', position: NLatLng(37.5978, 127.0929), icon: logoJungrang) // 중랑
                ..setMinZoom(10)
                ..setMaxZoom(13)
                ..setIsMinZoomInclusive(false)
                ..setIsMaxZoomInclusive(true)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "중랑구", temp: tempList[24], feelsLike: feelsLikeList[24], humidity: humidityList[24],
                        minTemp: minTempList[24], maxTemp: maxTempList[24], condition: conditionList[24] )
                );
              // 광역시
              final iconSeoul = getImage(conditionList[25]);
              final markerSeoul = NMarker(id: 'seoul', position: NLatLng(37.5519, 126.9918), icon: iconSeoul) // 서울
                ..setMinZoom(6)
                ..setMaxZoom(10)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "서울특별시", temp: tempList[25], feelsLike: feelsLikeList[25], humidity: humidityList[25],
                        minTemp: minTempList[25], maxTemp: maxTempList[25], condition: conditionList[25] )
                );
              final iconBusan = getImage(conditionList[26]);
              final markerBusan = NMarker(id: 'busan', position: NLatLng(35.2100,129.0689), icon: iconBusan) // 부산
                ..setMinZoom(6)
                ..setMaxZoom(10)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "부산광역시", temp: tempList[26], feelsLike: feelsLikeList[26], humidity: humidityList[26],
                        minTemp: minTempList[26], maxTemp: maxTempList[26], condition: conditionList[26] )
                );
              final iconGwangju = getImage(conditionList[27]);
              final markerGwangju = NMarker(id: 'gwangju', position: NLatLng(35.1557,126.8354), icon: iconGwangju) // 광주
                ..setMinZoom(6)
                ..setMaxZoom(10)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "광주광역시", temp: tempList[27], feelsLike: feelsLikeList[27], humidity: humidityList[27],
                        minTemp: minTempList[27], maxTemp: maxTempList[27], condition: conditionList[27] )
                );
              final iconIncheon = getImage(conditionList[28]);
              final markerIncheon = NMarker(id: 'incheon', position: NLatLng(37.4563, 126.7052), icon: iconIncheon) // 인천
                ..setMinZoom(8)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "인천광역시", temp: tempList[28], feelsLike: feelsLikeList[28], humidity: humidityList[28],
                        minTemp: minTempList[28], maxTemp: maxTempList[28], condition: conditionList[28] )
                );
              //..setMaxZoom(10);
              final iconUlsan = getImage(conditionList[29]);
              final markerUlsan = NMarker(id: 'ulsan', position: NLatLng(35.5537, 129.2381), icon: iconUlsan) // 울산
                ..setMinZoom(6)
                ..setMaxZoom(10)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "울산광역시", temp: tempList[29], feelsLike: feelsLikeList[29], humidity: humidityList[29],
                        minTemp: minTempList[29], maxTemp: maxTempList[29], condition: conditionList[29] )
                );
              final iconDeajeon = getImage(conditionList[30]);
              final markerDaejeon = NMarker(id: 'daejeon', position: NLatLng(36.3398, 127.3940), icon: iconDeajeon) // 대전
                ..setMinZoom(6)
                ..setMaxZoom(10)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "대전광역시", temp: tempList[30], feelsLike: feelsLikeList[30], humidity: humidityList[30],
                        minTemp: minTempList[30], maxTemp: maxTempList[30], condition: conditionList[30] )
                );
              final iconDeagu = getImage(conditionList[31]);
              final markerDaegu = NMarker(id: 'Daegu', position: NLatLng(35.8294, 128.5655), icon: iconDeagu) // 대구
                ..setMinZoom(6)
                ..setMaxZoom(10)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "대구광역시", temp: tempList[31], feelsLike: feelsLikeList[31], humidity: humidityList[31],
                        minTemp: minTempList[31], maxTemp: maxTempList[31], condition: conditionList[31] )
                );
              // 시
              final iconGangneung = getImage(conditionList[32]);
              final markerGangneung = NMarker(id: 'gangneung', position: NLatLng(37.7091, 128.8324), icon: iconGangneung) // 강릉
                ..setMinZoom(6)
                ..setMaxZoom(10)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "강릉시", temp: tempList[32], feelsLike: feelsLikeList[32], humidity: humidityList[32],
                        minTemp: minTempList[32], maxTemp: maxTempList[32], condition: conditionList[32] )
                );
              final iconChungju = getImage(conditionList[33]);
              final markerChungju = NMarker(id: 'chungju', position: NLatLng(37.0151, 127.8957), icon: iconChungju) // 충주
                ..setMinZoom(6)
                ..setMaxZoom(10)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "충주시", temp: tempList[33], feelsLike: feelsLikeList[33], humidity: humidityList[33],
                        minTemp: minTempList[33], maxTemp: maxTempList[33], condition: conditionList[33] )
                );
              final iconChuncheon = getImage(conditionList[34]);
              final markerChuncheon = NMarker(id: 'chuncheon', position: NLatLng(37.8898, 127.7399), icon: iconChuncheon) // 춘천
                ..setMinZoom(6)
                ..setMaxZoom(10)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "춘천시", temp: tempList[34], feelsLike: feelsLikeList[34], humidity: humidityList[34],
                        minTemp: minTempList[34], maxTemp: maxTempList[34], condition: conditionList[34] )
                );
              final iconSokcho = getImage(conditionList[35]);
              final markerSokcho = NMarker(id: 'sokcho', position: NLatLng(38.1760, 128.5195), icon: iconSokcho) // 속초
                ..setMinZoom(6)
                ..setMaxZoom(10)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "속초시", temp: tempList[35], feelsLike: feelsLikeList[35], humidity: humidityList[35],
                        minTemp: minTempList[35], maxTemp: maxTempList[35], condition: conditionList[35] )
                );
              final iconJeonju = getImage(conditionList[36]);
              final markerJeonju = NMarker(id: 'jeonju', position: NLatLng(35.8280, 127.1160), icon: iconJeonju) // 전주
                ..setMinZoom(6)
                ..setMaxZoom(10)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "전주시", temp: tempList[36], feelsLike: feelsLikeList[36], humidity: humidityList[36],
                        minTemp: minTempList[36], maxTemp: maxTempList[36], condition: conditionList[36] )
                );
              final iconYeosu = getImage(conditionList[37]);
              final markerYeosu = NMarker(id: 'yeosu', position: NLatLng(34.7604, 127.6622), icon: iconYeosu) // 여수
                ..setMinZoom(6)
                ..setMaxZoom(10)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "여수시", temp: tempList[37], feelsLike: feelsLikeList[37], humidity: humidityList[37],
                        minTemp: minTempList[37], maxTemp: maxTempList[37], condition: conditionList[37] )
                );
              final iconTaebaek = getImage(conditionList[38]);
              final markerTaebaek = NMarker(id: 'teabaek', position: NLatLng(37.1723, 128.9800), icon: iconTaebaek) // 태백
                ..setMinZoom(6)
                ..setMaxZoom(10)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "태백시", temp: tempList[38], feelsLike: feelsLikeList[38], humidity: humidityList[38],
                        minTemp: minTempList[38], maxTemp: maxTempList[38], condition: conditionList[38] )
                );
              final iconPohang = getImage(conditionList[39]);
              final markerPohang = NMarker(id: 'pohang', position: NLatLng(36.0929, 129.3053), icon: iconPohang) // 포항
                ..setMinZoom(6)
                ..setMaxZoom(10)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "포항시", temp: tempList[39], feelsLike: feelsLikeList[39], humidity: humidityList[39],
                        minTemp: minTempList[39], maxTemp: maxTempList[39], condition: conditionList[39] )
                );
              final iconAndong = getImage(conditionList[40]);
              final markerAndong = NMarker(id: 'andong', position: NLatLng(36.5802, 128.7800), icon: iconAndong) // 안동
                ..setMinZoom(6)
                ..setMaxZoom(10)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "안동시", temp: tempList[40], feelsLike: feelsLikeList[40], humidity: humidityList[40],
                        minTemp: minTempList[40], maxTemp: maxTempList[40], condition: conditionList[40] )
                );
              final iconGimcheon = getImage(conditionList[41]);
              final markerGimcheon = NMarker(id: 'gimcheon', position: NLatLng(36.0604, 128.0777), icon: iconGimcheon) // 김천
                ..setMinZoom(6)
                ..setMaxZoom(10)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "김천시", temp: tempList[41], feelsLike: feelsLikeList[41], humidity: humidityList[41],
                        minTemp: minTempList[41], maxTemp: maxTempList[41], condition: conditionList[41] )
                );
              final iconPyeongtaek = getImage(conditionList[42]);
              final markerPyeongtaek = NMarker(id: 'pyeongtaek', position: NLatLng(37.0160, 126.9942), icon: iconPyeongtaek) // 평택
                ..setMinZoom(6)
                ..setMaxZoom(10)
                ..setOnTapListener((overlay) =>
                    myBottom(cityName: "평택시", temp: tempList[42], feelsLike: feelsLikeList[42], humidity: humidityList[42],
                        minTemp: minTempList[42], maxTemp: maxTempList[42], condition: conditionList[42] )
                );
              final markerSeongnam = NMarker(id: 'seongnam', position: NLatLng(37.4074, 127.1162)); // 성남
              final markerGwangmyeong = NMarker(id: 'gwangmyeong', position: NLatLng(37.4452, 126.8647)); // 광명
              final markerSuwon = NMarker(id: 'suwon', position: NLatLng(37.2804, 127.0078)); // 수원
              final markerHanam = NMarker(id: 'hanam', position: NLatLng(37.5229, 127.2060)); // 하남
              controller.addOverlayAll({markerGangnam, markerGangdong, markerGangbuk, markerGangseo, markerGwanak, markerGwangjin, markerGuro, markerGeumcheon, markerNowon, markerDobong
                , markerDongdaemun, markerDongjak, markerMapo, markerSeodaemun, markerSeocho, markerSeongdong, markerSeongbuk, markerSongpa, markerYangcheon, markerYangcheon, markerYeongdeungpo
                , markerYongsan, markerEunpyeong, markerJongno, markerJung, markerJungrang});
              controller.addOverlayAll({markerSeoul, markerBusan, markerGwangju, markerIncheon, markerUlsan, markerDaejeon, markerDaegu}); // 광역시 마커 추가
              controller.addOverlayAll({markerGangneung, markerChungju, markerChuncheon, markerSokcho, markerJeonju, markerYeosu, markerTaebaek, markerPohang, markerAndong, markerGimcheon, markerPyeongtaek});
              //controller.addOverlayAll({markerSeoul, markerSeongnam, markerGwangmyeong, markerIncheon, markerSuwon, markerHanam});

              setState(() {
                final onMarkerInfoWindowHansung = NInfoWindow.onMarker(id: markerHansung.info.id, text: '한성대학교');
                // 서울 25개 구
                final onMarkerInfoWindowGangnam = NInfoWindow.onMarker(id: markerGangnam.info.id, text: '강남구 ${tempList[0]} °C');
                final onMarkerInfoWindowGangdong = NInfoWindow.onMarker(id: markerGangdong.info.id, text: '강동구 ${tempList[1]} °C');
                final onMarkerInfoWindowGangbuk = NInfoWindow.onMarker(id: markerGangbuk.info.id, text: '강북구 ${tempList[2]} °C');
                final onMarkerInfoWindowGangseo = NInfoWindow.onMarker(id: markerGangseo.info.id, text: '강서구 ${tempList[3]} °C');
                final onMarkerInfoWindowGwanak = NInfoWindow.onMarker(id: markerGwanak.info.id, text: '관악구 ${tempList[4]} °C');
                final onMarkerInfoWindowGwangjin = NInfoWindow.onMarker(id: markerGwangjin.info.id, text: '광진구 ${tempList[5]} °C');
                final onMarkerInfoWindowGuro = NInfoWindow.onMarker(id: markerGuro.info.id, text: '구로구 ${tempList[6]} °C');
                final onMarkerInfoWindowGeumcheon = NInfoWindow.onMarker(id: markerGeumcheon.info.id, text: '금천구 ${tempList[7]} °C');
                final onMarkerInfoWindowNowon = NInfoWindow.onMarker(id: markerNowon.info.id, text: '노원구 ${tempList[8]} °C');
                final onMarkerInfoWindowDobong = NInfoWindow.onMarker(id: markerDobong.info.id, text: '도봉구 ${tempList[9]} °C');
                final onMarkerInfoWindowDongdaemun = NInfoWindow.onMarker(id: markerDongdaemun.info.id, text: '동대문구 ${tempList[10]} °C');
                final onMarkerInfoWindowDongjak = NInfoWindow.onMarker(id: markerDongjak.info.id, text: '동작구 ${tempList[11]} °C');
                final onMarkerInfoWindowMapo= NInfoWindow.onMarker(id: markerMapo.info.id, text: '마포구 ${tempList[12]} °C');
                final onMarkerInfoWindowSeodaemun = NInfoWindow.onMarker(id: markerSeodaemun.info.id, text: '서대문구 ${tempList[13]} °C');
                final onMarkerInfoWindowSeocho = NInfoWindow.onMarker(id: markerSeocho.info.id, text: '서초구 ${tempList[14]} °C');
                final onMarkerInfoWindowSeongdong = NInfoWindow.onMarker(id: markerSeongdong.info.id, text: '성동구 ${tempList[15]} °C');
                final onMarkerInfoWindowSeongbuk = NInfoWindow.onMarker(id: markerSeongbuk.info.id, text: '성북구 ${tempList[16]} °C');
                final onMarkerInfoWindowSongpa = NInfoWindow.onMarker(id: markerSongpa.info.id, text: '송파구 ${tempList[17]} °C');
                final onMarkerInfoWindowYangcheon = NInfoWindow.onMarker(id: markerYangcheon.info.id, text: '양천구 ${tempList[18]} °C');
                final onMarkerInfoWindowYeongdeungpo = NInfoWindow.onMarker(id: markerYeongdeungpo.info.id, text: '영등포구 ${tempList[19]} °C');
                final onMarkerInfoWindowYongsan = NInfoWindow.onMarker(id: markerYongsan.info.id, text: '용산구 ${tempList[20]} °C');
                final onMarkerInfoWindowEunpyeong = NInfoWindow.onMarker(id: markerEunpyeong.info.id, text: '은평구 ${tempList[21]} °C');
                final onMarkerInfoWindowJongno = NInfoWindow.onMarker(id: markerJongno.info.id, text: '종로구 ${tempList[22]} °C');
                final onMarkerInfoWindowJung = NInfoWindow.onMarker(id: markerJung.info.id, text: '중구 ${tempList[23]} °C');
                final onMarkerInfoWindowJungrang = NInfoWindow.onMarker(id: markerJungrang.info.id, text: '중랑구 ${tempList[24]} °C');

                // 광역시 설명 추가
                final onMarkerInfoWindowSeoul = NInfoWindow.onMarker(id: markerSeoul.info.id, text: '서울');
                final onMarkerInfoWindowBusan = NInfoWindow.onMarker(id: markerBusan.info.id, text: '부산');
                final onMarkerInfoWindowGwangju = NInfoWindow.onMarker(id: markerGwangju.info.id, text: '광주');
                final onMarkerInfoWindowIncheon = NInfoWindow.onMarker(id: markerIncheon.info.id, text: '인천');
                final onMarkerInfoWindowUlsan = NInfoWindow.onMarker(id: markerUlsan.info.id, text: '울산');
                final onMarkerInfoWindowDaejeon = NInfoWindow.onMarker(id: markerDaejeon.info.id, text: '대전');
                final onMarkerInfoWindowDaegu = NInfoWindow.onMarker(id: markerDaegu.info.id, text: '대구');
                //시 설명 추가
                final onMarkerInfoWindowGangneung = NInfoWindow.onMarker(id: markerGangneung.info.id, text: '강릉');
                final onMarkerInfoWindowChungju = NInfoWindow.onMarker(id: markerChungju.info.id, text: '충주');
                final onMarkerInfoWindowChuncheon = NInfoWindow.onMarker(id: markerChuncheon.info.id, text: '춘천');
                final onMarkerInfoWindowSokcho = NInfoWindow.onMarker(id: markerSokcho.info.id, text: '속초');
                final onMarkerInfoWindowJeonju = NInfoWindow.onMarker(id: markerJeonju.info.id, text: '전주');
                final onMarkerInfoWindowYeosu = NInfoWindow.onMarker(id: markerYeosu.info.id, text: '여수');
                final onMarkerInfoWindowTaebaek = NInfoWindow.onMarker(id: markerTaebaek.info.id, text: '태백');
                final onMarkerInfoWindowPohang = NInfoWindow.onMarker(id: markerPohang.info.id, text: '포항');
                final onMarkerInfoWindowAndong = NInfoWindow.onMarker(id: markerAndong.info.id, text: '안동');
                final onMarkerInfoWindowGimcheon = NInfoWindow.onMarker(id: markerGimcheon.info.id, text: '김천');
                final onMarkerInfoWindowPyeongtaek = NInfoWindow.onMarker(id: markerPyeongtaek.info.id, text: '평택');

                markerHansung.openInfoWindow(onMarkerInfoWindowHansung); // 한성대학교

                markerGangnam.openInfoWindow(onMarkerInfoWindowGangnam); // 강남
                markerGangdong.openInfoWindow(onMarkerInfoWindowGangdong); // 강동
                markerGangbuk.openInfoWindow(onMarkerInfoWindowGangbuk); // 강북
                markerGangseo.openInfoWindow(onMarkerInfoWindowGangseo); // 강서
                markerGwanak.openInfoWindow(onMarkerInfoWindowGwanak); // 관악
                markerGwangjin.openInfoWindow(onMarkerInfoWindowGwangjin); // 광진
                markerGuro.openInfoWindow(onMarkerInfoWindowGuro); // 구로
                markerGeumcheon.openInfoWindow(onMarkerInfoWindowGeumcheon); // 금천
                markerNowon.openInfoWindow(onMarkerInfoWindowNowon); // 노원
                markerDobong.openInfoWindow(onMarkerInfoWindowDobong); // 도봉
                markerDongdaemun.openInfoWindow(onMarkerInfoWindowDongdaemun); // 동대문
                markerDongjak.openInfoWindow(onMarkerInfoWindowDongjak); // 동작
                markerMapo.openInfoWindow(onMarkerInfoWindowMapo); // 마포
                markerSeodaemun.openInfoWindow(onMarkerInfoWindowSeodaemun); // 서대문
                markerSeocho.openInfoWindow(onMarkerInfoWindowSeocho); // 서초
                markerSeongdong.openInfoWindow(onMarkerInfoWindowSeongdong); // 성동
                markerSeongbuk.openInfoWindow(onMarkerInfoWindowSeongbuk); // 성북
                markerSongpa.openInfoWindow(onMarkerInfoWindowSongpa); // 송파
                markerYangcheon.openInfoWindow(onMarkerInfoWindowYangcheon); // 양천
                markerYeongdeungpo.openInfoWindow(onMarkerInfoWindowYeongdeungpo); // 영등포
                markerYongsan.openInfoWindow(onMarkerInfoWindowYongsan); // 용산
                markerEunpyeong.openInfoWindow(onMarkerInfoWindowEunpyeong); // 은평
                markerJongno.openInfoWindow(onMarkerInfoWindowJongno); // 종로
                markerJung.openInfoWindow(onMarkerInfoWindowJung); // 중구
                markerJungrang.openInfoWindow(onMarkerInfoWindowJungrang); // 중랑구

                markerSeoul.openInfoWindow(onMarkerInfoWindowSeoul); // 서울
                markerBusan.openInfoWindow(onMarkerInfoWindowBusan); // 부산
                markerGwangju.openInfoWindow(onMarkerInfoWindowGwangju); // 광주
                markerIncheon.openInfoWindow(onMarkerInfoWindowIncheon); // 인천
                markerUlsan.openInfoWindow(onMarkerInfoWindowUlsan); // 울산
                markerDaejeon.openInfoWindow(onMarkerInfoWindowDaejeon); // 대전
                markerDaegu.openInfoWindow(onMarkerInfoWindowDaegu); // 대구

                markerGangneung.openInfoWindow(onMarkerInfoWindowGangneung); // 강릉
                markerChungju.openInfoWindow(onMarkerInfoWindowChungju); // 청주
                markerChuncheon.openInfoWindow(onMarkerInfoWindowChuncheon); // 춘천
                markerSokcho.openInfoWindow(onMarkerInfoWindowSokcho); // 속초
                markerJeonju.openInfoWindow(onMarkerInfoWindowJeonju); // 전주
                markerYeosu.openInfoWindow(onMarkerInfoWindowYeosu); // 여수
                markerTaebaek.openInfoWindow(onMarkerInfoWindowTaebaek); // 태백
                markerPohang.openInfoWindow(onMarkerInfoWindowPohang); // 포항
                markerAndong.openInfoWindow(onMarkerInfoWindowAndong); // 안동
                markerGimcheon.openInfoWindow(onMarkerInfoWindowGimcheon); // 김천
                markerPyeongtaek.openInfoWindow(onMarkerInfoWindowPyeongtaek); // 평택



              });

              /*final locationOverlay = await controller.getLocationOverlay();
              locationOverlay.setIsVisible(true);*/

              mapControllerCompleter.complete(controller);  // Completer에 지도 컨트롤러 완료 신호 전송\
              log("onMapReady", name: "onMapReady");
            },
          ),
        ),
      ),
    );
  }
  Future<void> myBottom({required String cityName,
    required double temp, required double feelsLike, required double humidity,
    required double minTemp, required double maxTemp, required String condition}) {
    DateTime dt = DateTime.now();
    print(condition);
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 330,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/'+condition+'.png'),
              //image: AssetImage('assets/haze.png'),
            ),
            gradient: LinearGradient(
              colors: [Color(0xff74d5ff), Color(0xffbfd5ff)], // 그라데이션에 사용될 색상 리스트
              begin: Alignment.topCenter, // 그라데이션 시작 위치
              end: Alignment.bottomCenter, // 그라데이션 종료 위치
            ),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20), // 위쪽 둥근 모서리 설정
            ),
          ),
          child: Material(
            //height: 300,
            //width: double.infinity,
            //margin: EdgeInsets.all(20),
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20), // 위쪽 둥근 모서리 설정
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            cityLogo(cityName),
                            //SvgPicture.asset("assets/대전광역시.svg", width: 35, height: 35,),
                            //Image.asset("assets/daejeon.png", height: 35, width: 35,),
                            Text(" " + cityName, style: TitleStyle(),),
                          ],
                        ),
                        Text("${dt.year}년 ${dt.month}월 ${dt.day}일", style: DateStyle(),),
                        Text(getWeek() + ", " + hourFormat(), style: DateStyle(),),
                        Container(
                          height: 160,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //Icon(Icons.sunny, size: 130, color: Colors.white,),
                              conditionIcon(condition),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text("${temp.round()}°", style: TempStyle(),),
                        ],
                      ),
                      Row(
                        children: [
                          Text("${minTemp.round()}°", style: MinTempStyle(),),
                          Text("/", style: SubStyle(),),
                          Text("${maxTemp.round()}°", style: MaxTempStyle(),),
                        ],
                      ),
                      Text("체감온도 : ${feelsLike.round()}°", style: SubStyle(),),
                      Row(
                        children: [
                          Icon(Icons.water_drop, color: Colors.lightBlueAccent,),
                          Text(": ${humidity.truncate()}%", style: SubStyle(),),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  String getWeek() {
    var df = DateTime.now();
    String weekDay;
    switch (df.weekday) {
      case 1 :
        return "월요일";
      case 2 :
        return "화요일";
      case 3 :
        return "수요일";
      case 4 :
        return "목요일";
      case 5 :
        return "금요일";
      case 6 :
        return "토요일";
      case 7 :
        return "일요일";
      default :
        return "요일없음";
    }
  }
  String hourFormat() {
    var df = DateTime.now();
    String period;
    int hour = df.hour;
    if (df.hour < 12)
      period = "오전";
    else {
      period = "오후";
      hour-=12;
    }
    return period + " ${hour}:${df.minute}";
  }
  Widget conditionIcon(String condition) {
    switch (condition) {
      case "Clear" :
        return ClearIcon();
      case "Clouds" :
        return CloudIcon();
      case "Rain" :
      case "Drizzle":
        return RainIcon();
    /*case "Drizzle" :
        return DrizzleIcon();*/
      case "Haze" :
      case "Mist" :
        return HazeIcon();
      default :
        return Icon(Icons.disabled_by_default);
    }
  }
  SvgPicture cityLogo(String cityName) {
    return SvgPicture.asset("assets/city/" + cityName + ".svg", height: 30, width: 30,);
  }
}


class ClearIcon extends StatelessWidget {
  const ClearIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [Colors.orangeAccent, Colors.redAccent],
        ).createShader(bounds);
      },
      child: Icon(
        shadows: [myShadow()],
        Icons.sunny,
        color: Colors.white, // 아이콘의 기본 색상을 흰색으로 설정
        size: 130, // 아이콘 크기 지정 (원하는  변경 가능)
      ),
    );
  }
}
class CloudIcon extends StatelessWidget {
  const CloudIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [Colors.blue, Colors.white70],
        ).createShader(bounds);
      },
      child: Icon(
        shadows: [
          myShadow()
        ],
        Icons.cloud,
        color: Colors.white, // 아이콘의 기본 색상을 흰색으로 설정
        size: 130, // 아이콘 크기 지정 (원하는 크기로 변경 가능)
      ),
    );
  }
}
class RainIcon extends StatelessWidget {
  const RainIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [Colors.blue, Colors.white70],
        ).createShader(bounds);
      },
      child: Icon(
        Icons.water_drop_sharp,
        color: Colors.white, // 아이콘의 기본 색상을 흰색으로 설정
        size: 130, // 아이콘 크기 지정 (원하는 크기로 변경 가능)
      ),
    );
  }
}
class HazeIcon extends StatelessWidget {
  const HazeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset("images/haze.png",fit: BoxFit.contain,);
  }
}