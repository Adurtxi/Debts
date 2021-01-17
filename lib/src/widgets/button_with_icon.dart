import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class ButtonWithIcon extends StatelessWidget {
  final double size;
  final String text;
  final IconData icon;
  final bool loading;

  ButtonWithIcon({
    @required this.size,
    @required this.text,
    this.icon,
    @required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    Widget widget = Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      ),
    );

    if (icon != null) {
      Widget iconWidget = Icon(icon, color: Colors.white);

      if (loading) {
        iconWidget = SpinKitChasingDots(
          color: Colors.white,
          size: 20.0,
        );
      }

      widget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: iconWidget,
          ),
        ],
      );
    }

    return Ink(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.black87,
        ),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * size),
        alignment: Alignment.center,
        child: widget,
      ),
    );
  }
}
