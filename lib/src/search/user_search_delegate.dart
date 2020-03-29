import 'package:epbasic_debts/src/models/user_model.dart';
import 'package:epbasic_debts/src/providers/user_provider.dart';
import 'package:epbasic_debts/src/widgets/userFollowerList.dart';
import 'package:flutter/material.dart';

class UserSearch extends SearchDelegate {
  final userProvider = new UserProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: userProvider.searchUser(query),
      builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
        if (snapshot.hasData) {
          final users = snapshot.data;

          return Container(
            margin: EdgeInsets.only(top: 5.0),
            child: ListView(
              children: users.map((user) {
                return UserFollowerList(user: user);
              }).toList(),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
