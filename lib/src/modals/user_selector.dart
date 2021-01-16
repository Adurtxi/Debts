import 'package:debts/src/blocs/user/user_bloc.dart';
import 'package:flutter/material.dart';

import 'package:debts/src/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class UserSelectorModal {
  List<UserModel> allUsers = [
    UserModel(id: 1, name: 'Adur Marques'),
    UserModel(id: 2, name: 'Noe Sliva'),
    UserModel(id: 3, name: 'Jon Calvo'),
    UserModel(id: 4, name: 'Iker Sanz'),
    UserModel(id: 5, name: 'Jon Vidaurre'),
  ];

  List<UserModel> sUsers;

  bool start = true;

  final _controller = TextEditingController();

  mainBottomSheet(BuildContext context) {
    (start)
        ? sUsers = allUsers
        : sUsers = allUsers
            .where((c) => c.name.toLowerCase().contains(_controller.text.toLowerCase()))
            .toList();

    start = false;

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) => _container(context),
    );
  }

  Widget _container(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return StatefulBuilder(
      builder: (BuildContext context, state) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            height: size.height * 0.5,
            margin: EdgeInsets.all(20.0),
            child: _column(context, state, size),
          ),
        );
      },
    );
  }

  Widget _column(BuildContext context, Function state, size) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: Text(
            'Seleccionar usuario',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _searchInput(context, state),
        Expanded(
          child: Container(
            height: size.height * 0.6,
            child: _usersContainer(),
          ),
        ),
      ],
    );
  }

  Widget _searchInput(BuildContext context, state) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              controller: _controller,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Nombre de usuario',
              ),
              onChanged: (value) => state(() => sUsers = allUsers
                  .where((c) => c.name.toLowerCase().contains(value.toLowerCase()))
                  .toList()),
            ),
          ),
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => state(() => _controller.text = ''),
          ),
        ],
      ),
    );
  }

  Widget _usersContainer() {
    return ListView.builder(
      itemCount: sUsers.length,
      itemBuilder: (context, i) => Column(
        children: <Widget>[
          _userContainer(context, i),
        ],
      ),
    );
  }

  Widget _userContainer(BuildContext context, i) {
    return ListTile(
      leading: Icon(Icons.copyright, color: Colors.black),
      title: Text(sUsers[i].name),
      onTap: () {
        BlocProvider.of<UserBloc>(context).add(
          UserSelect(sUsers[i]),
        );

        Navigator.pop(context);
      },
    );
  }
}
