import 'package:flutter/material.dart';

import 'package:epbasic_debts/src/widgets/slideTransition.dart';

import 'package:epbasic_debts/src/pages/debt/debts_page.dart';
import 'package:epbasic_debts/src/pages/home_page.dart';
import 'package:epbasic_debts/src/pages/user/people_page.dart';
import 'package:epbasic_debts/src/blocs/provider.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    final _navBarBloc = Provider.navBarBloc(context);

    return StreamBuilder(
      stream: _navBarBloc.currentPage,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        int currentPage;

        if (snapshot.data == null) {
          currentPage = 0;
        } else {
          currentPage = snapshot.data;
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
          currentIndex: currentPage,
          selectedItemColor: Colors.blue,
          onTap: (int index) {
            _navBarBloc.changePage(index);
            _onItemTapped(index);
          },
        );
      },
    );
  }

  void _onItemTapped(int index) {
    switch (index) {
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
