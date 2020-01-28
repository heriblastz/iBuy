import 'package:flutter/material.dart';
import 'package:ibuy/widget/background.dart';
import 'package:ibuy/widget/floatingCard.dart';
import 'package:ibuy/widget/secTheme.dart';

class LoadingCard extends StatelessWidget {
  final bool useCard;
  LoadingCard({this.useCard});

  Widget build(BuildContext context) {
    return SecTheme(
      child: useCard ?? true
          ? FloatingCard(
              useListView: false,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[CircularProgressIndicator()],
                )
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[CircularProgressIndicator()],
                )
              ],
            ),
    );
  }
}
