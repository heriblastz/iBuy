import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ibuy/redux/app_state.dart';
import 'package:ibuy/screens/login.dart';
import 'package:ibuy/screens/register.dart';
import 'package:ibuy/widget/blackButton.dart';
import 'package:ibuy/widget/loadingCard.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget unlogged() {
      return Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.person,
                size: 200,
                color: Colors.black54,
              ),
              Text("You haven't login",
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 25)),
              Text("Please login or create account",
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
              SizedBox(
                height: 15,
              ),
              Container(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    BlackButton(
                      title: 'Login',
                      onPress: () => Navigator.of(context).pushNamed(Login.tag),
                    ),
                    BlackButton(
                      title: 'Register',
                      onPress: () =>
                          Navigator.of(context).pushNamed(Register.tag),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget logged(AppState store) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: 25,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 70,
                  height: 70,
                  child: Material(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 70,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${store.firstname} ${store.lastname}',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        store.username,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black54),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 1000,
              child: Container(
                color: Colors.black12,
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Email',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                          Text(store.email),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                          Text(
                            'change your password',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Address',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                          store.address == null
                              ? Text(
                                  'add your address',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                )
                              : Text(store.address),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      );
    }

    return Scaffold(
      body: StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, store) {
          return store.loading ?? false
              ? LoadingCard()
              : store.email == null ? unlogged() : logged(store);
        },
      ),
    );
  }
}
