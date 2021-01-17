import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:debts/src/blocs/user/user_bloc.dart';

import 'package:debts/src/models/follower_model.dart';

import 'package:debts/src/widgets/utils/error.dart';
import 'package:debts/src/widgets/utils/loader.dart';

import 'package:debts/src/modals/users/actions.dart';

// ignore: must_be_immutable
class HomeContacts extends StatelessWidget {
  final UserActionsModal _aModal = UserActionsModal();

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
              Icons.more_horiz,
            ),
            iconSize: 30.0,
            color: Colors.blueGrey,
            onPressed: () => _aModal.mainBottomSheet(context),
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
                  : _followers(userBloc, state.followers),
        ),
      ),
    );
  }

  Widget _followers(UserBloc userbloc, List<FollowerModel> followers) {
    if (followers == null) {
      return Container(
        child: Center(
          child: Text('No tienes contactos'),
        ),
      );
    }

    return Container(
      height: 120,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 10.0),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => _contact(
          followers[index],
        ),
        itemCount: followers.length,
      ),
    );
  }

  // Contact image and name
  Widget _contact(FollowerModel follower) {
    return Container(
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
    );
  }
}
