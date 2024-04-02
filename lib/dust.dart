import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DustScreen extends StatefulWidget {
  const DustScreen({super.key});

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
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sunny,
                  size: 50,
                ),
                Text(
                  '매우 나쁨',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                )
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
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        color: Color(0xff000000),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(height: 10,),
                Column(
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(width: 70,),
                        Text('미세먼지 (PM 10)')
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Icon(Icons.sunny,
                          size: 50,),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: 0.5,  // 50% 채워짐
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(width: 70,),
                        Text('초미세먼지 (PM 2.5)')
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Icon(Icons.sunny,
                          size: 50,),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: 0.5,
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(width: 70,),
                        Text('오존 (03)')
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Icon(Icons.sunny,
                          size: 50,),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: 0.5,
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(width: 70,),
                        Text('이산화질소 (NO2)')
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Icon(Icons.sunny,
                          size: 50,),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: 0.5,  // 50% 채워짐
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(width: 70,),
                        Text('일산화탄소 (CO)')
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Icon(Icons.sunny,
                          size: 50,),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: 0.5,
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(width: 70,),
                        Text('아황산가스 (SO2)')
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Icon(Icons.sunny,
                          size: 50,),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            height: 10,
                            child: LinearProgressIndicator(
                              value: 0.5,
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(width: 60,),
                        Container(
                          width: 20, // 원의 너비
                          height: 20, // 원의 높이
                          decoration: BoxDecoration(
                            color: Colors.blueAccent, // 원의 색상
                            shape: BoxShape.circle, // 원 모양 설정
                          ),
                        ),
                        SizedBox(width: 10), // 원과 텍스트 사이의 간격
                        Text(
                          "좋음", // 텍스트 내용
                          style: TextStyle(
                            fontSize: 16, // 텍스트 크기
                            color: Colors.black, // 텍스트 색상
                          ),
                        ),
                        SizedBox(width: 15,),
                        Container(
                          width: 20, // 원의 너비
                          height: 20, // 원의 높이
                          decoration: BoxDecoration(
                            color: Colors.green, // 원의 색상
                            shape: BoxShape.circle, // 원 모양 설정
                          ),
                        ),
                        SizedBox(width: 10), // 원과 텍스트 사이의 간격
                        Text(
                          "보통", // 텍스트 내용
                          style: TextStyle(
                            fontSize: 16, // 텍스트 크기
                            color: Colors.black, // 텍스트 색상
                          ),
                        ),
                        SizedBox(width: 15,),
                        Container(
                          width: 20, // 원의 너비
                          height: 20, // 원의 높이
                          decoration: BoxDecoration(
                            color: Colors.yellowAccent, // 원의 색상
                            shape: BoxShape.circle, // 원 모양 설정
                          ),
                        ),
                        SizedBox(width: 10), // 원과 텍스트 사이의 간격
                        Text(
                          "나쁨", // 텍스트 내용
                          style: TextStyle(
                            fontSize: 16, // 텍스트 크기
                            color: Colors.black, // 텍스트 색상
                          ),
                        ),
                        SizedBox(width: 15,),
                        Container(
                          width: 20, // 원의 너비
                          height: 20, // 원의 높이
                          decoration: BoxDecoration(
                            color: Colors.red, // 원의 색상
                            shape: BoxShape.circle, // 원 모양 설정
                          ),
                        ),
                        SizedBox(width: 10), // 원과 텍스트 사이의 간격
                        Text(
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
          ]
          ),
        ));
  }
}