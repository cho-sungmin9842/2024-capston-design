import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {

  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFF73D5FF), Color(0xFFBED5DE)],
          ),
        ),
        child: Stack(
          children: [
            const Positioned(
              left: 159,
              top: 65,
              child: SizedBox(
                width: 202,
                height: 30,
                child: Text(
                  '즐겨찾는 위치',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 32,
              top: 203,
              child: Container(
                width: 329,
                height: 129,
                decoration: ShapeDecoration(
                  color: Colors.white.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 53,
              top: 263,
              child: SizedBox(
                width: 47,
                height: 47,
                child: Stack(children: []),
              ),
            ),
            const Positioned(
              left: 48,
              top: 216,
              child: SizedBox(
                width: 129,
                child: Text(
                  '잠실야구장',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 32,
              top: 353,
              child: Container(
                width: 329,
                height: 129,
                decoration: ShapeDecoration(
                  color: Colors.white.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 32,
              top: 503,
              child: Container(
                width: 329,
                height: 129,
                decoration: ShapeDecoration(
                  color: Colors.white.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 49,
              top: 559.51,
              child: SizedBox(
                width: 59,
                height: 51.93,
                child: Stack(children: []),
              ),
            ),
            const Positioned(
              left: 48,
              top: 366,
              child: SizedBox(
                width: 179,
                child: Text(
                  '대구삼성\n라이온즈파크',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 48,
              top: 516,
              child: SizedBox(
                width: 179,
                child: Text(
                  '창원NC파크',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 316,
              top: 216,
              child: SizedBox(
                width: 29,
                height: 29,
                child: Stack(children: []),
              ),
            ),
            const Positioned(
              left: 234,
              top: 225,
              child: Text(
                '9°',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 64,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            const Positioned(
              left: 205,
              top: 380,
              child: Text(
                '12°',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 64,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            const Positioned(
              left: 205,
              top: 528,
              child: Text(
                '14°',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 64,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            Positioned(
              left: 32,
              top: 114,
              child: Container(
                width: 329,
                height: 59,
                decoration: ShapeDecoration(
                  color: Colors.white.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(34),
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 51,
              top: 128,
              child: SizedBox(
                width: 129,
                child: Text(
                  '찾는 위치...',
                  style: TextStyle(
                    color: Color(0xFF787878),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 21,
              top: 58,
              child: SizedBox(
                width: 32,
                height: 32,
                child: Stack(children: []),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
