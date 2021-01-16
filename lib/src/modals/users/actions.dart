import 'package:flutter/material.dart';

class UserActionsModal {
  mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _createTile(
            context,
            'Opcion 1',
            Icons.title,
            Colors.red[700],
          ),
          _createTile(
            context,
            'Opcion 1',
            Icons.title,
            Colors.red[700],
          ),
          _createTile(
            context,
            'Opcion 1',
            Icons.title,
            Colors.red[700],
          ),
          _createTile(
            context,
            'Opcion 1',
            Icons.title,
            Colors.red[700],
          ),
        ],
      ),
    );
  }

  ListTile _createTile(BuildContext context, String name, IconData icon, Color color) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(name),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
