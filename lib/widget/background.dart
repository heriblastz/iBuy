import 'package:flutter/material.dart';

class MainBackground extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  MainBackground({@required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/seamless-bg.jpg"),
                fit: BoxFit.cover)),
        padding: padding,
        child: child);
  }
}
