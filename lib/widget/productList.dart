import 'package:flutter/material.dart';
import 'package:ibuy/widget/background.dart';
import 'package:ibuy/widget/floatingCard.dart';
import 'package:ibuy/widget/marqueeWidget.dart';
import 'package:ibuy/widget/searchBar.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';

class ProductList extends StatelessWidget {
  final List products;
  final bool showBar;
  final String value;
  final NumberFormat moneyFormat = new NumberFormat("#,##0", "en_US");
  ProductList({this.products, this.showBar, this.value});
  Widget build(BuildContext context) {
    return MainBackground(
        child: Column(
      children: <Widget>[
        if (showBar ?? false)
          Container(
            padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            child: SearchBar(
              context: context,
              back: true,
              value: value,
            ),
          ),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 1000,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  var product = products[index];
                  return FloatingCard(
                    useListView: false,
                    margin: EdgeInsets.only(bottom: 10),
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.network(
                              product['image'],
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              width: 500,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  MarqueeWidget(
                                    direction: Axis.horizontal,
                                    child: Text(
                                      product['title'],
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    'Rp. ${moneyFormat.format(product['price'] - ((product['price'] * (product['discount'] ?? 0)) / 100))},-',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  if ((product['discount'] ?? 0) > 0)
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Rp. ${moneyFormat.format(product['price'])},-',
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.red),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Material(
                                          elevation: 5,
                                          color: Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Container(
                                            margin: EdgeInsets.all(5),
                                            child: Text(
                                                '-${product['discount']}%'),
                                          ),
                                        )
                                      ],
                                    ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    height: 25,
                                    width: 200,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: product['categories'].length,
                                      itemBuilder: (context, index) {
                                        var category =
                                            product['categories'][index];
                                        return Container(
                                            margin: EdgeInsets.only(right: 5),
                                            child: Material(
                                              color: Colors.black26,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                margin: EdgeInsets.all(5),
                                                child: Text(
                                                  category,
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ),
                                            ));
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                }),
          ),
        )
      ],
    ));
  }
}
