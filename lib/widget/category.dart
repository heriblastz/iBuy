import 'package:flutter/material.dart';
import 'package:ibuy/screens/byCategory.dart';

class Category extends StatelessWidget {
  final IconData icon;
  final String title;
  Category({@required this.icon, @required this.title});
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: SizedBox(
          child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ByCategory(category: title))),
        child: Column(
          children: <Widget>[
            Icon(icon),
            Text(
              title,
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      )),
    );
  }
}
