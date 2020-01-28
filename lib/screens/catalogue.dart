import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ibuy/redux/app_state.dart';
import 'package:ibuy/screens/byCategory.dart';
import 'package:ibuy/widget/background.dart';
import 'package:ibuy/widget/category.dart';
import 'package:ibuy/widget/circleFloatingContainer.dart';
import 'package:ibuy/widget/floatingCard.dart';
import 'package:ibuy/widget/loadingCard.dart';
import 'package:ibuy/widget/searchBar.dart';

class Catalogue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget body(AppState store) {
      return MainBackground(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  SearchBar(
                    context: context,
                  ),
                  SizedBox(height: 10),
                  FloatingCard(
                    useListView: false,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Category(
                                  icon: Icons.phone_android, title: 'Phone'),
                              Category(icon: Icons.laptop, title: 'Laptop'),
                              Category(
                                  icon: Icons.lightbulb_outline,
                                  title: 'Electricity'),
                              Category(
                                  icon: Icons.local_activity, title: 'Ticket')
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              Category(
                                  icon: Icons.live_tv, title: 'Subscription'),
                              Category(
                                  icon: Icons.local_airport, title: 'Travel'),
                              Category(icon: Icons.local_dining, title: 'Food'),
                              Category(
                                  icon: Icons.local_offer, title: 'Discount')
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              Category(
                                  icon: Icons.motorcycle, title: 'Automotive'),
                              Category(
                                  icon: Icons.store_mall_directory,
                                  title: 'Groceries'),
                              Category(icon: Icons.train, title: 'Train'),
                              Category(
                                  icon: Icons.verified_user, title: 'Insurance')
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FloatingCard(
                    useListView: false,
                    children: <Widget>[
                      CarouselSlider(
                        height: 150.0,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        items: [
                          'asus-banner.jpg',
                          'empty-banner.png',
                          'food-banner.jpg',
                          'yakult-banner.jpg'
                        ].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset('assets/images/$i',
                                        fit: BoxFit.fill),
                                  ));
                            },
                          );
                        }).toList(),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    // Widget catalogueList

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, store) {
            return body(store);
          },
        ));
  }
}
