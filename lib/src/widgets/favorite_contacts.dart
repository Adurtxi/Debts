import 'package:flutter/material.dart';

import 'package:debts/src/modals/users/actions.dart';

class FavoriteContacts extends StatelessWidget {
  final UserActionsModal _aModal = UserActionsModal();

  final favorites = [
    {
      'id': 1,
      'imageUrl':
          'https://lh3.googleusercontent.com/a-/AOh14GjbLlZ8MpJbM1KqTnccT0VIp4XXZzy-Is-KQoa6Rw=s96-c',
      'name': 'Adur'
    },
    {
      'id': 2,
      'imageUrl':
          'https://lh3.googleusercontent.com/a-/AOh14GjIquTPeoC3S7481CjTz_g0acGCBcbzNXHE6ZNs-DI=s96-c',
      'name': 'Noe'
    },
    {
      'id': 3,
      'imageUrl':
          'https://lh3.googleusercontent.com/a-/AOh14GhvFwuLr13AZ_Qvjil_1W43E8xiXYJ4jQ57_XovUg=s96-c',
      'name': 'Jon'
    },
    {
      'id': 5,
      'imageUrl':
          'https://lh5.googleusercontent.com/--8YAFwqjtVk/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucmJDOowrA3lgvPOdM4ESdpCLJXG7Q/s96-c/photo.jpg',
      'name': 'Rubén'
    },
    {
      'id': 4,
      'imageUrl':
          'https://lh3.googleusercontent.com/a-/AOh14GiKaOj-6CxhKB257qxdSMLBDq5VGzFBymMMYUN8xQ=s96-c',
      'name': 'Ekaitz'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _textContainer(context),
          _contacts(),
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

  // Contacts row
  Widget _contacts() {
    return Container(
      height: 120.0,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 10.0),
        scrollDirection: Axis.horizontal,
        itemCount: favorites.length,
        itemBuilder: (BuildContext context, int index) => _contact(index),
      ),
    );
  }

  // Contact image and name
  Widget _contact(int index) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(favorites[index]['imageUrl']),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Text(
              favorites[index]['name'],
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
