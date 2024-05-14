import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hansungcapstone_bugiweather/CustomRoute.dart';
import 'package:hansungcapstone_bugiweather/screen.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'NaverMap/mylocation.dart';
import 'Search/weather.dart';
import 'httpnetwork.dart';
import 'network.dart';

final String apiKey = dotenv.get("apiKey");
final String kakaoApiKey = dotenv.get("kakao_api");

class AppLoading extends StatefulWidget {
  const AppLoading({super.key});

  @override
  _AppLoadingState createState() => _AppLoadingState();
}

class _AppLoadingState extends State<AppLoading> {
  // 초단기 실황
  String? currentBaseTime;
  String? currentBaseDate;

  // 초단기 예보
  String? sswBaseTime;
  String? sswBaseDate;

  //
  var baseDate;
  var baseTime;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    // 현재 내 위치 객체
    MyLocation userLocation = MyLocation();
    // 사용자의 현재 위치 불러올 때까지 대기
    await userLocation.getMyCurrentLocation();
    // 현재 위치의 x,y좌표 값 저장
    var xCoordinate = userLocation.currentX; // x좌표
    var yCoordinate = userLocation.currentY; // y좌표

    // 현재 위치의 위,경도 값 저장
    var userLati = userLocation.latitude2;
    var userLongi = userLocation.longitude2;

    // 단기예보
    var baseDate_2am;
    var baseTime_2am;

    /*print("xCoordinate=$xCoordinate");
    print("yCoordinate=$yCoordinate");
    print("현재 날짜 및 시간=${DateTime.now()}");
    print("지금은 몇 시 = ${DateTime.now().hour}");
    print("지금은 몇 분 = ${DateTime.now().minute}");*/

    //카카오맵 역지오코딩
    var kakaoGeoUrl = Uri.parse(
        'https://dapi.kakao.com/v2/local/geo/coord2address.json?x=$userLongi&y=$userLati&input_coord=WGS84');
    var kakaoGeo = await http
        .get(kakaoGeoUrl, headers: {"Authorization": "KakaoAK $kakaoApiKey"});
    // json data
    String addr = kakaoGeo.body;
    // 응답받은 현재 위치 정보를 json 형태로 변환
    var addrData = jsonDecode(addr);

    // 지금이 2시 전이거나 2시 10분 전이라면 baseDate_2am은 어제날짜, baseTime_2am은 2300
    if (DateTime.now().hour < 2 ||
        DateTime.now().hour == 2 && DateTime.now().minute < 10) {
      baseDate_2am = getYesterdayDate();
      baseTime_2am = "2300";
    }
    // 지금이 2시 전이 아니고 2시 10분 전이 아니라면 baseDate_2am은 오늘날짜, baseTime_2am은 0200
    else {
      baseDate_2am = getSystemTime();
      baseTime_2am = "0200";
    }
    /*print("baseDate_2am=$baseDate_2am");
    print("baseTime_2am=$baseTime_2am");
*/
    setCurrentBase();

    /*print("baseDate=${baseDate}");
    print("baseTime=${baseTime}");*/

    // 단기 예보(오늘 최저 기온)
    String today2am =
        'https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=$apiKey&numOfRows=1000&pageNo=1&base_date=$baseDate_2am&base_time=$baseTime_2am&nx=$xCoordinate&ny=$yCoordinate&dataType=JSON';

    currentWeatherDate();
    /*print("currentBaseDate=${currentBaseDate}");
    print("currentBaseTime=${currentBaseTime}");*/
    // 현재 날씨(초단기 실황)
    String currentWeather =
        'https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst?serviceKey=$apiKey&numOfRows=10&pageNo=1&base_date=$currentBaseDate&base_time=$currentBaseTime&nx=$xCoordinate&ny=$yCoordinate&dataType=JSON';

    superShortWeatherDate();
    /*print("sswBaseDate=$sswBaseDate");
    print("sswBaseTime=$sswBaseTime");*/

    // 초단기 예보
    String superShortWeather =
        'https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst?serviceKey=$apiKey&numOfRows=60&pageNo=1&base_date=$sswBaseDate&base_time=$sswBaseTime&nx=$xCoordinate&ny=$yCoordinate&dataType=JSON';
    HttpNetwork network =
    HttpNetwork(today2am, "", currentWeather, superShortWeather, "");

