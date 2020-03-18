import 'package:flutter/material.dart';

class MyAppBar extends AppBar {
  MyAppBar({Key key, Widget title, String user})
      : super(
            key: key,
            backgroundColor: Colors.white,
            title: title,
            centerTitle: true,
            actions: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: CircleAvatar(
                  child: Text(user),
                  backgroundColor: Colors.blue,
                ),
              ),
            ]);
}
