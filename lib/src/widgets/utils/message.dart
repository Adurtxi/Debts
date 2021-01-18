import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String message;

  Message({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(message),
      ),
    );
  }
}
