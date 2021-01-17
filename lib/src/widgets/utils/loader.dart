import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderW extends StatelessWidget {
  final double size;

  LoaderW({@required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SpinKitRing(
          color: Colors.black,
          size: size,
          lineWidth: size / 10,
        ),
      ),
    );
  }
}
