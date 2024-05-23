import 'dart:convert';
import 'package:http/http.dart' as http;
import 'NaverMap/mylocation.dart';

const String apiKey = '***REMOVED_OWM_KEY***';
const String baseUrl = 'https://api.openweathermap.org/data/3.0/onecall';

Future<dynamic> getJsonData() async {
  // const lat = "37.4967";
  // const lon = "127.063";

  MyLocation userLocation = MyLocation();
  await userLocation.getMyCurrentLocation();

  var lat = userLocation.latitude2.toString();
  var lon = userLocation.longitude2.toString();

  final url = '$baseUrl?lat=$lat&lon=$lon&exclude=current,minutely,hourly&appid=$apiKey';

  final response = await http.get(Uri.parse(url));
  //http.Response response = await http.get(url);

  if (response.statusCode == 200) {
    String jsonData = response.body;
    var parsingData = jsonDecode(jsonData);
    return parsingData;
  } else {
    throw Exception('Failed to load weather data');
  }
}

Future<dynamic> fetchWeatherForecast3() async {
  DateTime now = DateTime.now().toUtc();

  // 한국 시간대 적용 (Asia/Seoul)
  DateTime seoulTime = now.add(Duration(hours: 9));

  String year = seoulTime.year.toString();
  String month = seoulTime.month.toString().padLeft(2, '0');
  String day = seoulTime.day.toString().padLeft(2, '0');
  String hour = seoulTime.hour.toString().padLeft(2, '0');
  String minute = '00';

  if (int.parse(hour) < 6) {
    hour = '18';
    now = now.subtract(Duration(days: 1));
    day = now.day.toString().padLeft(2, '0');
    month = now.month.toString().padLeft(2, '0');
  } else if (int.parse(hour) >= 18) {
    hour = '18';
  } else {
    hour = '06';
  }

  final url = 'http://apis.data.go.kr/1360000/MidFcstInfoService/getMidFcst?serviceKey=***REMOVED_OWM_KEY***&numOfRows=10'
      '&pageNo=1&stnId=108&dataType=JSON&tmFc=$year$month$day$hour$minute';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    String xmlData = response.body;
    var document = jsonDecode(xmlData);
    return document;
  } else {
    throw Exception('Failed to load weather forecast text');
  }
}
