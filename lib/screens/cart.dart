import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ibuy/redux/actions.dart';
import 'package:ibuy/redux/app_state.dart';
import 'package:ibuy/widget/background.dart';
import 'package:ibuy/widget/blackButton.dart';
import 'package:ibuy/widget/category.dart';
import 'package:ibuy/widget/loadingCard.dart';
import 'package:ibuy/utils/getServer.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class Cart extends StatefulWidget {
  static String tag = 'cart';
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final NumberFormat moneyFormat = new NumberFormat("#,##0", "en_US");
  TextEditingController quantityController = new TextEditingController();
  bool isLoading = true;
  bool hasGet = false;
  Dio dio = new Dio();
  int total = 0;
  int inputQuantity = 0;

  String price(Map<String, dynamic> product) {
    return moneyFormat.format(product['price'] -
        (product['price'] * (product['discount'] ?? 0) / 100));
  }

  void addTotal(int price) {
    setState(() {
      total = total + price;
    });
  }

  void _onPressAdd(int id, AppState store) async {
    if (!store.loading && inputQuantity == 0) {
      await StoreProvider.of<AppState>(context)
          .dispatch(addProduct(id, context));
    }
  }

  void _onPressRemove(int id, AppState store) async {
    if (!store.loading && inputQuantity == 0) {
      await StoreProvider.of<AppState>(context)
          .dispatch(removeProduct(id, context));
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget quantity(Map<String, dynamic> product, AppState store) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.25,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              onTap: () => _onPressRemove(product['id'], store),
              child: Icon(
                Icons.remove,
                color: (store.loading || inputQuantity != 0) ? Colors.black54 : Colors.black,
              ),
            ),
            SizedBox(
                width: 50,
                height: 50,
                child: inputQuantity == product['id']
                    ? TextField(
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        controller: quantityController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                        ],
                        onSubmitted: (v) {
                          if (int.parse(v) < 1) {
                            alertDialog(
                                title: 'Alert',
                                message: 'Quantity must more than 0 (zero)',
                                context: context,
                                closeAction: () => Navigator.of(context).pop());
                          } else {
                            setState(() {
                              inputQuantity = 0;
                            });
                            StoreProvider.of<AppState>(context).dispatch(
                                customProduct(
                                    product['id'], context, int.parse(v)));
                          }
                        },
                      )
                    : Center(
                        child: InkWell(
                          child: Text(
                            product['quantity'].toString(),
                            style: TextStyle(fontSize: 17),
                          ),
                          onTap: () {
                            if (inputQuantity == 0 && !store.loading) {
                              quantityController.text =
                                  product['quantity'].toString();
                              setState(() {
                                inputQuantity = product['id'];
                              });
                            } else if (store.loading) {
                            } else {
                              alertDialog(
                                  title: 'Alert',
                                  message: 'Submit another form first',
                                  context: context,
                                  closeAction: () =>
                                      Navigator.of(context).pop());
                            }
                          },
                        ),
                      )),
            InkWell(
              onTap: () => _onPressAdd(product['id'], store),
              child: Icon(
                Icons.add,
                color: (store.loading || inputQuantity != 0) ? Colors.black54 : Colors.black,
              ),
            ),
          ],
        ),
      );
    }

    Widget cartList(AppState store) {
      return Expanded(
        flex: 1,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 3000,
          child: ListView.builder(
            itemCount: store.cart.length,
            itemBuilder: (context, index) {
              var product = store.cart[index];
              return Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Material(
                    color: Colors.white,
                    elevation: 10,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.network(
                              product['image'][0],
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    product['title'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    'by ' + product['owner'],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54),
                                  ),
                                  Text('Rp.${price(product)},-',
                                      style:
                                          TextStyle(color: Color(0xff00aa00))),
                                  quantity(product, store)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              );
            },
          ),
        ),
      );
    }

    Widget header() {
      return Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left: 14, top: 14, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Choose all",
                style: TextStyle(fontSize: 16),
              ),
              Text("remove")
            ],
          ));
    }

    Widget footer(AppState store) {
      return Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text("Total",
                      style: TextStyle(fontSize: 15, color: Colors.grey)),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                      "Rp.${moneyFormat.format(store.cart == null ? 0 : (store.cart).map((x) => (x['price'] - ((x['price'] * (x['discount'] ?? 0)) / 100)) * x['quantity']).reduce((a, b) => a + b))},-",
                      style: TextStyle(fontSize: 20, color: Colors.black87)),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            BlackButton(
              title: "bayar",
            )
          ],
        ),
      );
    }

    Widget body(AppState store) {
      return store.cart.isEmpty
          ? Text('empty')
          : Column(children: <Widget>[cartList(store), footer(store)]);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Shopping Cart",
            style: TextStyle(fontSize: 25, color: Colors.black87),
          ),
        ),
        body: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, store) {
            if (!(store.loading ?? false) && store.cart == null) {
              StoreProvider.of<AppState>(context)
                  .dispatch(refreshCart(context));
            }

            return MainBackground(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // header(),
                  store.cart == null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(),
                            )
                          ],
                        )
                      : Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 1000,
                            width: MediaQuery.of(context).size.width,
                            child: body(store),
                          ),
                        ),
                ],
              ),
            );
          },
        ));
  }
}
