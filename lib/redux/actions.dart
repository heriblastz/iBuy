import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ibuy/redux/app_state.dart';
import 'package:ibuy/screens/login.dart';
import 'package:ibuy/utils/getServer.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class SetUser {
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String username;
  SetUser(
      {this.firstname,
      this.lastname,
      this.email,
      this.password,
      this.username});
}

class GetMessage {}

class LoadingProccess {}

class RegisterSuccess {
  final dynamic data;
  RegisterSuccess({this.data});
}

class RegisterFailed {
  final dynamic data;
  RegisterFailed({this.data});
}

class CleanMessage {}

ThunkAction<AppState> userLogin(payload, context) {
  return (Store<AppState> store) async {
    store.dispatch(LoadingProccess());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("UserDetail", jsonEncode(payload));
    store.dispatch(SetUser(
        email: payload['email'],
        password: payload['password'],
        firstname: payload['firstname'],
        lastname: payload['lastname'],
        username: payload['username']));
  };
}
