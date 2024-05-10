import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class Model {
  Widget? getWeatherIcon(int condition) {
    if (condition < 600) {
      return Image.asset(
        'images/rain_1x.png',
      );
    } else if (condition >= 600 && condition < 700) {
      return Image.asset(
        'images/snow_1x.png',
      );
    }else if (condition == 800) {
      return Image.asset(
        'images/sun_1x.png',
      );
    } else if (condition == 801 && condition <= 802) {
      return Image.asset(
        'images/sunc_1x.png',
      );
    } else if (condition == 803) {
      return Image.asset(
        'images/ptcl_1x.png',
      );
    }else if (condition == 804) {
      return Image.asset(
        'images/cloud_1x.png',
      );
    }
  }
}