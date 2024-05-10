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
