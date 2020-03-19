import 'package:flutter/material.dart';

class MyAppBar extends AppBar {
  MyAppBar({Key key, Widget title, String user, BuildContext context})
      : super(
            key: key,
            backgroundColor: Colors.white,
            title: title,
            centerTitle: true,
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'account');
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: CircleAvatar(
                    child: Text(user),
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
            ]);
}
