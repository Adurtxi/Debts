import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:debts/src/blocs/user/user_bloc.dart';

import 'package:debts/src/widgets/appbar.dart';
import 'package:debts/src/widgets/drawer.dart';
import 'package:debts/src/widgets/user/user_card.dart';

import 'package:debts/src/widgets/utils/message.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return Scaffold(
      drawer: DrawerW(),
      appBar: AppBarW(
        title: 'Usuarios',
      ),
      body: _body(context, userBloc),
    );
  }

  Widget _body(BuildContext context, UserBloc userBloc) {
    userBloc.add(UserSearchRestart());

    return Container(
      child: _container(context, userBloc),
    );
  }

  Widget _container(BuildContext context, UserBloc userBloc) {
    return Column(
      children: [
        _searchInput(context, userBloc),
        _usersContainer(context, userBloc),
      ],
    );
  }

  Widget _searchInput(BuildContext context, UserBloc userBloc) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar',
          contentPadding: EdgeInsets.only(left: 14.0, bottom: 12.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          suffixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
        onChanged: (value) => _onChanged(userBloc, value),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
        color: Colors.white,
      ),
      height: 50,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(8),
    );
  }

  Widget _usersContainer(BuildContext context, UserBloc userBloc) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) =>
              // Users container
              (state.users != null)
                  ? ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder: (context, index) => UserCard(
                        user: state.users[index],
                      ),
                    )
                  : Message(message: 'Busca usuarios y añádelos a favoritos'),
        ),
      ),
    );
  }

  void _onChanged(UserBloc userBloc, String value) {
    if (value.length > 2) {
      userBloc.add(UserSearch(value));
    } else {
      userBloc.add(UserSearchRestart());
    }
  }
}
