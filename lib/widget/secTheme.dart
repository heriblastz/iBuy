import 'package:flutter/material.dart';

class SecTheme extends StatelessWidget {
  final Widget child;
  SecTheme({@required this.child});
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
            primaryColor: Colors.black,
            hintColor: Colors.black54,
            focusColor: Colors.black),
        child: child);
  }
}
