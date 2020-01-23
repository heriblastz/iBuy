import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:ibuy/redux/app_state.dart';

class SetUser {
  final String email;
  final String password;
  SetUser({this.email, this.password});
}

class GetMessage {}

class LoginAction extends ReduxAction<AppState>{
  final String email;
  final String password;
  LoginAction({this.email, this.password});

  @override
  FutureOr<AppState> reduce() {
    // TODO: implement reduce
    return null;
  }
}