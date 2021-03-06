import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ibuy/redux/app_state.dart';
import 'package:ibuy/redux/reducer.dart';
import 'package:ibuy/screens/bottomBar.dart';
import 'package:ibuy/screens/cart.dart';
import 'package:ibuy/screens/landing.dart';
import 'package:ibuy/screens/login.dart';
import 'package:ibuy/screens/register.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  final _initialState = AppState();
  final Store<AppState> _store = Store<AppState>(reducer,
      initialState: _initialState, middleware: [thunkMiddleware]);
  runApp(MyApp(store: _store));
}

class MyApp extends StatelessWidget {
  Store<AppState> store;
  MyApp({this.store});
  final routes = <String, WidgetBuilder>{
    Landing.tag: (context) => Landing(),
    BottomBar.tag: (context) => BottomBar(),
    Register.tag: (context) => Register(),
    Login.tag: (context) => Login(),
    Cart.tag: (context) => Cart()
  };

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'iBuy',
        theme: ThemeData(
            primaryColor: Color(0xffffffff), brightness: Brightness.light, accentColor: Colors.black),
        home: Landing(),
        routes: routes,
      ),
    );
  }
}
