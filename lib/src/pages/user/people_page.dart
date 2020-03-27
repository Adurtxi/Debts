import 'package:epbasic_debts/src/blocs/followers_bloc.dart';
import 'package:epbasic_debts/src/blocs/provider.dart';
import 'package:epbasic_debts/src/models/follower_model.dart';
import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:epbasic_debts/src/search/user_search_delegate.dart';
import 'package:epbasic_debts/src/widgets/bottomNav.dart';
import 'package:epbasic_debts/src/widgets/followedList.dart';
import 'package:epbasic_debts/src/widgets/followerList.dart';
import 'package:epbasic_debts/src/widgets/myAppBar.dart';
import 'package:flutter/material.dart';

class PeoplePage extends StatelessWidget {
  final prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    final followersBloc = Provider.followersBloc(context);
    followersBloc.followers();
    followersBloc.followeds();

    return Scaffold(
      appBar: MyAppBar(
        title: Text('Gente'),
        user: '${prefs.identity[1][0]}${prefs.identity[2][0]}',
        context: context,
      ),
      body: _body(followersBloc),
      floatingActionButton: _createButtons(context),
      bottomNavigationBar: BottomNav(),
    );
  }

  Widget _body(FollowersBloc followersBloc) {
    return Stack(
      children: <Widget>[
        _createFollowersList(followersBloc),
        _createFollowedsList(followersBloc),
      ],
    );
  }

  //Lista de deudas
  _createFollowersList(FollowersBloc followersBloc) {
    return StreamBuilder(
      stream: followersBloc.followerStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<FollowerModel>> snapshot) {
        final followers = snapshot.data;

        if (snapshot.hasData && followers.length > 0) {
          return ListView.builder(
            itemCount: followers.length,
            itemBuilder: (context, i) {
              return FollowerList(follower: followers[i]);
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _createFollowedsList(FollowersBloc followersBloc) {
    return StreamBuilder(
      stream: followersBloc.followedStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<FollowerModel>> snapshot) {
        final followeds = snapshot.data;

        if (snapshot.hasData && followeds.length > 0) {
          return ListView.builder(
            itemCount: followeds.length,
            itemBuilder: (context, i) {
              return FollowedList(followed: followeds[i]);
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  //Botón crear nuevo producto
  _createButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          heroTag: "search",
          child: Icon(Icons.search, color: Colors.white),
          backgroundColor: Colors.blue,
          onPressed: () {
            showSearch(context: context, delegate: UserSearch());
          },
        ),
      ],
    );
  }
}
