
import 'package:flutter/material.dart';
import 'package:ibuy/widget/category.dart';
import 'package:ibuy/widget/loadingCard.dart';
import 'package:ibuy/utils/getServer.dart';
import 'package:dio/dio.dart';


class Cart extends StatefulWidget {
  static String tag = 'cart';
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
 
  bool isLoading = true;
  bool hasGet = false;
  Dio dio = new Dio();
  List catalogue = [];

  setCatalogue(List data) {
    setState(() {
      catalogue = data;
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
        .get('$server/catalogue?category=Groceries')
        .then((res) => res.data)
        .then((data) => {
          print(data),
          setCatalogue(data)
        }));
  }

  Widget createCartList(List allData){
  return ListView.builder(
    shrinkWrap: true,
    itemCount: allData.length,
    itemBuilder: (context,index){
      var data = allData[index];
      return Stack(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: 200,
                  height: 200,
                   margin: EdgeInsets.all(8),
                   decoration: BoxDecoration(
                     color: Colors.white,
                     image: DecorationImage(
                       image: NetworkImage("${data['image'][0]}")
                     ),
                     ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(7.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 8,top: 5),
                          child: Text('${data['title']}', 
                                style: TextStyle(fontSize: 14),
                          ),
                        ),
                          Container(
                            child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Rp. ${(data['price'])}",
                                style: TextStyle(fontSize: 20, color: Colors.greenAccent),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(7.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Icon(
                                        Icons.remove,
                                        size: 20,
                                        color: Colors.black87,
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                        bottom: 2, right: 12, left: 12),
                                        child: Text("1"),
                                      ),
                                      Icon(
                                         Icons.add,
                                        color: Colors.black87,
                                        size: 20,)
                                    ],
                                  ),
                                  
                                )
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      );
    },
  );
}

Widget body() {
  return createCartList(
              catalogue,
            );
}


    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart",
        style: TextStyle(fontSize: 25, color: Colors.black87),
        ),
      ),
      body: body()
        );
  }
}
