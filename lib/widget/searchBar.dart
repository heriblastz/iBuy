import 'package:flutter/material.dart';
import 'package:ibuy/screens/cart.dart';
import 'package:ibuy/screens/searchResult.dart';
import 'package:ibuy/widget/circleFloatingContainer.dart';

class SearchBar extends StatefulWidget {
  final BuildContext context;
  final String value;
  final bool back;

  SearchBar({@required this.context, this.value, this.back});

  _SearchBarState createState() =>
      _SearchBarState(context: context, value: value, back: back ?? false);
}

class _SearchBarState extends State<SearchBar> {
  final BuildContext context;
  final bool back;
  String value;
  _SearchBarState({@required this.context, this.value, this.back});
  TextEditingController searchController = new TextEditingController();
  bool valueSet = false;

  Widget build(BuildContext context) {
    if (!valueSet) {
      searchController.text = value ?? '';
      setState(() {
        valueSet = true;
      });
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        if (back)
          SizedBox(
            height: 50,
            width: 50,
            child: CircleFloatingContainer(
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        SizedBox(width: 5),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 50,
            child: CircleFloatingContainer(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    )),
                textInputAction: TextInputAction.search,
                onSubmitted: (val) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchResult(
                                query: val,
                              )));
                },
              ),
            ),
          ),
        ),
        SizedBox(width: 5),
        SizedBox(
          height: 50,
          width: 50,
          child: CircleFloatingContainer(
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.of(context).pushNamed(Cart.tag);
              },
              child: Icon(
                Icons.local_grocery_store,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
