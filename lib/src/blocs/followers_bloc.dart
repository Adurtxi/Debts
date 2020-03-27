import 'package:epbasic_debts/src/models/follower_model.dart';
import 'package:epbasic_debts/src/providers/followers_provider.dart';

import 'package:rxdart/rxdart.dart';

class FollowersBloc {
  final _followersCtr = new BehaviorSubject<List<FollowerModel>>();
  final _followedsCtr = new BehaviorSubject<List<FollowerModel>>();
  final _loadingCtr = new BehaviorSubject<bool>();

  final _followersProvider = new FollowersProvider();

  Stream<List<FollowerModel>> get followerStream => _followersCtr.stream;
  Stream<List<FollowerModel>> get followedStream => _followedsCtr.stream;
  Stream<bool> get loading => _loadingCtr.stream;

  void followers() async {
    final followers = await _followersProvider.loadFollowers('all');
    _followersCtr.sink.add(followers);
  }

  void followeds() async {
    final followeds = await _followersProvider.loadFolloweds('all');
    _followedsCtr.sink.add(followeds);
  }

  dispose() {
    _followersCtr?.close();
    _followedsCtr?.close();
    _loadingCtr?.close();
  }
}
