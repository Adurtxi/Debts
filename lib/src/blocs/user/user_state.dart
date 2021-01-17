part of 'user_bloc.dart';

class UserState {
  final UserModel selectedUser;

  final String searchQuery;

  final List<UserModel> users;

  final List<FollowerModel> followers;
  final int followersState;

  UserState({
    this.selectedUser,
    this.searchQuery,
    this.users,
    this.followers,
    this.followersState,
  });

  UserState copyWith({
    user,
    searchQuery,
    users,
    followers,
    followersState,
  }) =>
      UserState(
        selectedUser: selectedUser ?? this.selectedUser,
        searchQuery: searchQuery ?? this.searchQuery,
        users: users ?? this.users,
        followers: followers ?? this.followers,
        followersState: followersState ?? this.followersState,
      );
}
