import 'package:meta/meta.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:debts/src/providers/debts_provider.dart';

import 'package:debts/src/models/debt_model.dart';

part 'debt_state.dart';
part 'debt_event.dart';

class DebtBloc extends Bloc<DebtEvent, DebtState> {
  final _debtsProvider = new DebtsProvider();

  DebtBloc() : super(DebtState());

  @override
  Stream<DebtState> mapEventToState(DebtEvent event) async* {
    // Load home page debts
    if (event is DebtsLoad) {
      try {
        yield state.copyWith(debtsState: 0);

        final debts = await _debtsProvider.loadDebts('debts-to-pay');

        state.debts = debts;

        yield state.copyWith(debtsState: 1);
      } catch (e) {
        yield state.copyWith(debtsState: -1);
      }
    }
    // Load debts page debts
    if (event is DebtsAllLoad) {
      try {
        yield state.copyWith(allDebtsState: 0);

        final debts = await _debtsProvider.loadDebts('debts');

        state.allDebts = debts;

        yield state.copyWith(allDebtsState: 1);
      } catch (e) {
        yield state.copyWith(allDebtsState: -1);
      }
    }

    // Store debt
    if (event is DebtStore) {
      final debt = await _debtsProvider.createDebt(event.debt);

      if (event.previousPage == 'debts') {
        yield state.copyWith(allDebts: [debt, ...state.allDebts]);
      }
    }

    // Mark debt as paid
    if (event is DebtMarkAsPaid) {
      List<DebtModel> allDebts = state.allDebts;

      final status = await _debtsProvider.markAsPaid(event.debtId);

      if (status == 'success') {
        final debtIndex = allDebts.indexWhere((d) => d.id == event.debtId);

        allDebts[debtIndex].paid = true;

        state.allDebts = allDebts;

        yield state.copyWith();
      }
    }

    // Remove debt
    if (event is DebtDelete) {
      final status = await _debtsProvider.deleteDebt(event.debtId);

      if (status == 'success') {
        final allDebts = state.allDebts.where((d) => d.id != event.debtId).toList();

        state.allDebts = allDebts;

        yield state.copyWith();
      }
    }
  }
}
