import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffffff),
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0)
          ),
          backgroundColor: Colors.lightBlue,
          onPressed: (){
            //onPressed Actions
          },
          child: Icon(Icons.add, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment(0.0,-1.0),
                  end: Alignment(0,1),
                  colors: [Color(0xff73d5ff), Color(0xffbed5de)]
              )
          ),
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.white.withOpacity(0.5)
                ),
                alignment: Alignment.centerLeft,
                height: 60, width: 350,
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: Text("위치 검색...",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black.withOpacity(0.3)
                  ),),
              ),
              const Padding(padding: EdgeInsets.fromLTRB(0, 80, 200, 500),
                child: Text(
                  "즐겨찾는 위치",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 0),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      height: 130, width: 330,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white.withOpacity(0.5)
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: const Column(
                        children: [
                          SizedBox(
                            child: Text(
                              "Forecast data here",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black87,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 130, width: 330,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white.withOpacity(0.5)
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: const Column(
                        children: [
                          SizedBox(
                            child: Text(
                              "Forecast data here",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black87,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 130, width: 330,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white.withOpacity(0.5)
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: const Column(
                        children: [
                          SizedBox(
                            child: Text(
                              "Forecast data here",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black87,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
