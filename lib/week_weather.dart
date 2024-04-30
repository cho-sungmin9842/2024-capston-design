import 'package:flutter/material.dart';
import 'package:hansungcapstone_bugiweather/weekscreen.dart';
import 'NaverMap/mylocation.dart';
import 'package:hansungcapstone_bugiweather/network.dart' as network;

class WeekWeather extends StatefulWidget {

  const WeekWeather({super.key});

  @override
  State<WeekWeather> createState() => _WeekWeatherState();
}

class _WeekWeatherState extends State<WeekWeather> {

  double? latitude3;
  double? longitude3;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  void getLocation() async{
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;
    print(latitude3);
    print(longitude3);

    final data = await network.getJsonData();
    final dailyForecasts = data['daily'] as List<dynamic>;

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return weekScreen(parseWeatherData: dailyForecasts,);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => backsCcreen()),
          // );
        },
        child: Text('Button'),
      ),
    );
  }
}

