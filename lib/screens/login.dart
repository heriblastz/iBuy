import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ibuy/redux/actions.dart';
import 'package:ibuy/redux/app_state.dart';
import 'package:ibuy/utils/getServer.dart';
import 'package:ibuy/validators/utils.dart';
import 'package:ibuy/widget/acmeFont.dart';
import 'package:ibuy/widget/background.dart';
import 'package:ibuy/widget/blackButton.dart';
import 'package:ibuy/widget/floatingCard.dart';
import 'package:ibuy/widget/loadingCard.dart';
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
  bool isLoading = false;

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    void _onPressLogin() async {
      setLoading(true);
      Map<String, String> payload = {
        "email": emailController.text,
        "password": passwordController.text
      };
      String uri = (await getConfig())["server"];
      Dio dio = new Dio();
      await dio.post('$uri/login', data: payload).then((res) {
        setLoading(false);
        StoreProvider.of<AppState>(context)
            .dispatch(userLogin(res.data['detail'], context));
        alertDialog(
            title: "Success",
            message: "You have successfully login",
            context: context,
            closeAction: () => Navigator.of(context)..pop()..pop());
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
            child: isLoading
                ? LoadingCard()
                : Form(
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
                          validator: (val) => Val.ValidateEmailUsername(val),
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
                          title: "Login",
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPress: () {
                            if (_formKey.currentState.validate()) {
                              _onPressLogin();
                            }
                          },
                        )
                      ],
                    ),
                  )),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        resizeToAvoidBottomInset: false,
        body: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, store) {
            return body(store);
          },
        ));
  }
}
