import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<dynamic> getConfig() async {
  final String config = await rootBundle.loadString('assets/configs/server.json');
  return jsonDecode(config);
}