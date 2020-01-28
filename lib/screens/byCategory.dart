import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ibuy/utils/getServer.dart';
import 'package:ibuy/widget/background.dart';
import 'package:ibuy/widget/floatingCard.dart';
import 'package:ibuy/widget/floatingEmpty.dart';
import 'package:ibuy/widget/loadingCard.dart';
import 'package:ibuy/widget/productList.dart';

class ByCategory extends StatefulWidget {
  final String category;
  ByCategory({this.category});
  _CategoryState createState() => _CategoryState(category);
}

class _CategoryState extends State<ByCategory> {
  final String category;
  _CategoryState(this.category);
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
          .get('$server/catalogue?category=$category')
          .then((res) => res.data)
          .then((data) => {setProduct(data)}));
    }

    Widget body() {
      return (product ?? []).isEmpty
          ? MainBackground(
              padding: EdgeInsets.all(20),
              child: isLoading
                  ? LoadingCard(
                      useCard: false,
                    )
                  : FloatingEmpty(),
            )
          : ProductList(
              products: product,
            );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: body(),
    );
  }
}
