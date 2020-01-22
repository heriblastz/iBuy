import 'dart:convert';

import 'package:dio/dio.dart';

import 'app_state.dart';
import 'actions.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.copyWith(prevState);
  Dio dio = new Dio();
  final String server = 'http://worlddemo.herokuapp.com';
  if (action is SetUser) {
    newState.email = action.email;
    newState.password = action.password;
  } else if (action is GetMessage) {
    dio
        .get(server)
        .then((res) => res.data)
        .then((data) => {print(data), newState.message = data["message"]})
        .catchError(print);
  }
  return newState;
}
