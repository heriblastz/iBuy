import 'package:flutter/material.dart';

class FloatingCard extends StatelessWidget {
  final List<Widget> children;
  final bool useListView;

  FloatingCard({@required this.children, @required this.useListView});
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(20),
          child: useListView
              ? ListView(children: children)
              : Column(
                  children: children
                ),
        ));
  }
}
