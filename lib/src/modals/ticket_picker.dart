import 'package:epbasic_debts/src/blocs/provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class TicketPickerModal {
  File ticket;

  mainBottomSheet(BuildContext context) {
    final _debtsBloc = Provider.debtsBloc(context);

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _createTile(context, 'Camara', Icons.camera, _camera, _debtsBloc),
              _createTile(
                  context, 'Galería', Icons.photo_album, _galery, _debtsBloc),
            ],
          );
        });
  }

  ListTile _createTile(BuildContext context, String name, IconData icon,
      Function action, DebtsBloc _debtsBloc) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      onTap: () {
        Navigator.pop(context);
        action(context, _debtsBloc);
      },
    );
  }

  _camera(BuildContext context, DebtsBloc _debtsBloc) {
    _processImage(ImageSource.camera, _debtsBloc);
  }

  _galery(BuildContext context, DebtsBloc _debtsBloc) {
    _processImage(ImageSource.gallery, _debtsBloc);
  }

  _processImage(ImageSource origin, DebtsBloc _debtsBloc) async {
    ticket = await ImagePicker.pickImage(
      source: origin,
    );

    _debtsBloc.uploadTicket(ticket);
  }
}
