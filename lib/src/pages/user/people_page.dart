import 'package:flutter/material.dart';

import 'package:epbasic_debts/src/widgets/bottomNav.dart';
import 'package:epbasic_debts/src/widgets/followers/followedList.dart';
import 'package:epbasic_debts/src/widgets/followers/followerList.dart';
import 'package:epbasic_debts/src/widgets/loader.dart';
import 'package:epbasic_debts/src/widgets/myAppBar.dart';

import 'package:epbasic_debts/src/blocs/followers_bloc.dart';
import 'package:epbasic_debts/src/blocs/provider.dart';

import 'package:epbasic_debts/src/preferences/user_preferences.dart';
import 'package:epbasic_debts/src/search/user_search_delegate.dart';

class PeoplePage extends StatelessWidget {
  final _prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    final followersBloc = Provider.followersBloc(context);
    followersBloc.followers();
    followersBloc.followeds();

    return Scaffold(
      appBar: MyAppBar(
        title: Text('Gente'),
        user: '${_prefs.identity[1][0]}${_prefs.identity[2][0]}',
        context: context,
      ),
      body: _body(followersBloc),
      floatingActionButton: _createButtons(context),
      bottomNavigationBar: BottomNav(),
    );
  }

  Widget _body(FollowersBloc followersBloc) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Seguidores',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
        Expanded(
          child: _createFollowersList(followersBloc),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Siguiendo',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
        Expanded(
          child: _createFollowedsList(followersBloc),
        ),
        _loader(followersBloc),
      ],
    );
  }

  _createFollowersList(FollowersBloc followersBloc) {
    return StreamBuilder(
      stream: followersBloc.followerStream,
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['ok'] == true) {
            final followers = snapshot.data['followers'];
            return ListView.builder(
              itemCount: followers.length,
              itemBuilder: (context, i) {
                return FollowerList(follower: followers[i]);
              },
            );
          } else {
            return Container();
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  _createFollowedsList(FollowersBloc followersBloc) {
    return StreamBuilder(
      stream: followersBloc.followedStream,
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['ok'] == true) {
            final followeds = snapshot.data['followeds'];
            return ListView.builder(
              itemCount: followeds.length,
              itemBuilder: (context, i) {
                return FollowedList(followed: followeds[i]);
              },
            );
          } else {
            return Container();
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  _createButtons(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showSearch(context: context, delegate: UserSearch());
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
          color: Color(0xFF1976D2),
        ),
        padding: EdgeInsets.all(16.0),
        child: Icon(Icons.search, color: Colors.white),
      ),
    );
  }

  _loader(FollowersBloc followersBloc) {
    return StreamBuilder(
      stream: followersBloc.loadingStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == true) {
          return ProgressIndicatorW();
        }
        return Container();
      },
    );
  }
}
