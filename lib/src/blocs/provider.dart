import 'package:flutter/material.dart';
import 'package:epbasic_debts/src/blocs/user_bloc.dart';
export 'package:epbasic_debts/src/blocs/user_bloc.dart';
import 'package:epbasic_debts/src/blocs/debts_bloc.dart';
export 'package:epbasic_debts/src/blocs/debts_bloc.dart';

class Provider extends InheritedWidget {
  final _loginBloc = UserBloc();
  final _debtsBloc = DebtsBloc();

  static Provider _instance;

  factory Provider({Key key, Widget child}) {
    if (_instance == null) {
      _instance = new Provider._internal(key: key, child: child);
    }

    return _instance;
  }

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static UserBloc userBloc(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._loginBloc;
  }

  static DebtsBloc debtsBloc(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._debtsBloc;
  }
}
