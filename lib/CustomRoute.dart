import 'package:flutter/material.dart';

class CustomRoute<T> extends MaterialPageRoute<T> {

  CustomRoute({ required WidgetBuilder builder })
      : super(builder: builder);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {

    return FadeTransition(opacity: animation, child: child);
  }
}