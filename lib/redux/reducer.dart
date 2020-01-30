import 'dart:convert';

import 'package:dio/dio.dart';

import 'app_state.dart';    
import 'actions.dart';

AppState reducer(AppState prevState, dynamic action) {
  AppState newState = AppState.copyWith(prevState);
  if (action is LoadingProccess) {
    newState.loading = true;
  } else if (action is SetUser) {
    newState.firstname = action.firstname;
    newState.lastname = action.lastname;
    newState.email = action.email;
    newState.password = action.password;
    newState.username = action.username;
    newState.loading = false;
  } else if (action is FinishLoading) {
    newState.loading = false;
  } else if (action is SetCart) {
    newState.cart = action.cart;
    newState.loading = false;
  }
  return newState;
}