    // 오늘 최저 기온 json 응답 데이터
    var today2amData = await network.getToday2amData();
    // 초단기 실황 json 응답 데이터
    var currentWeatherData = await network.getCurrentWeatherData();
    // 초단기 예보 json 응답 데이터
    var superShortWeatherData = await network.getSuperShortWeatherData();

    // 지금 시간으로부터의 단기예보
    String currentToday =
        'https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=$apiKey&numOfRows=1000&pageNo=1&base_date=$baseDate&base_time=$baseTime&nx=$xCoordinate&ny=$yCoordinate&dataType=JSON';

    network.setUrl(currentToday, "", "", "", "");

    // 금일 현재 시간부로부터 단기 예보 데이터
    var currenttodayData = await network.getToday2amData();

    await userLocation.setMyCurrentLocation(
        127.01024023796833, 37.58253453120409);
    // 현재 위치의 x,y좌표 값 저장
    xCoordinate = userLocation.currentX; // x좌표
    yCoordinate = userLocation.currentY; // y좌표

    // 현재 위치의 위,경도 값 저장
    userLati = userLocation.latitude2;
    userLongi = userLocation.longitude2;

    //카카오맵 역지오코딩
    kakaoGeoUrl = Uri.parse(
        'https://dapi.kakao.com/v2/local/geo/coord2address.json?x=$userLongi&y=$userLati&input_coord=WGS84');
    kakaoGeo = await http
        .get(kakaoGeoUrl, headers: {"Authorization": "KakaoAK $kakaoApiKey"});
    // json data
    addr = kakaoGeo.body;
    // 응답받은 현재 위치 정보를 json 형태로 변환
    var hsaddrData = jsonDecode(addr);

    // 단기 예보(오늘 최저 기온)
    String hstoday2am =
        'https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=$apiKey&numOfRows=1000&pageNo=1&base_date=$baseDate_2am&base_time=$baseTime_2am&nx=$xCoordinate&ny=$yCoordinate&dataType=JSON';

    currentWeatherDate();
    // 현재 날씨(초단기 실황)
    String hscurrentWeather =
        'https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst?serviceKey=$apiKey&numOfRows=10&pageNo=1&base_date=$currentBaseDate&base_time=$currentBaseTime&nx=$xCoordinate&ny=$yCoordinate&dataType=JSON';
    superShortWeatherDate();
    // 초단기 예보
    String hssuperShortWeather =
        'https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst?serviceKey=$apiKey&numOfRows=60&pageNo=1&base_date=$sswBaseDate&base_time=$sswBaseTime&nx=$xCoordinate&ny=$yCoordinate&dataType=JSON';
    network.setUrl(hstoday2am, "", hscurrentWeather, hssuperShortWeather, "");

    // 오늘 최저 기온 json 응답 데이터
    var hstoday2amData = await network.getToday2amData();
    // 초단기 실황 json 응답 데이터
    var hscurrentWeatherData = await network.getCurrentWeatherData();
    // 초단기 예보 json 응답 데이터
    var hssuperShortWeatherData = await network.getSuperShortWeatherData();

    // 한성대에서 지금 시간으로부터의 단기예보
    String hscurrentToday =
        'https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=$apiKey&numOfRows=1000&pageNo=1&base_date=$baseDate&base_time=$baseTime&nx=$xCoordinate&ny=$yCoordinate&dataType=JSON';

    network.setUrl(hscurrentToday, "", "", "", "");

    // 한성대에서 금일 현재 시간부로부터 단기 예보 데이터
    var currenthstodayData = await network.getToday2amData();

    //
    final data = await getJsonData();
    final dailyForecasts = data['daily'] as List<dynamic>;
    var weatherData = await WeatherModel().getLocationWeather();
    var forecastData = await WeatherModel().getLocationForecast();

    final Text = await fetchWeatherForecast3();
    final dailyForecastText = Text['response']['body']['items']['item'][0]['wfSv'];

