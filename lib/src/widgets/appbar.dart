import 'package:flutter/material.dart';

class AppBarW extends AppBar {
  AppBarW({Key key, String title, BuildContext context})
      : super(
          key: key,
          title: Text(
            title,
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person),
              iconSize: 26.0,
              onPressed: () {},
            ),
          ],
        );
}
