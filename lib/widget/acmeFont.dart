import 'package:flutter/material.dart';

class AcmeTitle extends StatelessWidget {
  final String text;
  AcmeTitle({@required this.text});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 50, fontFamily: 'AcmeFont'),
      textAlign: TextAlign.center,
    );
  }
}
