import 'dart:async';

// import 'package:async_redux/async_redux.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ibuy/redux/app_state.dart';
import 'package:ibuy/screens/login.dart';
import 'package:ibuy/utils/getServer.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class SetUser {
  final String email;
  final String password;
  SetUser({this.email, this.password});
}

class GetMessage {}

class LoadingProccess{}
class RegisterSuccess{
  final dynamic data;
  RegisterSuccess({this.data});
}

class RegisterFailed{
  final dynamic data;
  RegisterFailed({this.data});
}

ThunkAction<AppState> registerUser(payload, context) {
  return (Store<AppState> store) async {
    store.dispatch(LoadingProccess());
    String uri = (await getConfig())["server"];
    Dio dio = Dio();
    await dio.post('$uri/register', data: payload).then((res) {
      if (res.data['statusCode'] == 200) {
        store.dispatch(RegisterSuccess(data: res.data['result']));
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Login.tag, (Route<dynamic> route) => false);
      } else {
   
        store.dispatch(RegisterFailed(data: res.data['message']));
      }
    }).catchError((onError) {
      store.dispatch(RegisterFailed(data: "Error While registering"));
    });
  };
} 

// class LoginAction extends ReduxAction<AppState>{
//   final String email;
//   final String password;
//   LoginAction({this.email, this.password});

//   @override
//   FutureOr<AppState> reduce() {
//     // TODO: implement reduce
//     return null;
//   }
// }