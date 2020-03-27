import 'package:epbasic_debts/src/models/debt_model.dart';
import 'package:epbasic_debts/src/providers/debts_provider.dart';
import 'package:rxdart/rxdart.dart';

class DebtsBloc {
  final _homeDebtsCtr = new BehaviorSubject<List<DebtModel>>();
  final _debtsDebtsCtr = new BehaviorSubject<List<DebtModel>>();
  final _loadingCtr = new BehaviorSubject<bool>();

  final _debtsProvider = new DebtsProvider();

  Stream<List<DebtModel>> get homeDebtsStream => _homeDebtsCtr.stream;
  Stream<List<DebtModel>> get debtsDebtsStream => _debtsDebtsCtr.stream;
  Stream<bool> get loading => _loadingCtr.stream;

  void homeDebts() async {
    final debts = await _debtsProvider.loadDebts('defaulter-debts-to-pay');
    _homeDebtsCtr.sink.add(debts);
  }

  void debtsDebts() async {
    final debts = await _debtsProvider.loadDebts('debts');
    _debtsDebtsCtr.sink.add(debts);
  }

  void createDebt(DebtModel debt) async {
    _loadingCtr.sink.add(true);
    await _debtsProvider.createDebt(debt);
    _loadingCtr.sink.add(false);
  }

  void updateDebt(DebtModel debt) async {
    _loadingCtr.sink.add(true);
    await _debtsProvider.updateDebt(debt);
    _loadingCtr.sink.add(false);
  }

  Future<Map<String, dynamic>> deleteDebt(String id) async {
    return await _debtsProvider.deleteDebt(id);
  }

  dispose() {
    _homeDebtsCtr?.close();
    _debtsDebtsCtr?.close();
    _loadingCtr?.close();
  }
}
