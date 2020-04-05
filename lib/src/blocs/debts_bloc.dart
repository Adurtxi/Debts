import 'package:epbasic_debts/src/models/debt_model.dart';
import 'package:epbasic_debts/src/providers/debts_provider.dart';
import 'package:rxdart/rxdart.dart';

import 'dart:io';

class DebtsBloc {
  final _homeDebtsCtr = new BehaviorSubject<Map<String, dynamic>>();
  final _debtsDebtsCtr = new BehaviorSubject<Map<String, dynamic>>();
  final _loadingCtr = new BehaviorSubject<bool>();
  final _debtTicketCtr = new BehaviorSubject<String>();
  final _debtTicketFileCtr = new BehaviorSubject<File>();

  final _debtsProvider = new DebtsProvider();

  Stream<Map<String, dynamic>> get homeDebtsStream => _homeDebtsCtr.stream;
  Stream<Map<String, dynamic>> get debtsDebtsStream => _debtsDebtsCtr.stream;

  Stream<String> get debtTicket => _debtTicketCtr.stream;
  Stream<File> get debtTicketFile => _debtTicketFileCtr.stream;

  Stream<bool> get loadingStream => _loadingCtr.stream;

  void homeDebts() async {
    _loadingCtr.sink.add(true);
    final debts = await _debtsProvider.loadDebts('defaulter-debts-to-pay');
    _loadingCtr.sink.add(false);

    _homeDebtsCtr.sink.add(debts);
  }

  void debtsDebts() async {
    _loadingCtr.sink.add(true);
    final debts = await _debtsProvider.loadDebts('debts');
    _loadingCtr.sink.add(false);

    _debtsDebtsCtr.sink.add(debts);
  }

  Future<Map<String, dynamic>> createDebt(DebtModel debt) async {
    return await _debtsProvider.createDebt(debt);
  }

  Future<Map<String, dynamic>> updateDebt(DebtModel debt) async {
    return await _debtsProvider.updateDebt(debt);
  }

  Future<Map<String, dynamic>> markAsPaid(String id) async {
    debtsDebts();

    return await _debtsProvider.markAsPaid(id);
  }

  Future<Map<String, dynamic>> deleteDebt(String id) async {
    return await _debtsProvider.deleteDebt(id);
  }

  void uploadTicket(File ticket) async {
    _debtTicketFileCtr.sink.add(ticket);

    final ticketResp = await _debtsProvider.uploadTicket(ticket);

    if (ticketResp['ok'] == true) {
      _debtTicketCtr.sink.add(ticketResp['file_name']);
    }
  }

  void deleteData() async {
    _debtTicketFileCtr.sink.add(null);
    _debtTicketCtr.sink.add(null);
  }

  dispose() {
    _homeDebtsCtr?.close();
    _debtsDebtsCtr?.close();
    _loadingCtr?.close();
    _debtTicketCtr?.close();
    _debtTicketFileCtr?.close();
  }
}
