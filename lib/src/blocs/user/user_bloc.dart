import 'package:debts/src/models/follower_model.dart';
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
      yield state.copyWith(
        selectedUser: event.user,
      );
    }

    if (event is UserRemoveSelect) {
      state.selectedUser = null;

      yield state.copyWith();
    }

    if (event is UserSearch) {
      final users = await _usersProvider.searchUsers(event.searchQuery);

      state.users = users;

      yield state.copyWith();
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

    if (event is UserFollowersLoad) {
      try {
        yield state.copyWith(followersState: 0);

        final followers = await _followersProvider.loadFollowers();

        state.followers = followers;

        yield state.copyWith(followersState: 1);
      } catch (e) {
        yield state.copyWith(followersState: -1);
      }
    }
  }
}
