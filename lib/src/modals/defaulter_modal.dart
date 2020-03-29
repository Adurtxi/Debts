import 'package:epbasic_debts/src/blocs/followers_bloc.dart';
import 'package:epbasic_debts/src/blocs/provider.dart';
import 'package:epbasic_debts/src/models/follower_model.dart';
import 'package:flutter/material.dart';

class DefaulterModal {
  mainBottomSheet(BuildContext context) {
    final followersBloc = Provider.followersBloc(context);
    followersBloc.followeds();

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
                child: _createFollowedsList(followersBloc),
              ),
            ],
          );
        });
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
              return ListTile(
                leading: CircleAvatar(
                  child: Text(
                    '${followeds[i].followed.name[0]}${followeds[i].followed.surname[0]}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.blue,
                ),
                title: Text(
                  '${followeds[i].followed.name} ${followeds[i].followed.surname}',
                ),
                trailing: Icon(Icons.person),
                onTap: () {
                  followersBloc.sDefaulter(followeds[i].followed);
                  Navigator.pop(context);
                },
              );
            },
          );
        } else {
          return ListTile(
            leading: Icon(Icons.person),
            title: Text('No sigues a nadie'),
            onTap: () {
              Navigator.pop(context);
            },
          );
        }
      },
    );
  }
}
