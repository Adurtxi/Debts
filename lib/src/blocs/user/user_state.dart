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
    selectedUser,
    searchQuery,
    users,
    followers,
    followersState,
  }) =>
      UserState(
        selectedUser: selectedUser ?? null,
        searchQuery: searchQuery ?? this.searchQuery,
        users: users ?? this.users,
        followers: followers ?? this.followers,
        followersState: followersState ?? this.followersState,
      );
}
