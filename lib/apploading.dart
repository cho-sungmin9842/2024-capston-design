import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hansungcapstone_bugiweather/screen.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'NaverMap/mylocation.dart';
import 'httpnetwork.dart';

final String apiKey = dotenv.get("apiKey");
final String kakaoApiKey = dotenv.get("kakao_api");

class AppLoading extends StatefulWidget {

  const AppLoading({super.key});

  @override
  _AppLoadingState createState() => _AppLoadingState();
}

class _AppLoadingState extends State<AppLoading> {
  String? baseTime; // 단기 예보 시간
  String? baseDate; // 단기 예보 날짜
  String? baseDate_2am; // 단기 예보 날짜(오늘 최저 기온)
  String? baseTime_2am; // 단기 예보 시간(오늘 최저 기온)
  String? currentBaseTime; // 초단기 실황
  String? currentBaseDate;
  String? sswBaseTime; // 초단기 예보
  String? sswBaseDate;

  int? xCoordinate; // 현재 x좌표
  int? yCoordinate; // 현재 y좌표
  double? userLati; // 위도(latitude)
  double? userLongi; // 경도(longitude)
  // 현재 날짜 정보 객체
  var now = DateTime.now();

  @override
  void initState(){
    super.initState();
    getLocation();
  }

  // 오늘 날짜 20201109 형태로 리턴
  String getSystemTime(){
    return DateFormat("yyyyMMdd").format(now);
  }

