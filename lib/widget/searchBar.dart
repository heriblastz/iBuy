import 'package:flutter/material.dart';
import 'package:ibuy/widget/circleFloatingContainer.dart';

class SearchBar extends StatelessWidget {
  Widget build(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 50,
                    child: CircleFloatingContainer(
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search',
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black,
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: CircleFloatingContainer(
                    child: Icon(
                      Icons.local_grocery_store,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                    height: 50,
                    width: 50,
                    child: CircleFloatingContainer(
                      child: Icon(
                        Icons.chat_bubble,
                        color: Colors.black,
                      ),
                    ))
              ],
            );
  }
}