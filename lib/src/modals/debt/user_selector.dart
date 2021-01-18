import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:debts/src/blocs/user/user_bloc.dart';
import 'package:debts/src/models/follower_model.dart';

import 'package:debts/src/widgets/utils/error.dart';
import 'package:debts/src/widgets/utils/loader.dart';
import 'package:debts/src/widgets/utils/message.dart';

// ignore: must_be_immutable
class UserSelectorModal {
  List<FollowerModel> allUsers = [];

  List<FollowerModel> sUsers = [];

  bool start = true;

  final _controller = TextEditingController();

  mainBottomSheet(BuildContext context) {
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
            child: _usersContainer(context, state),
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
              decoration: InputDecoration(
                hintText: 'Nombre de usuario',
              ),
              onChanged: (value) => state(() => sUsers = allUsers
                  .where((c) => c.followed.name.toLowerCase().contains(value.toLowerCase()))
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

  Widget _usersContainer(BuildContext context, Function state2) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) => {},
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) => (state.followersState == 0)
              ? LoaderW(size: 30)
              : (state.followersState == -1)
                  ? ErrorW()
                  : _usersBuilder(userBloc, state.followers),
        ),
      ),
    );
  }

  Widget _usersBuilder(UserBloc userBloc, List<FollowerModel> followers) {
    if (start) {
      allUsers = followers;
      sUsers = allUsers;

      start = false;
    }

    if (allUsers == null) {
      return Message(message: 'No tienes contactos');
    }

    return ListView.builder(
      itemCount: sUsers.length,
      itemBuilder: (context, i) => Column(
        children: <Widget>[
          _userContainer(context, i),
        ],
      ),
    );
  }

  Widget _userContainer(BuildContext context, int i) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: GestureDetector(
        onTap: () => _selectUser(context, i),
        child: ListTile(
          leading: _leading(i),
          title: Text(sUsers[i].followed.name + ' ' + sUsers[i].followed.surname),
        ),
      ),
    );
  }

  Widget _leading(int i) {
    return Container(
      margin: EdgeInsets.all(7.5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Image(
          image: NetworkImage(sUsers[i].followed.image),
        ),
      ),
    );
  }

  void _selectUser(BuildContext context, int i) {
    BlocProvider.of<UserBloc>(context).add(
      UserSelect(sUsers[i].followed),
    );

    Navigator.pop(context);
  }
}
