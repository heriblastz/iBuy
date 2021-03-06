import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ibuy/redux/actions.dart';
import 'package:ibuy/screens/login.dart';
import 'package:ibuy/utils/getServer.dart';
import 'package:ibuy/validators/utils.dart';
import 'package:ibuy/widget/acmeFont.dart';
import 'package:ibuy/widget/background.dart';
import 'package:ibuy/widget/blackButton.dart';
import 'package:ibuy/widget/floatingCard.dart';
import 'package:ibuy/widget/loadingCard.dart';
import 'package:ibuy/widget/secTheme.dart';
import 'package:ibuy/redux/app_state.dart';

class Register extends StatefulWidget {
  static String tag = 'register';
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final FocusNode nameFocus = FocusNode();
  final FocusNode usernameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _passwordHide = true;
  bool isLoading = false;

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    void _onPressRegister() async {
      setLoading(true);
      List<String> separateName = nameController.text.split(' ');
      Map<String, String> payload = {
        "username": usernameController.text,
        "firstname": separateName[0],
        "lastname":
            separateName.where((text) => text != separateName[0]).join(" "),
        "email": emailController.text,
        "password": passwordController.text
      };
      String uri = (await getConfig())["server"];
      Dio dio = Dio();
      await dio.post('$uri/register', data: payload).then((res) {
        setLoading(false);
        alertDialog(
            title: "Success",
            message: "Account has been created, please login with your account",
            context: context,
            closeAction: () => Navigator.of(context)
              ..pop()
              ..pushReplacementNamed(Login.tag));
      }).catchError((err) {
        setLoading(false);
        alertDialog(
            title: "Failed",
            message: err.response.data["message"],
            context: context,
            closeAction: () => Navigator.of(context).pop());
      });
    }

    Widget body(AppState store) {
      return SecTheme(
        child: MainBackground(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: FloatingCard(
                useListView: true,
                children: <Widget>[
                  SizedBox(height: 20),
                  AcmeTitle(text: "Register Form"),
                  SizedBox(height: 30),
                  TextFormField(
                    focusNode: nameFocus,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                    controller: nameController,
                    validator: (val) => Val.ValidateName(val),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(usernameFocus);
                    },
                    decoration: InputDecoration(
                        labelText: 'Full Name',
                        hintText: 'Enter your full name'),
                  ),
                  TextFormField(
                    focusNode: usernameFocus,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                    controller: usernameController,
                    validator: (val) => Val.ValidateUsername(val),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(emailFocus);
                    },
                    decoration: InputDecoration(
                        labelText: 'Username', hintText: 'Enter your username'),
                  ),
                  TextFormField(
                    focusNode: emailFocus,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (val) => Val.ValidateEmail(val),
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(passwordFocus);
                    },
                    decoration: InputDecoration(
                        labelText: 'Email', hintText: 'Enter your email'),
                  ),
                  TextFormField(
                    focusNode: passwordFocus,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                    obscureText: _passwordHide,
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    validator: (val) => Val.ValidatePassword(val),
                    decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        suffixIcon: InkWell(
                          borderRadius: BorderRadius.circular(50),
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
                    title: "Register",
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPress: () {
                      if (_formKey.currentState.validate()) {
                        _onPressRegister();
                      }
                    },
                  ),
                ],
              ),
            )),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        resizeToAvoidBottomInset: false,
        body: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, store) {
            return isLoading ? LoadingCard() : body(store);
          },
        ));
  }
}
