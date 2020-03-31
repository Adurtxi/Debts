import 'package:flutter/material.dart';

import 'package:epbasic_debts/src/widgets/slideTransition.dart';

import 'package:epbasic_debts/src/pages/debt/debts_page.dart';
import 'package:epbasic_debts/src/pages/home_page.dart';
import 'package:epbasic_debts/src/pages/user/people_page.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final selectedIndexData = ModalRoute.of(context).settings.arguments;

    if (selectedIndexData != null) {
      _selectedIndex = selectedIndexData;
    }

    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Container(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.money_off),
          title: Container(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          title: Container(),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (_selectedIndex) {
      case 0:
        Navigator.pushReplacement(context, SlideRightRoute(page: HomePage()));
        break;
      case 1:
        Navigator.pushReplacement(context, SlideRightRoute(page: DebtsPage()));
        break;
      case 2:
        Navigator.pushReplacement(context, SlideRightRoute(page: PeoplePage()));
        break;
    }
  }
}
