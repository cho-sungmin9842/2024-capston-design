import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class HttpNetwork {
  String today2amUrl; // 오늘 최저, 최고 기온
  String shortTermWeatherUrl; // 단기 예보
  String currentWeatherUrl; // 초단기 실황
  String superShortWeatherUrl; // 초단기 예보
  String airConditionUrl; // 대기 오염 정보

  HttpNetwork(this.today2amUrl, this.shortTermWeatherUrl,
      this.currentWeatherUrl, this.superShortWeatherUrl, this.airConditionUrl);

  void setUrl(
    String today2amUrl,
    String shortTermWeatherUrl,
    String currentWeatherUrl,
    String superShortWeatherUrl,
    String airConditionUrl,
  ) {
    this.today2amUrl = today2amUrl;
    this.shortTermWeatherUrl = shortTermWeatherUrl;
    this.currentWeatherUrl = currentWeatherUrl;
    this.superShortWeatherUrl = superShortWeatherUrl;
    this.airConditionUrl = airConditionUrl;
  }

  // 오늘 최저, 최고기온 json
  Future<dynamic> getToday2amData() async {
    http.Response response = await http.get(Uri.parse(today2amUrl));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData); // json형식 문자열을 배열 또는 객체로 변환하는 함수
      print(parsingData);
      return parsingData;
    }
  }

  // 단기예보 json
  Future<dynamic> getShortTermWeatherData() async {
    http.Response response = await http.get(Uri.parse(shortTermWeatherUrl));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      print(parsingData);
      return parsingData;
    }
  }

  // 초단기 실황 json
  Future<dynamic> getCurrentWeatherData() async {
    print("currentWeatherUrl=${currentWeatherUrl}");
    http.Response response = await http.get(Uri.parse(currentWeatherUrl));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      print(parsingData);
      return parsingData;
    }
  }

  // 초단기 예보 json
  Future<dynamic> getSuperShortWeatherData() async {
    http.Response response = await http.get(Uri.parse(superShortWeatherUrl));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      print(parsingData);
      return parsingData;
    }
  }

  // 측정소별 실시간 대기정보 측정 json
  Future<dynamic> getAirConditionData() async {
    http.Response response = await http.get(Uri.parse(airConditionUrl));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      print(parsingData);
      return parsingData;
    }
  }
}
