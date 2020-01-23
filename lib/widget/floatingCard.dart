import 'package:flutter/material.dart';

class FloatingCard extends StatelessWidget {
  final List<Widget> children;

  FloatingCard({@required this.children});
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView(children: children),
        ));
  }
}
