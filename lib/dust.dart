import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hansungcapstone_bugiweather/httpnetwork.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'NaverMap/mylocation.dart';
import 'package:http/http.dart' as http;

class DustScreen extends StatefulWidget {
  final dynamic airConditionData;

  const DustScreen({super.key, this.airConditionData});

  @override
  State<DustScreen> createState() => _DustScreenState();
}

class _DustScreenState extends State<DustScreen> {
  late DateFormat daysFormat;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    daysFormat = DateFormat('E', 'ko_KR'); //요일 한글 표현
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backimg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (double.parse(widget
                    .airConditionData['response']
                ['body']['items'][0]['pm25Value']) >=
                    0.0 &&
                    double.parse(widget
                        .airConditionData['response']
                    ['body']['items'][0]['pm25Value']) <=
                        15.0)
                    ? const Icon(Icons.mood_outlined, size: 50)
                    : (double.parse(widget
                    .airConditionData['response']
                ['body']['items'][0]['pm25Value']) >=
                    16.0 &&
                    double.parse(widget
                        .airConditionData['response']
                    ['body']['items'][0]['pm25Value']) <=
                        35.0) ? const Icon(Icons.mood_outlined, size: 50)
                    : (double.parse(widget.airConditionData['response']
                ['body']['items'][0]['pm25Value']) >=
                    36.0 &&
                    double.parse(widget
                        .airConditionData['response']
                    ['body']['items'][0]['pm25Value']) <=
                        75.0) ? const Icon(Icons.mood_bad, size: 50) : const Icon(
                    Icons.mood_bad, size: 50),
                (double.parse(widget
                    .airConditionData['response']
                ['body']['items'][0]['pm25Value']) >=
                    0.0 &&
                    double.parse(widget
                        .airConditionData['response']
                    ['body']['items'][0]['pm25Value']) <=
                        15.0)
                    ? const Text('좋음', style: TextStyle(fontSize: 30))
                    : (double.parse(widget
                    .airConditionData['response']
                ['body']['items'][0]['pm25Value']) >=
                    16.0 &&
                    double.parse(widget
                        .airConditionData['response']
                    ['body']['items'][0]['pm25Value']) <=
                        35.0) ? const Text('보통', style: TextStyle(fontSize: 30))
                    : (double.parse(widget.airConditionData['response']
                ['body']['items'][0]['pm25Value']) >=
                    36.0 &&
                    double.parse(widget
                        .airConditionData['response']
                    ['body']['items'][0]['pm25Value']) <=
                        75.0)
                    ? const Text('나쁨', style: TextStyle(fontSize: 30))
                    : const Text('매우 나쁨', style: TextStyle(fontSize: 30))
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('M월 d일 ').format(DateTime.now()) +
                          DateFormat("h:mm a").format(DateTime.now()),
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        color: Color(0xff000000),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 70,
                        ),
                        const Text('미세먼지 (PM 10)'),
                        const SizedBox(width: 10),
                        Text(widget.airConditionData['response']
                        ['body']['items'][0]['pm10Value'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.masks_outlined,
                          size: 50,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: (double.parse(widget
                              .airConditionData['response']
                          ['body']['items'][0]['pm10Value']) >=
                              0.0 &&
                              double.parse(widget
                                  .airConditionData['response']
                              ['body']['items'][0]['pm10Value']) <=
                                  30.0)
                              ? const SizedBox(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: 1,
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.blue),
                            ),
                          )
                              : (double.parse(widget
                              .airConditionData['response']
                          ['body']['items'][0]['pm10Value']) >=
                              31.0 &&
                              double.parse(widget
                                  .airConditionData['response']
                              ['body']['items'][0]['pm10Value']) <=
                                  80.0) ? const SizedBox(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: 1,
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.green),
                            ),
                          ) : (double.parse(widget
                              .airConditionData['response']
                          ['body']['items'][0]['pm10Value']) >=
                              81.0 &&
                              double.parse(widget
                                  .airConditionData['response']
                              ['body']['items'][0]['pm10Value']) <=
                                  150.0) ? const SizedBox(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: 1,
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.orange),
                            ),
                          ) : const SizedBox(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: 1,
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 70,
                        ),
                        const Text('초미세먼지 (PM 2.5)'),
                        const SizedBox(width: 10),
                        Text(widget.airConditionData['response']
                        ['body']['items'][0]['pm25Value'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.masks_rounded,
                          size: 50,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: (double.parse(widget
                              .airConditionData['response']
                          ['body']['items'][0]['pm25Value']) >=
                              0.0 &&
                              double.parse(widget
                                  .airConditionData['response']
                              ['body']['items'][0]['pm25Value']) <=
                                  15.0)
                              ? const SizedBox(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: 1,
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.blue),
                            ),
                          )
                              : (double.parse(widget
                              .airConditionData['response']
                          ['body']['items'][0]['pm25Value']) >=
                              16.0 &&
                              double.parse(widget
                                  .airConditionData['response']
                              ['body']['items'][0]['pm25Value']) <=
                                  35.0) ? const SizedBox(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: 1,
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.green),
                            ),
                          ) : (double.parse(widget
                              .airConditionData['response']
                          ['body']['items'][0]['pm25Value']) >=
                              36.0 &&
                              double.parse(widget
                                  .airConditionData['response']
                              ['body']['items'][0]['pm25Value']) <=
                                  75.0) ? const SizedBox(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: 1,
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.orange),
                            ),
                          ) : const SizedBox(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: 1,
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 70,
                        ),
                        const Text('오존 (O₃)'),
                        const SizedBox(width: 10),
                        Text(widget.airConditionData['response']
                        ['body']['items'][0]['o3Value'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Image(
                          image: AssetImage("assets/o3.png"),
                          width: 50.0,
                          height: 50.0,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: (double.parse(widget
                              .airConditionData['response']
                          ['body']['items'][0]['o3Value']) >=
                              0.0 &&
                              double.parse(widget
                                  .airConditionData['response']
                              ['body']['items'][0]['o3Value']) <=
                                  0.03)
                              ? const SizedBox(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: 1,
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.blue),
                            ),
                          )
                              : (double.parse(widget
                              .airConditionData['response']
                          ['body']['items'][0]['o3Value']) >=
                              0.031 &&
                              double.parse(widget
                                  .airConditionData['response']
                              ['body']['items'][0]['o3Value']) <=
                                  0.09) ? const SizedBox(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: 1,
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.green),
                            ),
                          ) : (double.parse(widget
                              .airConditionData['response']
                          ['body']['items'][0]['o3Value']) >=
                              0.091 &&
                              double.parse(widget
                                  .airConditionData['response']
                              ['body']['items'][0]['o3Value']) <=
                                  0.15) ? const SizedBox(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: 1,
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.orange),
                            ),
                          ) : const SizedBox(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: 1,
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 70,
                        ),
                        const Text('이산화질소 (NO₂)'),
                        const SizedBox(width: 10),
                        Text(widget.airConditionData['response']
                        ['body']['items'][0]['no2Value'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Image(
                          image: AssetImage("assets/no2.png"),
                          width: 50.0,
                          height: 50.0,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: (double.parse(widget
                              .airConditionData['response']
                          ['body']['items'][0]['no2Value']) >=
                              0.0 &&
                              double.parse(widget
                                  .airConditionData['response']
                              ['body']['items'][0]['no2Value']) <=
                                  0.03)
                              ? const SizedBox(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: 1,
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.blue),
                            ),
                          )
                              : (double.parse(widget
                              .airConditionData['response']
                          ['body']['items'][0]['no2Value']) >=
                              0.031 &&
                              double.parse(widget
                                  .airConditionData['response']
                              ['body']['items'][0]['no2Value']) <=
                                  0.06) ? const SizedBox(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: 1,
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.green),
                            ),
                          ) : (double.parse(widget
                              .airConditionData['response']
                          ['body']['items'][0]['no2Value']) >=
                              0.061 &&
                              double.parse(widget
                                  .airConditionData['response']
                              ['body']['items'][0]['no2Value']) <=
                                  0.2) ? const SizedBox(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: 1,
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.orange),
                            ),
                          ) : const SizedBox(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: 1,
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 70,
                        ),
                        const Text('일산화탄소 (CO)'),
                        const SizedBox(width: 10),
                        Text(widget.airConditionData['response']
                        ['body']['items'][0]['coValue'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Image(
                          image: AssetImage("assets/co.png"),
                          width: 50.0,
                          height: 50.0,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: SizedBox(
                              height: 10,
                              child: (double.parse(widget
                                  .airConditionData['response']
                              ['body']['items'][0]['coValue']) >=
                                  0.0 &&
                                  double.parse(widget
                                      .airConditionData['response']
                                  ['body']['items'][0]['coValue']) <=
                                      2.0)
                                  ? const SizedBox(
                                height: 10,
                                child: LinearProgressIndicator(
                                  value: 1,
                                  backgroundColor: Colors.grey,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.blue),
                                ),
                              )
                                  : (double.parse(widget
                                  .airConditionData['response']
                              ['body']['items'][0]['coValue']) >=
                                  2.1 &&
                                  double.parse(widget
                                      .airConditionData['response']
                                  ['body']['items'][0]['coValue']) <=
                                      9.0) ? const SizedBox(
                                height: 10,
                                child: LinearProgressIndicator(
                                  value: 1,
                                  backgroundColor: Colors.grey,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.green),
                                ),
                              ) : (double.parse(widget
                                  .airConditionData['response']
                              ['body']['items'][0]['coValue']) >=
                                  9.1 &&
                                  double.parse(widget
                                      .airConditionData['response']
                                  ['body']['items'][0]['coValue']) <=
                                      15.0) ? const SizedBox(
                                height: 10,
                                child: LinearProgressIndicator(
                                  value: 1,
                                  backgroundColor: Colors.grey,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.orange),
                                ),
                              ) : const SizedBox(
                                height: 10,
                                child: LinearProgressIndicator(
                                  value: 1,
                                  backgroundColor: Colors.grey,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.red),
                                ),
                              ),
                            )
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 70,
                        ),
                        const Text('아황산가스 (SO₂)'),
                        const SizedBox(width: 10),
                        Text(widget.airConditionData['response']
                        ['body']['items'][0]['so2Value'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Image(
                          image: AssetImage("assets/so2.png"),
                          width: 50.0,
                          height: 50.0,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: SizedBox(
                              height: 10,
                              child: (double.parse(widget
                                  .airConditionData['response']
                              ['body']['items'][0]['so2Value']) >=
                                  0.0 &&
                                  double.parse(widget
                                      .airConditionData['response']
                                  ['body']['items'][0]['so2Value']) <=
                                      0.02)
                                  ? const SizedBox(
                                height: 10,
                                child: LinearProgressIndicator(
                                  value: 1,
                                  backgroundColor: Colors.grey,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.blue),
                                ),
                              )
                                  : (double.parse(widget
                                  .airConditionData['response']
                              ['body']['items'][0]['so2Value']) >=
                                  0.021 &&
                                  double.parse(widget
                                      .airConditionData['response']
                                  ['body']['items'][0]['so2Value']) <=
                                      0.05) ? const SizedBox(
                                height: 10,
                                child: LinearProgressIndicator(
                                  value: 1,
                                  backgroundColor: Colors.grey,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.green),
                                ),
                              ) : (double.parse(widget
                                  .airConditionData['response']
                              ['body']['items'][0]['so2Value']) >=
                                  0.051 &&
                                  double.parse(widget
                                      .airConditionData['response']
                                  ['body']['items'][0]['so2Value']) <=
                                      0.15) ? const SizedBox(
                                height: 10,
                                child: LinearProgressIndicator(
                                  value: 1,
                                  backgroundColor: Colors.grey,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.orange),
                                ),
                              ) : const SizedBox(
                                height: 10,
                                child: LinearProgressIndicator(
                                  value: 1,
                                  backgroundColor: Colors.grey,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.red),
                                ),
                              ),
                            )
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: 20, // 원의 너비
                          height: 20, // 원의 높이
                          decoration: const BoxDecoration(
                            color: Colors.blueAccent, // 원의 색상
                            shape: BoxShape.circle, // 원 모양 설정
                          ),
                        ),
                        const SizedBox(width: 10), // 원과 텍스트 사이의 간격
                        const Text(
                          "좋음", // 텍스트 내용
                          style: TextStyle(
                            fontSize: 16, // 텍스트 크기
                            color: Colors.black, // 텍스트 색상
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          width: 20, // 원의 너비
                          height: 20, // 원의 높이
                          decoration: const BoxDecoration(
                            color: Colors.green, // 원의 색상
                            shape: BoxShape.circle, // 원 모양 설정
                          ),
                        ),
                        const SizedBox(width: 10), // 원과 텍스트 사이의 간격
                        const Text(
                          "보통", // 텍스트 내용
                          style: TextStyle(
                            fontSize: 16, // 텍스트 크기
                            color: Colors.black, // 텍스트 색상
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          width: 20, // 원의 너비
                          height: 20, // 원의 높이
                          decoration: const BoxDecoration(
                            color: Colors.orangeAccent, // 원의 색상
                            shape: BoxShape.circle, // 원 모양 설정
                          ),
                        ),
                        const SizedBox(width: 10), // 원과 텍스트 사이의 간격
                        const Text(
                          "나쁨", // 텍스트 내용
                          style: TextStyle(
                            fontSize: 16, // 텍스트 크기
                            color: Colors.black, // 텍스트 색상
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          width: 20, // 원의 너비
                          height: 20, // 원의 높이
                          decoration: const BoxDecoration(
                            color: Colors.red, // 원의 색상
                            shape: BoxShape.circle, // 원 모양 설정
                          ),
                        ),
                        const SizedBox(width: 10), // 원과 텍스트 사이의 간격
                        const Text(
                          "매우나쁨", // 텍스트 내용
                          style: TextStyle(
                            fontSize: 16, // 텍스트 크기
                            color: Colors.black, // 텍스트 색상
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}