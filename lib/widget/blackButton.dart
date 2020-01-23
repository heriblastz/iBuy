import 'package:flutter/material.dart';

class BlackButton extends StatelessWidget {
  final String title;
  final ShapeBorder shape;
  final Function onPress;
  BlackButton({this.title, this.shape, this.onPress});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPress,
      shape: shape,
      elevation: 5,
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.black,
    );
  }
}
