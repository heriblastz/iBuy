import 'package:flutter/material.dart';

class CircleFloatingContainer extends StatelessWidget {
  final Widget child;
  CircleFloatingContainer({this.child});
  Widget build(BuildContext context) {
    return Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(50),
        color: Colors.white,
        child: Container(padding: EdgeInsets.all(5), child: child));
  }
}
