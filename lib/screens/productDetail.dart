import 'package:carousel_pro/carousel_pro.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ibuy/screens/byCategory.dart';
import 'package:ibuy/utils/getServer.dart';
import 'package:ibuy/widget/background.dart';
import 'package:ibuy/widget/floatingCard.dart';
import 'package:ibuy/widget/marqueeWidget.dart';
import 'package:intl/intl.dart';

class ProductDetail extends StatefulWidget {
  final Map<String, dynamic> product;
  ProductDetail({@required this.product});
  _ProductDetailState createState() => _ProductDetailState(product: product);
}

class _ProductDetailState extends State<ProductDetail> {
  final Map<String, dynamic> product;
  _ProductDetailState({@required this.product});
  final NumberFormat moneyFormat = new NumberFormat("#,##0", "en_US");
  bool getCategory = false;
  bool isLoading = true;
  List<List> fromCategory = [];
  Dio dio = new Dio();

  void setCategory(data) {
    setState(() {
      fromCategory = data;
    });
  }

  Widget build(BuildContext context) {
    if (!getCategory) {
      setState(() {
        getCategory = true;
      });
      getConfig()
          .then((cfg) => cfg['server'])
          .then((server) => {
                for (var i = 0; i < product['categories'].length; i++)
                  {
                    dio
                        .get(
                            '$server/catalogue?category=${product['categories'][i]}')
                        .then((res) => res.data)
                        .then((data) =>
                            {fromCategory.add(data), setCategory(fromCategory)})
                  }
              })
          .then((v) {
        setState(() {
          isLoading = false;
        });
      });
    }

    Widget categoryList(List category, int curIndex) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Material(
              elevation: 10,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Sugested from category ${product['categories'][curIndex]}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ByCategory(
                                  category: product['categories'][curIndex]))),
                      child: Text(
                        'More >>',
                        style: TextStyle(color: Colors.black54),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.all(5),
                    itemCount: category.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var product = category[index];
                      if (index < 5)
                        return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetail(
                                            product: product,
                                          )));
                            },
                            child: FloatingCard(
                                useListView: false,
                                margin: EdgeInsets.only(right: 10),
                                children: <Widget>[
                                  Row(
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
                                      SizedBox(
                                        width: 200,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              product['title'],
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
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
                                                            TextDecoration
                                                                .lineThrough,
                                                        color: Colors.red),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Material(
                                                    elevation: 5,
                                                    color: Colors.orange,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
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
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: product['categories']
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  var category =
                                                      product['categories']
                                                          [index];
                                                  return Container(
                                                      margin: EdgeInsets.only(
                                                          right: 5),
                                                      child: Material(
                                                        color: Colors.black26,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.all(5),
                                                          child: Text(
                                                            category,
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                      ));
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ]));
                    })),
          ],
        ),
      );
    }

    Widget body() {
      return MainBackground(
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: Carousel(
                  images: product['image']
                      .map((image) => Image.network(image))
                      .toList(),
                  dotSize: 4.0,
                  dotSpacing: 15.0,
                  dotColor: Colors.black,
                  indicatorBgPadding: 5.0,
                  dotBgColor: Colors.black54,
                  borderRadius: false,
                ),
              ),
            ),
            Material(
              elevation: 10,
              child: Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              product['title'],
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Rp. ${moneyFormat.format(product['price'] - ((product['price'] * (product['discount'] ?? 0)) / 100))},-',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                          ),
                          if ((product['discount'] ?? 0) > 0)
                            Text(
                              'Rp. ${moneyFormat.format(product['price'])},-',
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Color(0xffff0000)),
                            ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 25,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: product['categories'].length,
                              itemBuilder: (context, index) {
                                var category = product['categories'][index];
                                return Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: Material(
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        margin: EdgeInsets.all(5),
                                        child: Text(
                                          category,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ));
                              },
                            ),
                          )
                        ],
                      ),
                      if ((product['discount'] ?? 0) > 0)
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Material(
                            elevation: 5,
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                              margin: EdgeInsets.all(5),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    '${product['discount']}%',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xffff0000)),
                                  ),
                                  Text(
                                    'OFF',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  )),
            ),
            SizedBox(
              height: 5,
            ),
            Material(
              elevation: 10,
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Description',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(product['description']),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Text('Stock: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(product['stock'].toString()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Material(
              elevation: 10,
              child: Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        Icons.person,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(product['owner'])
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200.0 * fromCategory.length,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: fromCategory.length,
                      itemBuilder: (context, index) {
                        List category = fromCategory[index];
                        return categoryList(category, index);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add to Cart',
        child: Icon(Icons.add),
      ),
    );
  }
}
