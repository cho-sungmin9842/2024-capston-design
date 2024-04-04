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
import 'httpnetwork.dart';
import 'loading.dart';
import 'package:hansungcapstone_bugiweather/NaverMap/screens/loading.dart';
import 'package:hansungcapstone_bugiweather/week_weather.dart';
import 'package:http/http.dart' as http;

final String apiKey = dotenv.get("apiKey");
final String kakaoApiKey = dotenv.get("kakao_api");

class HomeScreen extends StatefulWidget {
  final dynamic addrData;
  final dynamic currentWeatherData;
  final dynamic today2amData;
  final dynamic superShortWeatherData;
  final dynamic hsaddrData;
  final dynamic hstoday2amData;
  final dynamic hscurrentWeatherData;
  final dynamic hssuperShortWeatherData;

  const HomeScreen({
    super.key,
    this.addrData,
    this.hsaddrData,
    this.today2amData,
    this.hstoday2amData,
    this.currentWeatherData,
    this.hscurrentWeatherData,
    this.superShortWeatherData,
    this.hssuperShortWeatherData,
  });

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  MyLocation userLocation = MyLocation();
  late List<Widget> _widgetOptions;
  var todayTMN2;
  var todayTMX2;
  var hstodayTMN2;
  var hstodayTMX2;

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

    getAirConditionData();

