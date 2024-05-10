import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

NOverlayImage getImage(String condition) {
  String con;
  switch (condition) {
    case "Clear" :
      con = "sun_1x.png";
    case "Clouds" :
      con = "cloud_1x.png";
    case "Rain" :
    case "Drizzle":
      con = "rain_1x.png";
    case "Haze" :
    case "Mist" :
      con = "haze.png";
    default :
      con = "sun_1x.png";
  }

  return NOverlayImage.fromAssetImage("images/"+con);
}