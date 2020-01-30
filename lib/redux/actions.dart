import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ibuy/redux/app_state.dart';
import 'package:ibuy/screens/login.dart';
import 'package:ibuy/utils/getServer.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class SetUser {
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String username;
  SetUser(
      {this.firstname,
      this.lastname,
      this.email,
      this.password,
      this.username});
}

class LoadingProccess {}

ThunkAction<AppState> userLogin(payload, context) {
  return (Store<AppState> store) async {
    store.dispatch(LoadingProccess());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("UserDetail", jsonEncode(payload));
    store.dispatch(SetUser(
        email: payload['email'],
        password: payload['password'],
        firstname: payload['firstname'],
        lastname: payload['lastname'],
        username: payload['username']));
  };
}

class FinishLoading {}

// ThunkAction<AppState> addCart(int id, BuildContext context) {
//   return (Store<AppState> store) async {
//     if (!store.state.loading) {
//       store.dispatch(LoadingProccess());
//       Dio dio = new Dio();
//       Map<String, dynamic> payload = {
//         "email": store.state.email,
//         "password": store.state.password,
//         "id": id
//       };
//       dio
//           .post('http://worlddemo.herokuapp.com/cart/new', data: payload)
//           .then((res) => res.data)
//           .then((data) => {
//                 if (data['success'])
//                   {
//                     store.dispatch(FinishLoading()),
//                     alertDialog(
//                         title: 'Success',
//                         message: 'Product added to your Cart',
//                         context: context,
//                         closeAction: () {
//                           Navigator.of(context).pop();
//                         })
//                   }
//                 else
//                   {
//                     store.dispatch(FinishLoading()),
//                     store.dispatch(AddCartFailed(message: data['message'])),
//                     alertDialog(
//                         title: 'Failed',
//                         message: data['message'],
//                         context: context,
//                         closeAction: () {
//                           Navigator.of(context).pop();
//                         })
//                   }
//               })
//           .catchError((err) => {
//                 store.dispatch(FinishLoading()),
//                 alertDialog(
//                     title: 'Failed',
//                     message: err.response.data['message'],
//                     context: context,
//                     closeAction: () {
//                       Navigator.of(context).pop();
//                     })
//               });
//     }
//   };
// }

class SetCart {
  final List cart;
  SetCart({this.cart});
}

ThunkAction<AppState> refreshCart(BuildContext context) {
  return (Store<AppState> store) async {
    store.dispatch(LoadingProccess());
    Dio dio = new Dio();
    try {
      final String server = (await getConfig())['server'];
      List cart = (await dio.post('$server/cart', data: {
        "email": store.state.email,
        "password": store.state.password
      }))
          .data;
      store.dispatch(SetCart(cart: cart));
    } catch (err) {
      alertDialog(
          title: 'Failed',
          message: err.response.data['message'],
          context: context,
          closeAction: () {
            Navigator.of(context).pop();
          });
    }
  };
}

ThunkAction<AppState> addProduct(int id, BuildContext context) {
  return (Store<AppState> store) async {
    if (!store.state.loading) {
      store.dispatch(LoadingProccess());
      Dio dio = new Dio();
      Map<String, dynamic> payload = {
        "email": store.state.email,
        "password": store.state.password,
        "id": id
      };
      dio
          .post('http://worlddemo.herokuapp.com/cart/new', data: payload)
          .then((res) => res.data)
          .then((data) => {
                if (data['success'])
                  {
                    store.dispatch(refreshCart(context)),
                  }
                else
                  {
                    store.dispatch(FinishLoading()),
                    alertDialog(
                        title: 'Failed',
                        message: data['message'],
                        context: context,
                        closeAction: () {
                          Navigator.of(context).pop();
                        })
                  }
              })
          .catchError((err) => {
                store.dispatch(FinishLoading()),
                alertDialog(
                    title: 'Failed',
                    message: err.response.data['message'],
                    context: context,
                    closeAction: () {
                      Navigator.of(context).pop();
                    })
              });
    }
  };
}

ThunkAction<AppState> removeProduct(int id, BuildContext context) {
  return (Store<AppState> store) async {
    if (!store.state.loading) {
      store.dispatch(LoadingProccess());
      Dio dio = new Dio();
      Map<String, dynamic> payload = {
        "email": store.state.email,
        "password": store.state.password,
        "id": id
      };
      dio
          .post('http://worlddemo.herokuapp.com/cart/remove', data: payload)
          .then((res) => res.data)
          .then((data) => {
                if (data['success'])
                  {
                    store.dispatch(refreshCart(context)),
                  }
                else
                  {
                    store.dispatch(FinishLoading()),
                    alertDialog(
                        title: 'Failed',
                        message: data['message'],
                        context: context,
                        closeAction: () {
                          Navigator.of(context).pop();
                        })
                  }
              })
          .catchError((err) => {
                store.dispatch(FinishLoading()),
                alertDialog(
                    title: 'Failed',
                    message: err.response.data['message'],
                    context: context,
                    closeAction: () {
                      Navigator.of(context).pop();
                    })
              });
    }
  };
}

ThunkAction<AppState> customProduct(int id, BuildContext context, int quantity) {
  return (Store<AppState> store) async {
    if (!store.state.loading) {
      store.dispatch(LoadingProccess());
      Dio dio = new Dio();
      Map<String, dynamic> payload = {
        "email": store.state.email,
        "password": store.state.password,
        "id": id,
        "quantity": quantity
      };
      dio
          .post('http://worlddemo.herokuapp.com/cart/custom', data: payload)
          .then((res) => res.data)
          .then((data) => {
                if (data['success'])
                  {
                    store.dispatch(refreshCart(context)),
                  }
                else
                  {
                    store.dispatch(FinishLoading()),
                    alertDialog(
                        title: 'Failed',
                        message: data['message'],
                        context: context,
                        closeAction: () {
                          Navigator.of(context).pop();
                        })
                  }
              })
          .catchError((err) => {
                store.dispatch(FinishLoading()),
                alertDialog(
                    title: 'Failed',
                    message: err.response.data['message'],
                    context: context,
                    closeAction: () {
                      Navigator.of(context).pop();
                    })
              });
    }
  };
}
