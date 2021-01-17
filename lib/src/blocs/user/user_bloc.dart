import 'package:meta/meta.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:debts/src/providers/user_provider.dart';
import 'package:debts/src/providers/followers_provider.dart';

import 'package:debts/src/models/user_model.dart';

part 'user_state.dart';
part 'user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final _usersProvider = new UserProvider();
  final _followersProvider = new FollowersProvider();

  UserBloc() : super(UserState());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    // Select user
    if (event is UserSelect) {
      yield UserState(selectedUser: event.user);
    }

    if (event is UserSearch) {
      final users = await _usersProvider.searchUsers(event.searchQuery);

      yield UserState(users: users);
    }

    if (event is UserAdd) {
      final status = await _followersProvider.addFollower(event.userId);

      if (status == 'success') {
        List<UserModel> users = state.users;

        final userIndex = users.indexWhere((u) => u.id == event.userId);

        users[userIndex].follower = true;

        yield state.copyWith(users: users);
      }
    }

    if (event is UserDelete) {
      final status = await _followersProvider.deleteFollower(event.userId);

      if (status == 'success') {
        List<UserModel> users = state.users;

        final userIndex = users.indexWhere((u) => u.id == event.userId);

        users[userIndex].follower = false;

        yield state.copyWith(users: users);
      }
    }
  }
}
