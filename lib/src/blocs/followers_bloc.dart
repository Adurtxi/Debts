import 'package:epbasic_debts/src/models/user_model.dart';
import 'package:epbasic_debts/src/providers/followers_provider.dart';

import 'package:rxdart/rxdart.dart';

class FollowersBloc {
  final _followersCtr = new BehaviorSubject<Map<String, dynamic>>();
  final _followedsCtr = new BehaviorSubject<Map<String, dynamic>>();
  final _dFollowedsCtr = new BehaviorSubject<Map<String, dynamic>>();
  final _defaulterCtr = new BehaviorSubject<UserModel>();
  final _loadingCtr = new BehaviorSubject<bool>();

  final _followersProvider = new FollowersProvider();

  Stream<Map<String, dynamic>> get followerStream => _followersCtr.stream;
  Stream<Map<String, dynamic>> get followedStream => _followedsCtr.stream;
  Stream<Map<String, dynamic>> get dFollowedsStream => _dFollowedsCtr.stream;
  Stream<UserModel> get defaulter => _defaulterCtr.stream;
  Stream<bool> get loadingStream => _loadingCtr.stream;

  void followers() async {
    _loadingCtr.sink.add(true);
    final followers = await _followersProvider.loadFollowers('all');
    _loadingCtr.sink.add(false);

    _followersCtr.sink.add(followers);
  }

  void followeds() async {
    _loadingCtr.sink.add(true);
    final followeds = await _followersProvider.loadFolloweds('all');
    _loadingCtr.sink.add(false);

    _followedsCtr.sink.add(followeds);
  }

  void dFolloweds() async {
    _loadingCtr.sink.add(true);
    final followeds = await _followersProvider.loadFolloweds('accepted');
    _loadingCtr.sink.add(false);

    _dFollowedsCtr.sink.add(followeds);
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

  void deleteData() {
    _defaulterCtr.sink.add(null);
  }

  dispose() {
    _followersCtr?.close();
    _followedsCtr?.close();
    _dFollowedsCtr?.close();
    _defaulterCtr?.close();
    _loadingCtr?.close();
  }
}
