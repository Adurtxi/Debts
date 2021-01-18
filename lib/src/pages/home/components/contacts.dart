import 'package:debts/src/modals/users/actions.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:debts/src/blocs/user/user_bloc.dart';

import 'package:debts/src/models/follower_model.dart';
import 'package:debts/src/models/user_model.dart';

import 'package:debts/src/widgets/utils/error.dart';
import 'package:debts/src/widgets/utils/loader.dart';
import 'package:debts/src/widgets/utils/message.dart';

import 'package:debts/src/modals/debt/create.dart';

// ignore: must_be_immutable
class HomeContacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _textContainer(context),
          _container(context, userBloc),
        ],
      ),
    );
  }

  // Contacts text
  Widget _textContainer(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Contactos',
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.person_add,
            ),
            iconSize: 30.0,
            color: Colors.blueGrey,
            onPressed: () => Navigator.pushReplacementNamed(context, 'users'),
          ),
        ],
      ),
    );
  }

  Widget _container(BuildContext context, UserBloc userBloc) {
    return Container(
      height: 120,
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {},
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) => (state.followersState == 0)
              ? LoaderW(size: 30)
              : (state.followersState == -1)
                  ? ErrorW()
                  : _contacts(userBloc, state.followers),
        ),
      ),
    );
  }

  Widget _contacts(UserBloc userBloc, List<FollowerModel> followers) {
    if (followers == null) {
      return Message(message: 'No tienes contactos');
    }

    return Container(
      height: 120,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 10.0),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => _contact(
          context,
          userBloc,
          followers[index],
        ),
        itemCount: followers.length,
      ),
    );
  }

  // Contact image and name
  Widget _contact(BuildContext context, UserBloc userBloc, FollowerModel follower) {
    return GestureDetector(
      onTap: () => _openModal(context, userBloc, follower),
      onLongPress: () => _createDebt(context, userBloc, follower.followed),
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(follower.followed.image),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Text(
                follower.followed.name,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openModal(BuildContext context, UserBloc userBloc, FollowerModel follower) {
    userBloc.add(
      UserSelect(follower.followed),
    );

    FollowerActionsModal _aModal = FollowerActionsModal(followed: follower);

    _aModal.mainBottomSheet(context);
  }

  void _createDebt(BuildContext context, UserBloc userBloc, UserModel user) {
    userBloc.add(
      UserSelect(user),
    );

    CreateDebtModal _aModal = CreateDebtModal(previousPage: 'home');

    _aModal.mainBottomSheet(context);
  }
}
