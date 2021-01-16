import 'package:meta/meta.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:debts/src/providers/user_provider.dart';

import 'package:debts/src/models/user_model.dart';

part 'user_state.dart';
part 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final _usersProvider = new UserProvider();

  UserBloc() : super(UserState());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    // Select user
    if (event is UserSelect) {
      yield UserState(selectedUser: event.user);
    }
  }
}
