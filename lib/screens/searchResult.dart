import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ibuy/utils/getServer.dart';
import 'package:ibuy/widget/background.dart';
import 'package:ibuy/widget/floatingEmpty.dart';
import 'package:ibuy/widget/loadingCard.dart';
import 'package:ibuy/widget/productList.dart';
import 'package:ibuy/widget/searchBar.dart';

class SearchResult extends StatefulWidget {
  final String query;
  SearchResult({this.query});
  _SearchState createState() => _SearchState(query);
}

class _SearchState extends State<SearchResult> {
  final String query;
  _SearchState(this.query);
  Dio dio = new Dio();
  bool hasGet = false;
  bool isLoading = true;
  List product;
  setProduct(List data) {
    setState(() {
      product = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!hasGet && isLoading) {
      setState(() {
        hasGet = true;
      });
      getConfig().then((cfg) => cfg['server']).then((server) => dio
          .get('$server/catalogue?q=$query')
          .then((res) => res.data)
          .then((data) => {setProduct(data)}));
    }

    Widget body() {
      return (product ?? []).isEmpty
          ? MainBackground(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child: SearchBar(
                        context: context,
                        value: query,
                        back: true,
                      )),
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: isLoading
                            ? LoadingCard(
                                useCard: true,
                              )
                            : FloatingEmpty(),
                      ))
                ],
              ))
          : ProductList(
              products: product,
              showBar: true,
              value: query,
            );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: body(),
    );
  }
}
