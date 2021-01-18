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

class UserSearchRestart extends UserEvent {}

class FollowerAdd extends UserEvent {
  final int userId;
  final String previousPage;

  FollowerAdd(this.userId, this.previousPage);
}

class FollowerDelete extends UserEvent {
  final int userId;
  final String previousPage;

  FollowerDelete(this.userId, this.previousPage);
}

class UserFollowersLoad extends UserEvent {}
