part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UsersLoad extends UserEvent {}

class UserSelect extends UserEvent {
  final UserModel user;

  UserSelect(this.user);
}

class UserRemoveSelect extends UserEvent {}

class UserSearch extends UserEvent {
  final String searchQuery;

  UserSearch(this.searchQuery);
}

class UserAdd extends UserEvent {
  final int userId;

  UserAdd(this.userId);
}

class UserDelete extends UserEvent {
  final int userId;

  UserDelete(this.userId);
}

class UserFollowersLoad extends UserEvent {}