    _widgetOptions = <Widget>[
      getTodayWeatherScreen(),
      WeekWeather(),
      HSTodayWeatherScreen(
        addrData: widget.hsaddrData,
        today2amData: widget.hstoday2amData,
        currentWeatherData: widget.hscurrentWeatherData,
        todayTMN2: todayTMN2,
        todayTMX2: todayTMX2,
        skyState: "맑음",
      ),
      LoadingMap(),
      Favorites(),
    ];
  }

  Widget getTodayWeatherScreen() {
    // 2시 데이터
    int totalCount =
        widget.today2amData['response']['body']['totalCount']; // 데이터의 총 갯수
    for (int i = 0; i < totalCount; i++) {
      // 데이터 전체를 돌면서 원하는 데이터 추출
      var parsed_json =
          widget.today2amData['response']['body']['items']['item'][i];
      // 2시 이전, 23시 데이터
      if (DateTime.now().hour < 2) {
        // 당일 최저 기온
        if (parsed_json['category'] == 'TMN') {
          todayTMN2 = parsed_json['fcstValue'];
        }
        // 당일 최고 기온
        if (parsed_json['category'] == 'TMX') {
          todayTMX2 = parsed_json['fcstValue'];
          break;
        }
      }
      // 2시 이후
      else {
        // 당일 최저 기온
        if (parsed_json['category'] == 'TMN' &&
            parsed_json['baseDate'] == parsed_json['fcstDate']) {
          todayTMN2 = parsed_json['fcstValue'];
        }
        // 당일 최고 기온
        if (parsed_json['category'] == 'TMX' &&
            parsed_json['baseDate'] == parsed_json['fcstDate']) {
          todayTMX2 = parsed_json['fcstValue'];
        }
      }
    }
    var ptyCode, skyCode, skyState;
    var timeHH = DateFormat('HH00')
        .format(DateTime.now().add(const Duration(minutes: 30))); // 30분후
    // 초단기 예보
    int totalCount3 =
        widget.superShortWeatherData['response']['body']['totalCount'];
    for (int i = 0; i < totalCount3; i++) {
      var parsed_json =
          widget.superShortWeatherData['response']['body']['items']['item'][i];
      // PTY 코드값
      if (parsed_json['category'] == 'PTY' &&
          parsed_json['fcstTime'] == timeHH) {
        ptyCode = parsed_json['fcstValue'];
      }
      // SKY 코드값
      if (parsed_json['category'] == 'SKY' &&
          parsed_json['fcstTime'] == timeHH) {
        skyCode = parsed_json['fcstValue'];
      }
    }
    if (ptyCode == '0') {
      if (skyCode == '1') {
        //맑음
        skyState = '맑음';
      } else if (skyCode == '3') {
        //구름 많음
        skyState = '구름 많음';
      } else if (skyCode == '4') {
        // 흐림
        skyState = '흐림';
      }
    } else if (ptyCode == '1') {
      // 비
      skyState = '비';
    } else if (ptyCode == '2') {
      // 비/눈
      skyState = '진눈개비';
    } else if (ptyCode == '3') {
      // 눈
      skyState = '눈';
    } else if (ptyCode == '5') {
      // 빗방울
      skyState = '빗방울';
    } else if (ptyCode == '6') {
      // 빗방울눈날림
      skyState = '빗방울눈날림';
    } else if (ptyCode == '7') {
      // 눈날림
      skyState = '눈날림';
    } else {
      skyState = '하늘 상태 정보 없음';
    }
    return TodayWeatherScreen(
      addrData: widget.addrData,
      today2amData: widget.today2amData,
      currentWeatherData: widget.currentWeatherData,
      todayTMN2: todayTMN2,
      todayTMX2: todayTMX2,
      skyState: skyState,
    );
  }

  Widget getHSTodayWeatherScreen() {
    // 2시 데이터
    int totalCount =
    widget.hstoday2amData['response']['body']['totalCount']; // 데이터의 총 갯수
    for (int i = 0; i < totalCount; i++) {
      // 데이터 전체를 돌면서 원하는 데이터 추출
      var parsed_json =
      widget.hstoday2amData['response']['body']['items']['item'][i];
      // 2시 이전, 23시 데이터
      if (DateTime.now().hour < 2) {
        // 당일 최저 기온
        if (parsed_json['category'] == 'TMN') {
          hstodayTMN2 = parsed_json['fcstValue'];
        }
        // 당일 최고 기온
        if (parsed_json['category'] == 'TMX') {
          hstodayTMX2 = parsed_json['fcstValue'];
          break;
        }
      }
      // 2시 이후
      else {
        // 당일 최저 기온
        if (parsed_json['category'] == 'TMN' &&
            parsed_json['baseDate'] == parsed_json['fcstDate']) {
          hstodayTMN2 = parsed_json['fcstValue'];
        }
        // 당일 최고 기온
        if (parsed_json['category'] == 'TMX' &&
            parsed_json['baseDate'] == parsed_json['fcstDate']) {
          hstodayTMX2 = parsed_json['fcstValue'];
        }
      }
    }
    var ptyCode, skyCode, skyState;
    var timeHH = DateFormat('HH00')
        .format(DateTime.now().add(const Duration(minutes: 30))); // 30분후
    // 초단기 예보
    int totalCount3 =
    widget.hssuperShortWeatherData['response']['body']['totalCount'];
    for (int i = 0; i < totalCount3; i++) {
      var parsed_json =
      widget.superShortWeatherData['response']['body']['items']['item'][i];
      // PTY 코드값
      if (parsed_json['category'] == 'PTY' &&
          parsed_json['fcstTime'] == timeHH) {
        ptyCode = parsed_json['fcstValue'];
      }
      // SKY 코드값
      if (parsed_json['category'] == 'SKY' &&
          parsed_json['fcstTime'] == timeHH) {
        skyCode = parsed_json['fcstValue'];
      }
    }
    if (ptyCode == '0') {
      if (skyCode == '1') {
        //맑음
        skyState = '맑음';
      } else if (skyCode == '3') {
        //구름 많음
        skyState = '구름 많음';
      } else if (skyCode == '4') {
        // 흐림
        skyState = '흐림';
      }
    } else if (ptyCode == '1') {
      // 비
      skyState = '비';
    } else if (ptyCode == '2') {
      // 비/눈
      skyState = '진눈개비';
    } else if (ptyCode == '3') {
      // 눈
      skyState = '눈';
    } else if (ptyCode == '5') {
      // 빗방울
      skyState = '빗방울';
    } else if (ptyCode == '6') {
      // 빗방울눈날림
      skyState = '빗방울눈날림';
    } else if (ptyCode == '7') {
      // 눈날림
      skyState = '눈날림';
    } else {
      skyState = '하늘 상태 정보 없음';
    }
    return HSTodayWeatherScreen(
      addrData: widget.hsaddrData,
      today2amData: widget.hstoday2amData,
      currentWeatherData: widget.hscurrentWeatherData,
      todayTMN2: hstodayTMN2,
      todayTMX2: hstodayTMX2,
      skyState: skyState,
    );
  }

  void getAirConditionData() async {
    // 현재 내 위치 객체
    MyLocation userLocation = MyLocation();
    // 사용자의 현재 위치 불러올 때까지 대기
    await userLocation.getMyCurrentLocation();

    // 현재 위치의 위,경도 값 저장
    var userLati = userLocation.latitude2;
    var userLongi = userLocation.longitude2;

    var obsJson; // 근접 측정소 rest api json 응답 객체
    var obs; // 측정소

    // 카카오맵 좌표계 변환
    var kakaoXYUrl =
        Uri.parse('https://dapi.kakao.com/v2/local/geo/transcoord.json?'
            'x=$userLongi&y=$userLati&input_coord=WGS84&output_coord=TM');
    var kakaoTM = await http
        .get(kakaoXYUrl, headers: {"Authorization": "KakaoAK $kakaoApiKey"});
    var TM = jsonDecode(kakaoTM.body);

    // 카카오맵 좌표계의 x좌표
    var tm_x = TM['documents'][0]['x'];
    // 카카오맵 좌표계의 y좌표
    var tm_y = TM['documents'][0]['y'];

    // 근접 측정소 목록 조회
    var closeObs =
        'https://apis.data.go.kr/B552584/MsrstnInfoInqireSvc/getNearbyMsrstnList?serviceKey=$apiKey&returnType=json&tmX=$tm_x&tmY=$tm_y&ver=1.1';
    // 근접 측정소 rest api 응답 객체
    http.Response responseObs = await http.get(Uri.parse(closeObs));
    if (responseObs.statusCode == 200) {
      // 응답 받은 데이터를 json 형태로 변환하여 저장
      obsJson = jsonDecode(responseObs.body);
      print(obsJson);
    }
    obs = obsJson['response']['body']['items'][0]['stationName'];
    print('측정소: $obs');
    // 측정소별 실시간 측정정보 조회
    String airConditon =
        'https://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?stationName=$obs&dataTerm=DAILY&pageNo=1&ver=1.0&numOfRows=1&returnType=json&serviceKey=$apiKey';

    HttpNetwork network = HttpNetwork("", "", "", "", airConditon);

    // 측정소별 실시간 측정 정보 조회 json 응답 데이터
    var airConditionData = await network.getAirConditionData();
    _widgetOptions.add(DustScreen(airConditionData: airConditionData));
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
