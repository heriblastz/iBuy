import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ibuy/redux/actions.dart';
import 'package:ibuy/redux/app_state.dart';
import 'package:ibuy/widget/background.dart';
import 'package:ibuy/screens/bottomBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landing extends StatefulWidget {
  static String tag = "landing";
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  bool checked = false;

  void initialingState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("UserDetail");
    if (user != null) {
      Map userJson = jsonDecode(prefs.getString("UserDetail"));
      StoreProvider.of<AppState>(context).dispatch(SetUser(
          email: userJson["email"],
          password: userJson["password"],
          username: userJson["username"],
          firstname: userJson["firstname"],
          lastname: userJson["lastname"]));
      Navigator.of(context).pushReplacementNamed(BottomBar.tag);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!checked) {
      setState(() {
        checked = true;
      });
      initialingState();
    }
    Widget body(AppState store) {
      return MainBackground(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "iBuy",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.4,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'AcmeFont'),
            ),
            RaisedButton(
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed(BottomBar.tag),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.white,
              elevation: 10,
              child: Text(
                "Get Started",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        )),
      );
    }

    return Scaffold(
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, store) {
          return body(store);
        },
      ),
    );
  }
}
