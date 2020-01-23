import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  static String tag = 'register';
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
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
                          "Register Form",
                          style:
                              TextStyle(fontSize: 50, fontFamily: 'AcmeFont'),
                              textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 30),
                        TextField(
                          style: TextStyle(color: Colors.black, fontSize: 15),
                          controller: nameController,
                          decoration: InputDecoration(
                              labelText: 'Full Name',
                              hintText: 'Enter your full name'),
                        ),
                        TextField(
                          style: TextStyle(color: Colors.black, fontSize: 15),
                          controller: usernameController,
                          decoration: InputDecoration(
                              labelText: 'Username',
                              hintText: 'Enter your username'),
                        ),
                        TextField(
                          style: TextStyle(color: Colors.black, fontSize: 15),
                          controller: emailController,
                          decoration: InputDecoration(
                              labelText: 'Email', hintText: 'Enter your email'),
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
                            "Register",
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
