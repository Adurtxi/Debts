part of 'user_bloc.dart';

class UserState {}

// Select User
class UserSelectState extends UserState {
  final UserModel user;

  UserSelectState({
    @required this.user,
  });
}
