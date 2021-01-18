import 'package:flutter/material.dart';

import 'package:debts/src/widgets/drawer.dart';
import 'package:debts/src/widgets/appbar.dart';

class ConfigPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerW(),
      appBar: AppBarW(
        title: 'Configuraciones',
      ),
      body: Container(),
    );
  }
}
