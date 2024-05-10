import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
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
                  fontFamily: 'tmon',
                  fontSize: 20.0,
                  color: Colors.black87
              ),
            )
          ],
        ),
      ),
    );
  }
}