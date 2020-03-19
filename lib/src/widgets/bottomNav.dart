import 'package:flutter/material.dart';

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
        _navigate('home');
        break;
      case 1:
        _navigate('debts');
        break;
      case 2:
        _navigate('people');
        break;
    }
  }

  void _navigate(String route) {
    Navigator.pushReplacementNamed(context, route, arguments: _selectedIndex);
  }
}
