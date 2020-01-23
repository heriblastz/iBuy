import 'package:flutter/material.dart';
import 'package:ibuy/screens/login.dart';
import 'package:ibuy/screens/register.dart';

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
                    RaisedButton(
                      elevation: 5,
                      color: Colors.white,
                      child: Text("Login"),
                      onPressed: () => Navigator.of(context).pushNamed(Login.tag),
                    ),
                    RaisedButton(
                      elevation: 5,
                      color: Colors.white,
                      child: Text("Register"),
                      onPressed: () => Navigator.of(context).pushNamed(Register.tag),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    return unlogged();
  }
}
