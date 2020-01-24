import 'package:flutter/material.dart';
import 'package:ibuy/widget/background.dart';
import 'package:ibuy/widget/category.dart';
import 'package:ibuy/widget/circleFloatingContainer.dart';
import 'package:ibuy/widget/floatingCard.dart';
import 'package:ibuy/widget/searchBar.dart';

class Catalogue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: MainBackground(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            SearchBar(),
            SizedBox(height: 10),
            FloatingCard(
                  useListView: false,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Category(icon: Icons.phone_android, title: 'Phone'),
                            Category(icon: Icons.laptop, title: 'Laptop'),
                            Category(icon: Icons.lightbulb_outline, title: 'Electricity'),
                            Category(icon: Icons.local_activity, title: 'Ticket')
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: <Widget>[
                            Category(icon: Icons.live_tv, title: 'Subscription'),
                            Category(icon: Icons.local_airport, title: 'Travel'),
                            Category(icon: Icons.local_dining, title: 'Food'),
                            Category(icon: Icons.local_offer, title: 'Discount')
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: <Widget>[
                            Category(icon: Icons.motorcycle, title: 'Automotive'),
                            Category(icon: Icons.store_mall_directory, title: 'Groceries'),
                            Category(icon: Icons.train, title: 'Train'),
                            Category(icon: Icons.verified_user, title: 'Insurance')
                          ],
                        )
                      ],
                    )
                  ],
                ),
          ],
        ),
      ),
    ));
  }
}
