part of 'user_bloc.dart';

class UserState {
  final UserModel selectedUser;

  UserState({
    this.selectedUser,
  });

  UserState copyWith({user}) => UserState(
        selectedUser: user ?? this.selectedUser,
      );
}
