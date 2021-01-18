import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String message;

  Message({@required this.message});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ListView(
        children: [
          Container(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Center(
              child: Text(message),
            ),
          )
        ],
      ),
    );
  }
}
