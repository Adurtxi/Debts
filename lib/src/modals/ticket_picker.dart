import 'package:flutter/material.dart';

class TicketPickerModal {
  mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _createTile(context, 'Camara', Icons.camera, _camera),
              _createTile(context, 'Galería', Icons.photo_album, _galery),
            ],
          );
        });
  }

  ListTile _createTile(
      BuildContext context, String name, IconData icon, Function action) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      onTap: () {
        Navigator.pop(context);
        action(context);
      },
    );
  }

  _camera(BuildContext context) {
    print(1);
  }

  _galery(BuildContext context) {
    print(2);
  }
}
