
import 'package:flutter/material.dart';
import 'package:ibuy/widget/blackButton.dart';
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
//      int _currentIndex =0;
     int itemCount =0;
void add (){
  return
  setState(() {
    itemCount ++;
  });
  
}
void minus(){
  setState(() {
    if(itemCount !=0){
      itemCount --;
    }
    else(
      new Container()
    );
  
  });
}

  return ListView.builder(
    shrinkWrap: true,
    itemCount: allData.length,
    itemBuilder: (context,index){
      var data = allData[index];
    return  Column(
           children: <Widget>[
          Container(
               margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Row(
              children: <Widget>[
               Container(
                  width: 100,
                  height: 100,
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('${data['title']}', 
                              style: TextStyle(fontSize: 20), ),
                              //Icon(Icons.restore_from_trash)
                            ]
                          ) 
                        ),
                          Container(
                            child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Rp. ${(data['price'])}",
                                style: TextStyle(fontSize: 16, color: Colors.greenAccent),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(7.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                   FloatingActionButton(
                                     onPressed: minus,
                                      child: new Icon(Icons.remove, color: Colors.black,),
                                      backgroundColor: Colors.white,
                                    
                                     ),
                              
                                  Container(
                                    color: Colors.grey.shade200,
                                    padding: const EdgeInsets.only(
                                        bottom: 2, right: 12, left: 12),
                                    child: Text( "$itemCount",
                                     //itemCount.toString(),
                                      style: TextStyle(fontSize: 15)     
                                    ),
                                  ),
                                  FloatingActionButton(
                                     onPressed: add,
                                      child: new Icon(Icons.add, color: Colors.black,),
                                      backgroundColor: Colors.white,
                                     ),
                             
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

Widget header(){
  return Container(
    alignment: Alignment.topLeft ,
    margin: EdgeInsets.only(left: 14, top: 14, right: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text("Choose all",style: TextStyle(fontSize: 16),),
        Text("remove")
      ],
      ) 
    );
}

Widget body() {
  return createCartList(
              catalogue,
            );
}

Widget footer(){
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
     
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
             margin:EdgeInsets.only(left: 10),
              child: Text("Total belanja", style: TextStyle(fontSize: 15,color:Colors.grey)),
            ),
             Container(
             margin:EdgeInsets.only(left: 10),
              child: Text("Rp. 5676", style: TextStyle(fontSize: 20,color:Colors.black87)),
            )
          ],
        ),
        SizedBox( height: 20,),
        BlackButton(
           title: "bayar",
        )
      ],
    ),
    );

}

    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart",
        style: TextStyle(fontSize: 25, color: Colors.black87),
        ),
      ),
      body: Builder(
        builder: (context){
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              header(),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 1000,
                  width: MediaQuery.of(context).size.width,
                  child: body(),
                ),
              ),
              footer()

          ],);
        },

      ) 
        );
  }
}
