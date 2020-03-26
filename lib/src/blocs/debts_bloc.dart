import 'package:epbasic_debts/src/models/debt_model.dart';
import 'package:epbasic_debts/src/providers/debts_provider.dart';
import 'package:rxdart/rxdart.dart';

class DebtsBloc {
  final _debtsCtr = new BehaviorSubject<List<DebtModel>>();
  final _loadingCtr = new BehaviorSubject<bool>();

  final _debtsProvider = new DebtsProvider();

  Stream<List<DebtModel>> get debtsStream => _debtsCtr.stream;
  Stream<bool> get loading => _loadingCtr.stream;

  void loadDebts(pathUrl) async {
    _debtsCtr.sink.add([]);
    final debts = await _debtsProvider.loadDebts(pathUrl);
    _debtsCtr.sink.add(debts);
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
    _debtsCtr?.close();
    _loadingCtr?.close();
  }
}