    Navigator.push(
      context,
      CustomRoute(
        builder: (context) {
          return HomeScreen(
            addrData: addrData,
            hsaddrData: hsaddrData,
            today2amData: today2amData,
            hstoday2amData: hstoday2amData,
            currenttodayData: currenttodayData,
            currenthstodayData: currenthstodayData,
            currentWeatherData: currentWeatherData,
            hscurrentWeatherData: hscurrentWeatherData,
            superShortWeatherData: superShortWeatherData,
            hssuperShortWeatherData: hssuperShortWeatherData,
            dailyWeather: dailyForecasts,
            dailyForecastText: dailyForecastText,
            locationWeather: weatherData,
            locationForecast: forecastData,
          );
        },
      ),
    );
  }

  // 초단기 예보
  void superShortWeatherDate() {
    // 45분 이전이면 현재 시보다 1시간 전 `base_time`을 요청한다.
    if (DateTime.now().minute <= 45) {
      // 단. 00:45분 이전이라면 `base_date`는 전날이고 `base_time`은 2330이다.
      if (DateTime.now().hour == 0) {
        sswBaseDate = DateFormat('yyyyMMdd')
            .format(DateTime.now().subtract(const Duration(days: 1)));
        sswBaseTime = '2330';
      } else {
        sswBaseDate = DateFormat('yyyyMMdd').format(DateTime.now());
        sswBaseTime = DateFormat('HH30')
            .format(DateTime.now().subtract(const Duration(hours: 1)));
      }
    }
    //45분 이후면 현재 시와 같은 `base_time`을 요청한다.
    else {
      //if (now.minute > 45)
      sswBaseDate = DateFormat('yyyyMMdd').format(DateTime.now());
      sswBaseTime = DateFormat('HH30').format(DateTime.now());
    }
  }

  // 초단기 실황
  void currentWeatherDate() {
    // 지금이 40분 이전이면 현재 시보다 1시간 전 base_time을 요청한다.
    if (DateTime.now().minute <= 40) {
      // 단. 00:40분 이전이라면 base_date는 전날이고 base_time은 2300이다.
      if (DateTime.now().hour == 0) {
        currentBaseDate = DateFormat('yyyyMMdd')
            .format(DateTime.now().subtract(const Duration(days: 1)));
        currentBaseTime = '2300';
      }
      // 그 외의 경우라면 base_date는 오늘이고 base_time은 1시간 전이다.
      else {
        currentBaseDate = DateFormat('yyyyMMdd').format(DateTime.now());
        currentBaseTime = DateFormat('HH00')
            .format(DateTime.now().subtract(const Duration(hours: 1)));
      }
    }
    // 40분 이후면 현재 시와 같은 `base_time`을 요청한다.
    else {
      currentBaseDate = DateFormat('yyyyMMdd').format(DateTime.now());
      currentBaseTime = DateFormat('HH00').format(DateTime.now());
    }
  }

  void setCurrentBase() {
    var now = DateTime.now();
    if (now.hour < 2 || now.hour == 2 && now.minute <= 30) {
      baseDate =
          DateFormat('yyyyMMdd').format(now.subtract(const Duration(days: 1)));
      baseTime = "2300";
    } else if (now.hour < 5 || now.hour == 5 && now.minute <= 30) {
      baseDate = getSystemTime();
      baseTime = "0200";
    } else if (now.hour < 8 || now.hour == 8 && now.minute <= 30) {
      baseDate = getSystemTime();
      baseTime = "0500";
    } else if (now.hour < 11 || now.hour == 11 && now.minute <= 30) {
      baseDate = getSystemTime();
      baseTime = "0800";
    } else if (now.hour < 14 || now.hour == 14 && now.minute <= 30) {
      baseDate = getSystemTime();
      baseTime = "1100";
    } else if (now.hour < 17 || now.hour == 17 && now.minute <= 30) {
      baseDate = getSystemTime();
      baseTime = "1400";
    } else if (now.hour < 20 || now.hour == 20 && now.minute <= 30) {
      baseDate = getSystemTime();
      baseTime = "1700";
    } else {
      // if (now.hour < 23 || now.hour == 23 && now.minute <= 30) {
      baseDate = getSystemTime();
      baseTime = "2300";
    }
  }

  // 오늘 날짜 20201109 형태로 리턴
  String getSystemTime() {
    return DateFormat("yyyyMMdd").format(DateTime.now());
  }

  // 어제 날짜 20201109 형태로 리턴
  String getYesterdayDate() {
    return DateFormat("yyyyMMdd")
        .format(DateTime.now().subtract(const Duration(days: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.lightBlueAccent,
      body: Container(
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
        child: Center(
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
              Text(
                '위치 정보 업데이트 중',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white54,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}