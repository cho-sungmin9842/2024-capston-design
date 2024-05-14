import 'package:flutter/material.dart';

import 'constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(0.0,-1.0),
              end: Alignment(0,1),
              colors: [Color(0xff73d5ff), Color(0xffbed5de)]
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                      Icons.arrow_back_ios,
                      size: 40.0,
                      color: Colors.indigoAccent
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget> [
                  Flexible(
                      child:Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          style: const TextStyle(color: Colors.black),
                          decoration: kTextFieldInputDecoration,
                          onChanged: (value) {
                            cityName = value;
                          },
                        ),
                      )
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, cityName);
                      },
                      child: const Icon(
                        Icons.search,
                        color: Colors.indigoAccent,
                        size: 40.0,
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}