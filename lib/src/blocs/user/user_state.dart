part of 'user_bloc.dart';

class UserState {
  UserModel selectedUser;

  String searchQuery;

  List<UserModel> users;

  List<FollowerModel> followers;
  int followersState;

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
        selectedUser: selectedUser ?? this.selectedUser,
        searchQuery: searchQuery ?? this.searchQuery,
        users: users ?? this.users,
        followers: followers ?? this.followers,
        followersState: followersState ?? this.followersState,
      );
}
