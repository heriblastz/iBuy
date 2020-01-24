import 'dart:convert';

import 'package:dio/dio.dart';

import 'app_state.dart';
import 'actions.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.copyWith(prevState);
  switch (action) {
    case LoadingProccess:
    print("proccess");
      newState.loading = true;
      break;
    case RegisterSuccess:
      print("success");
      newState.loading = false;
      break;
    case RegisterFailed:
      newState.loading = false;
      print("failed");
      break;
  }
  return newState;
}
