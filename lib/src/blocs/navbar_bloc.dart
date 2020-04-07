import 'package:rxdart/rxdart.dart';

class NavBarBloc {
  final _currentPageCtr = new BehaviorSubject<int>();

  Stream<int> get currentPage => _currentPageCtr.stream;

  void changePage(int page) async {
    _currentPageCtr.sink.add(page);
  }

  dispose() {
    _currentPageCtr?.close();
  }
}
