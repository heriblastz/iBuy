import 'package:flutter/material.dart';

class FloatingCard extends StatelessWidget {
  final List<Widget> children;
  final bool useListView;
  final EdgeInsets margin;
  final EdgeInsets padding;

  FloatingCard(
      {@required this.children,
      @required this.useListView,
      this.margin,
      this.padding});
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      child: Material(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          elevation: 10,
          child: Container(
            padding: EdgeInsets.all(20),
            child: useListView
                ? ListView(children: children)
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children),
          )),
    );
  }
}
