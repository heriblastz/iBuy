import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  static String tag = 'login';
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {    
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool _passwordHide = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: Theme(
          data: Theme.of(context).copyWith(
              primaryColor: Colors.black,
              hintColor: Colors.black54,
              focusColor: Colors.black),
          child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/seamless-bg.jpg"),
                      fit: BoxFit.cover)),
              padding: EdgeInsets.all(20),
              child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  elevation: 10,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: ListView(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Text(
                          "Login Form",
                          style:
                              TextStyle(fontSize: 50, fontFamily: 'AcmeFont'),
                              textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30),
                        TextField(
                          style: TextStyle(color: Colors.black, fontSize: 15),
                          controller: emailController,
                          decoration: InputDecoration(
                              labelText: 'Email or Username', hintText: 'Enter your email or username'),
                        ),
                        TextField(
                          style: TextStyle(color: Colors.black, fontSize: 15),
                          obscureText: _passwordHide,
                          controller: passwordController,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter your password',
                              suffixIcon: InkWell(
                                child: Icon(_passwordHide
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onTap: () {
                                  setState(() {
                                    _passwordHide = !_passwordHide;
                                  });
                                },
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 10,
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.black,
                        )
                      ],
                    ),
                  ))),
        ));
  }
}