  // 어제 날짜 20201109 형태로 리턴
  String getYesterdayDate(){
    return DateFormat("yyyyMMdd").format(DateTime.now().subtract(const Duration(days:1)));
  }
  // 가장 먼저 호출됨
  void getLocation() async{
    // 현재 내 위치 객체
    MyLocation userLocation = MyLocation();
    // 사용자의 현재 위치 불러올 때까지 대기
    await userLocation.getMyCurrentLocation();
    // 원하는 장소 위치의 경/위도값 전달
    // await userLocation.setMyCurrentLocation(127.0719145182428,37.51265864306608);
    // 현재 위치의 x,y좌표 값 저장
    xCoordinate = userLocation.currentX;  // x좌표
    yCoordinate = userLocation.currentY;  // y좌표

    // 현재 위치의 위,경도 값 저장
    userLati = userLocation.latitude2;
    userLongi = userLocation.longitude2;

    var tm_x; // 카카오맵 좌표계의 x좌표
    var tm_y; // 카카오맵 좌표계의 y좌표

    var obsJson; // 근접 측정소 rest api json 응답 객체
    var obs;  // 측정소

    print("x좌표 $xCoordinate");
    print("y좌표 $yCoordinate");
    print("userLong $userLongi");
    print("userLati $userLati");
    print("kakaoApiKey $kakaoApiKey");

    //카카오맵 역지오코딩
    var kakaoGeoUrl = Uri.parse('https://dapi.kakao.com/v2/local/geo/coord2address.json?x=$userLongi&y=$userLati&input_coord=WGS84');
    var kakaoGeo = await http.get(kakaoGeoUrl, headers: {"Authorization": "KakaoAK $kakaoApiKey"});
    // json data
    String addr = kakaoGeo.body;
    // 현재 위치 - 경기도 양평군 지평면 대평리 산 4
    print(addr);

    // 카카오맵 좌표계 변환
    var kakaoXYUrl = Uri.parse('https://dapi.kakao.com/v2/local/geo/transcoord.json?'
        'x=$userLongi&y=$userLati&input_coord=WGS84&output_coord=TM');
    var kakaoTM = await http.get(kakaoXYUrl, headers: {"Authorization": "KakaoAK $kakaoApiKey"});
    var TM = jsonDecode(kakaoTM.body);
    print(TM);
    tm_x = TM['documents'][0]['x'];
    tm_y = TM['documents'][0]['y'];

    print(tm_x);
    print(tm_y);
    print("apiKey $apiKey");
    // 근접 측정소 목록 조회
    var closeObs = 'https://apis.data.go.kr/B552584/MsrstnInfoInqireSvc/getNearbyMsrstnList?serviceKey=$apiKey&returnType=json&tmX=$tm_x&tmY=$tm_y&ver=1.1';
    // 근접 측정소 rest api 응답 객체
    http.Response responseObs = await http.get(Uri.parse(closeObs));
    if(responseObs.statusCode == 200) {
      // 응답 받은 데이터를 json 형태로 변환하여 저장
      obsJson = jsonDecode(responseObs.body);
      print(obsJson);
    }

    obs = obsJson['response']['body']['items'][0]['stationName'];
    print('측정소: $obs');
    // 지금이 2시 전이거나 2시 10분 전이라면 baseDate_2am은 어제날짜, baseTime_2am은 2300
    if(now.hour < 2 || now.hour == 2 && now.minute < 10){
      baseDate_2am = getYesterdayDate();
      baseTime_2am = "2300";
    }
    // 지금이 2시 전이 아니고 2시 10분 전이 아니라면 baseDate_2am은 오늘날짜, baseTime_2am은 0200
    else {
      baseDate_2am = getSystemTime();
      baseTime_2am = "0200";
    }
    print(baseDate_2am);
    print(baseTime_2am);

    // 단기 예보(오늘 최저 기온)
    String today2am = 'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=$apiKey&numOfRows=1000&pageNo=1&base_date=$baseDate_2am&base_time=$baseTime_2am&nx=$xCoordinate&ny=$yCoordinate&dataType=JSON';
    // 단기 예보 시간별 baseTime, baseDate 값 설정
    shortWeatherDate();
    // 단기 예보 주소
    String shortTermWeather = 'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=$apiKey&numOfRows=1000&pageNo=1&base_date=$baseDate&base_time=$baseTime&nx=$xCoordinate&ny=$yCoordinate&dataType=JSON';

    currentWeatherDate();
    // 현재 날씨(초단기 실황)
    String currentWeather = 'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst?serviceKey=$apiKey&numOfRows=10&pageNo=1&base_date=$currentBaseDate&base_time=$currentBaseTime&nx=$xCoordinate&ny=$yCoordinate&dataType=JSON';

    superShortWeatherDate();
    // 초단기 예보
    String superShortWeather = 'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst?serviceKey=$apiKey&numOfRows=60&pageNo=1&base_date=$sswBaseDate&base_time=$sswBaseTime&nx=$xCoordinate&ny=$yCoordinate&dataType=JSON';

    print(baseDate);
    print(baseTime);
    print(currentBaseTime); // 초단기 실황
    print(currentBaseDate);
    print(sswBaseTime); // 초단기 예보
    print(sswBaseDate);
    // 측정소별 실시간 측정정보 조회
    String airConditon = 'http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?stationName=$obs&dataTerm=DAILY&pageNo=1&ver=1.0&numOfRows=1&returnType=json&serviceKey=$apiKey';

    HttpNetwork network = HttpNetwork(today2am,
        shortTermWeather, currentWeather,
        superShortWeather, airConditon);
    // json 데이터
    // 오늘 최저 기온 json 응답 데이터
    var today2amData = await network.getToday2amData();
    // 단기 예보 json 응답 데이터
    var shortTermWeatherData = await network.getShortTermWeatherData();
    // 초단기 실황 json 응답 데이터
    var currentWeatherData = await network.getCurrentWeatherData();
    // 초단기 예보 json 응답 데이터
    var superShortWeatherData = await network.getSuperShortWeatherData();
    // 측정소별 실시간 측정 정보 조회 json 응답 데이터
    var airConditionData = await network.getAirConditionData();
    // 응답받은 현재 위치 정보를 json 형태로 변환
    var addrData = jsonDecode(addr);

    print('2am: $today2amData');
    print('shortTermWeather: $shortTermWeatherData');
    print('currentWeather: $currentWeatherData');
    print('superShortWeather: $superShortWeatherData');
    print('air: $airConditionData');

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return HomeScreen(
        parse2amData: today2amData,
        parseShortTermWeatherData: shortTermWeatherData,
        parseCurrentWeatherData: currentWeatherData,
        parseSuperShortWeatherData: superShortWeatherData,
        parseAirConditionData: airConditionData,
        parseAddrData: addrData
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitWave(
              color: Colors.white,
              size: 60.0,
            ),
            SizedBox(
              height: 20,
            ),
            Text('위치 정보 업데이트 중',
              style: TextStyle(
                  fontFamily: 'tmon',
                  fontSize: 20.0,
                  color: Colors.black87
              ),
            )
          ],
        ),
      ),
    );
  }
  // 단기 예보에 예보날짜와 시간 설정
  void shortWeatherDate(){
    // 0시~2시 10분 사이 예보
    if(now.hour < 2 || (now.hour == 2 && now.minute <= 10)){
      baseDate = getYesterdayDate();   // 어제 날짜
      baseTime = "2300";
    }
    // 2시 11분 ~ 5시 10분 사이 예보
    else if (now.hour < 5 || (now.hour == 5 && now.minute <= 10)){
      baseDate = getSystemTime(); // 오늘 날짜
      baseTime = "0200";
    }
    // 5시 11분 ~ 8시 10분 사이 예보
    else if (now.hour < 8 || (now.hour == 8 && now.minute <= 10)){
      baseDate = getSystemTime();
      baseTime = "0500";
    }
    // 8시 11분 ~ 11시 10분 사이 예보
    else if (now.hour < 11 || (now.hour == 11 && now.minute <= 10)){
      baseDate = getSystemTime();
      baseTime = "0800";
    }
    // 11시 11분 ~ 14시 10분 사이 예보
    else if (now.hour < 14 || (now.hour == 14 && now.minute <= 10)){
      baseDate = getSystemTime();
      baseTime = "1100";
    }
    // 14시 11분 ~ 17시 10분 사이 예보
    else if (now.hour < 17 || (now.hour == 17 && now.minute <= 10)){
      baseDate = getSystemTime();
      baseTime = "1400";
    }
    // 17시 11분 ~ 20시 10분 사이 예보
    else if (now.hour < 20 || (now.hour == 20 && now.minute <= 10)){
      baseDate = getSystemTime();
      baseTime = "1700";
    }
    // 20시 11분 ~ 23시 10분 사이 예보
    else if (now.hour < 23 || (now.hour == 23 && now.minute <= 10)){
      baseDate = getSystemTime();
      baseTime = "2000";
    }
    // 23시 11분 ~ 24시 사이 예보
    else if (now.hour == 23 && now.minute >= 10){
      baseDate = getSystemTime();
      baseTime = "2300";
    }
  }

  // 초단기 실황
  void currentWeatherDate() {
    // 지금이 40분 이전이면 현재 시보다 1시간 전 base_time을 요청한다.
    if (now.minute <= 40){
      // 단. 00:40분 이전이라면 base_date는 전날이고 base_time은 2300이다.
      if (now.hour == 0) {
        currentBaseDate = DateFormat('yyyyMMdd').format(now.subtract(const Duration(days:1)));
        currentBaseTime = '2300';
      }
      // 그 외의 경우라면 base_date는 오늘이고 base_time은 1시간 전이다.
      else {
        currentBaseDate = DateFormat('yyyyMMdd').format(now);
        currentBaseTime = DateFormat('HH00').format(now.subtract(const Duration(hours:1)));
      }
    }
    // 40분 이후면 현재 시와 같은 `base_time`을 요청한다.
    else{
      currentBaseDate = DateFormat('yyyyMMdd').format(now);
      currentBaseTime = DateFormat('HH00').format(now);
    }
  }

  // 초단기 예보
  void superShortWeatherDate(){
    //45분 이전이면 현재 시보다 1시간 전 `base_time`을 요청한다.
    if (now.minute <= 45){
      // 단. 00:45분 이전이라면 `base_date`는 전날이고 `base_time`은 2330이다.
      if (now.hour == 0) {
        sswBaseDate = DateFormat('yyyyMMdd').format(now.subtract(Duration(days:1)));
        sswBaseTime = '2330';
      } else {
        sswBaseDate = DateFormat('yyyyMMdd').format(now);
        sswBaseTime = DateFormat('HH30').format(now.subtract(Duration(hours:1)));
      }
    }
    //45분 이후면 현재 시와 같은 `base_time`을 요청한다.
    else{ //if (now.minute > 45)
      sswBaseDate = DateFormat('yyyyMMdd').format(now);
      sswBaseTime = DateFormat('HH30').format(now);
    }
   }
}