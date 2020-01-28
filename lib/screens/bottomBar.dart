import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
  GlobalKey _bottomNavigationKey = GlobalKey();

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

    final Widget animatedNav = new CurvedNavigationBar(
      backgroundColor: Colors.black87,
      height: 50,
      key: _bottomNavigationKey,
      items: <Widget>[
        Icon(Icons.book, size: 30),
        Icon(Icons.swap_horiz, size: 30),
        Icon(Icons.mail, size: 30),
        Icon(Icons.person, size: 30),
      ],
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );

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
        body: _children[_currentIndex], bottomNavigationBar: animatedNav);
  }
}
