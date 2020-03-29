import 'package:epbasic_debts/src/models/follower_model.dart';
import 'package:epbasic_debts/src/models/user_model.dart';
import 'package:epbasic_debts/src/providers/followers_provider.dart';

import 'package:rxdart/rxdart.dart';

class FollowersBloc {
  final _followersCtr = new BehaviorSubject<List<FollowerModel>>();
  final _followedsCtr = new BehaviorSubject<List<FollowerModel>>();
  final _loadingCtr = new BehaviorSubject<bool>();
  final _defaulterCtr = new BehaviorSubject<UserModel>();

  final _followersProvider = new FollowersProvider();

  Stream<List<FollowerModel>> get followerStream => _followersCtr.stream;
  Stream<List<FollowerModel>> get followedStream => _followedsCtr.stream;
  Stream<UserModel> get defaulter => _defaulterCtr.stream;

  void followers() async {
    final followers = await _followersProvider.loadFollowers('all');
    _followersCtr.sink.add(followers);
  }

  void followeds() async {
    final followeds = await _followersProvider.loadFolloweds('all');
    _followedsCtr.sink.add(followeds);
  }

  void newFollower(int userId) async {
    await _followersProvider.newFollower(userId);
    followers();
  }

  void deleteFollowed(int userId) async {
    await _followersProvider.deleteFollowed(userId);
    followeds();
  }

  void acceptFollower(int userId) async {
    await _followersProvider.acceptFollower(userId);
    followers();
  }

  void deleteFollower(int userId) async {
    await _followersProvider.deleteFollower(userId);
    followers();
  }

  void sDefaulter(sDefaulter) async {
    _defaulterCtr.sink.add(sDefaulter);
  }

  dispose() {
    _followersCtr?.close();
    _followedsCtr?.close();
    _defaulterCtr?.close();
    _loadingCtr?.close();
  }
}
