import 'package:flutter/material.dart';

class Catalogue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      child:  ListView(
       children: <Widget>[
          TextFormField(
          style: TextStyle(fontSize: 20, color: Colors.black45),
          decoration: InputDecoration(
            labelText: "search",
            labelStyle: TextStyle(color: Colors.black),
            prefixIcon: Icon(Icons.search, color: Colors.blue),
            suffixIcon:  IconButton(
                icon: Icon(Icons.shopping_basket),
                color: Colors.grey,
                onPressed: () =>{}
             )
          ),
        ),
      
        //  Container(
        //    child: Row(children: <Widget>[
        //      IconButton(
        //         icon: Icon(Icons.shopping_basket),
        //         color: Colors.grey,
        //         onPressed: () =>{}
        //      )
        //    ]
        //    )
        //    )          
       ],
     ),
      )
  

    );
  }
}