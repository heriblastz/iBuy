import 'package:flutter/material.dart';
import 'package:ibuy/validators/utils.dart';
import 'package:ibuy/widget/acmeFont.dart';
import 'package:ibuy/widget/background.dart';
import 'package:ibuy/widget/blackButton.dart';
import 'package:ibuy/widget/floatingCard.dart';
import 'package:ibuy/widget/secTheme.dart';

class Login extends StatefulWidget {
  static String tag = 'login';
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  bool _passwordHide = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        resizeToAvoidBottomInset: false,
        body: SecTheme(
          child: MainBackground(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: FloatingCard(
                  useListView: true,
                  children: <Widget>[
                    SizedBox(height: 20),
                    AcmeTitle(
                      text: "Login Form",
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      focusNode: emailFocus,
                      style: TextStyle(color: Colors.black),
                      validator: (val) => Val.ValidateEmail(val),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).requestFocus(passwordFocus);
                      },
                      decoration: InputDecoration(
                          labelText: 'Email or Username',
                          hintText: 'Enter your email or username'),
                    ),
                    TextFormField(
                      focusNode: passwordFocus,
                      style: TextStyle(color: Colors.black),
                      obscureText: _passwordHide,
                      controller: passwordController,
                      textInputAction: TextInputAction.done,
                      validator: (val) => Val.ValidatePassword(val),
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
                    BlackButton(
                      title: "Login",
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPress: () {
                        if (_formKey.currentState.validate()) {
                          // _onPressRegister();
                        }
                      },
                    )
                  ],
                ),
              )),
        ));
  }
}
