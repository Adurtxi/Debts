part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UsersLoad extends UserEvent {}

class UserSelect extends UserEvent {
  final UserModel user;

  UserSelect(this.user);
}
