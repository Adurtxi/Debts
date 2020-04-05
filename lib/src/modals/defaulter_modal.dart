import 'package:epbasic_debts/src/blocs/followers_bloc.dart';
import 'package:epbasic_debts/src/blocs/provider.dart';
import 'package:epbasic_debts/src/models/user_model.dart';
import 'package:flutter/material.dart';

class DefaulterModal {
  mainBottomSheet(BuildContext context) {
    final _followersBloc = Provider.followersBloc(context);
    _followersBloc.dFolloweds();

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Selecciona deudor',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Buscar deudor',
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: _createFollowedsList(_followersBloc),
              ),
            ],
          );
        });
  }

  _createFollowedsList(FollowersBloc followersBloc) {
    return StreamBuilder(
      stream: followersBloc.dFollowedsStream,
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['ok'] == true) {
            final followeds = snapshot.data['followeds'];
            return ListView.builder(
              itemCount: followeds.length,
              itemBuilder: (context, i) =>
                  _followerList(context, followersBloc, followeds[i].followed),
            );
          } else {
            return ListTile(
              leading: Icon(Icons.person),
              title: Text('No sigues a nadie'),
              onTap: () {},
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _followerList(
      BuildContext context, FollowersBloc followersBloc, UserModel followed) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(
          '${followed.name[0]}${followed.surname[0]}',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      title: Text(
        '${followed.name} ${followed.surname}',
      ),
      trailing: Icon(Icons.person),
      onTap: () {
        followersBloc.sDefaulter(followed);
        Navigator.pop(context);
      },
    );
  }
}
