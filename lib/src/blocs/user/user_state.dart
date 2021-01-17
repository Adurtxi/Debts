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

  UserState copyWith({user}) => UserState(
        selectedUser: user ?? this.selectedUser,
        searchQuery: user ?? this.searchQuery,
        users: user ?? this.users,
      );
}
