import 'package:flutter/material.dart';

class MainBackground extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final bool gradient;
  MainBackground({@required this.child, this.padding, this.gradient});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/seamless-bg.jpg"),
                fit: BoxFit.cover)),
        child: child);
  }
}
