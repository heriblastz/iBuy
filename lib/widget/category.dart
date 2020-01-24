import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final IconData icon;
  final String title;
  Category({@required this.icon, @required this.title});
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: SizedBox(
        child: Column(
          children: <Widget>[Icon(icon), Text(title, style: TextStyle(fontSize: 12),)],
        ),
      ),
    );
  }
}
