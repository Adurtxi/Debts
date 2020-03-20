import 'package:flutter/material.dart';

class MyAppBar extends AppBar {
  MyAppBar({Key key, Widget title, String user, BuildContext context})
      : super(key: key, title: title, centerTitle: true, actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, 'account');
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: CircleAvatar(
                child: Text(
                  user,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.blue,
              ),
            ),
          ),
        ]);
}
