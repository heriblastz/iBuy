import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  static String tag = 'cart';
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text('Cart'),
    );
  }
}
