import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:debts/src/preferences/user_preferences.dart';

class CachedImages extends StatelessWidget {
  final String image;
  final double size;

  final _prefs = UserPreferences();

  CachedImages({@required this.image, @required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CachedNetworkImage(
        imageUrl: _prefs.url + image,
      ),
    );
  }
}
