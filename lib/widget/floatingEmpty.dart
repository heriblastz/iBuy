import 'package:flutter/material.dart';
import 'package:ibuy/widget/background.dart';
import 'package:ibuy/widget/floatingCard.dart';

class FloatingEmpty extends StatelessWidget {
  Widget build(BuildContext context) {
    return FloatingCard(
      useListView: false,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Icon(Icons.sentiment_neutral, color: Colors.black54, size: 200),
                Text(
                  'Whoops...',
                  style: TextStyle(
                      fontSize: 50,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Nothing result can we show',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
