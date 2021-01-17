part of 'user_bloc.dart';

class UserState {
  final UserModel selectedUser;
  final String searchQuery;
  final List<UserModel> users;

  UserState({
    this.selectedUser,
    this.searchQuery,
    this.users,
  });

  UserState copyWith({
    user,
    searchQuery,
    users,
  }) =>
      UserState(
        selectedUser: selectedUser ?? this.selectedUser,
        searchQuery: searchQuery ?? this.searchQuery,
        users: users ?? this.users,
      );
}
