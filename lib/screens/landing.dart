import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ibuy/redux/actions.dart';
import 'package:ibuy/redux/app_state.dart';
import 'package:ibuy/widget/background.dart';
import 'package:ibuy/screens/bottomBar.dart';

class Landing extends StatelessWidget {
  static String tag = "landing";

  @override
  Widget build(BuildContext context) {
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
              onPressed: () => Navigator.of(context).pushReplacementNamed(BottomBar.tag),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.white,
              elevation: 10,
              child: Text("Get Started", style: TextStyle(fontWeight: FontWeight.bold),),
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
