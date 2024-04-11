import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color(0xff75E6F7),  //appBar 투명색
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          '추가정보',
          style: TextStyle(
             fontSize: 20.0, color: Colors.black87),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); //뒤로가기
          },
        ),
      ),
      body: ListView(
        children: [
          const Divider(
            color: Colors.black38,
            thickness: 1,
          ),
          InkWell(
            onTap: () {
              _showDustDialog(context);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 40,
              child: const Text(
                '미세먼지/초미세먼지 등급 기준',
                style: TextStyle(
                    fontSize: 15.0, color: Colors.black87,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.black38,
            thickness: 1,
          ),
          InkWell(
            onTap: () {
              _showPollutionDialog(context);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 40,
              child: const Text(
                '오존/이산화질소/일산화탄소/아황산가스 등급 기준',
                style: TextStyle(
                  fontSize: 15.0, color: Colors.black87,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.black38,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}

void _showDustDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
          title: const Text(
            "미세먼지 / 초미세먼지 등급 기준",
            style: TextStyle(
                fontFamily: 'tmon', fontSize: 20.0, color: Colors.black87),
          ),
          content: const SingleChildScrollView(
            child: Text(
              '''
미세먼지(PM-10)
   -좋음 0~30
   -보통 31~80
   -나쁨 81~150
   -매우나쁨 151 이상
            
초미세먼지(PM-25)
   -좋음 0~15
   -보통 16~35
   -나쁨 36~75
   -매우나쁨 76 이상
            
단위: ㎍/㎥
            
환경부 에어코리아 제공         
            ''',
              style: TextStyle(fontSize: 20.0, color: Colors.black87),
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              child: const Text("닫기"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)));
    },
  );
}

void _showPollutionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
          title: const Text(
            "오존/이산화질소/일산화탄소/아황산가스 등급 기준",
            style: TextStyle(
                fontFamily: 'tmon', fontSize: 20.0, color: Colors.black87),
          ),
          content: const SingleChildScrollView(
            child: Text(
              '''
오존(O₃)
   -좋음 0~0.03
   -보통 0.031~0.09
   -나쁨 0.091~0.15
   -매우나쁨 0.151 이상
            
이산화질소(NO₂)
   -좋음 0~0.03
   -보통 0.031~0.06
   -나쁨 0.061~0.2
   -매우나쁨 0.201 이상
            
일산화탄소(CO)
   -좋음 0~2
   -보통 2.01~9.0
   -나쁨 9.01~15.0
   -매우나쁨 15.01 이상
   
아황산가스(SO₂)
   -좋음 0~0.02
   -보통 0.021~0.05
   -나쁨 0.051~0.15
   -매우나쁨 0.151 이상
   
단위: ppm
            
환경부 에어코리아 제공       
            ''',
              style: TextStyle(fontSize: 20.0, color: Colors.black87),
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              child: const Text("닫기"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)));
    },
  );
}