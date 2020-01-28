import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<dynamic> getConfig() async {
  final String config =
      await rootBundle.loadString('assets/configs/server.json');
  return jsonDecode(config);
}

alertDialog(
    {String title,
    String message,
    BuildContext context,
    Function closeAction}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [FlatButton(child: Text("Close"), onPressed: closeAction)],
        );
      });
}
