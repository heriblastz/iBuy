import 'package:flutter/material.dart';
import 'package:ibuy/screens/catalogue.dart';
import 'package:ibuy/screens/message.dart';
import 'package:ibuy/screens/profile.dart';
import 'package:ibuy/screens/transaction.dart';

class BottomBar extends StatefulWidget {
  static String tag = 'main-page';

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      Catalogue(),
      Transaction(),
      Message(),
      Profile()
    ];

    final bottomNav = new Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
        ),
        child: new BottomNavigationBar(
          onTap: _onTabTapped,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black38,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.book),
              title: new Text('Catalogue'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.swap_horiz),
              title: new Text('Transaction'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.mail), title: Text('Message')),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text('Profile'))
          ],
        ));

    return Scaffold(
        body: _children[_currentIndex], bottomNavigationBar: bottomNav);
  }
}
