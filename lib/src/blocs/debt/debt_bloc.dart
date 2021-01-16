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

        final debts = await _debtsProvider.loadDebts('defaulter-debts-to-pay');

        yield state.copyWith(debts: debts);

        yield state.copyWith(debtsState: 1);
      } catch (e) {
        yield state.copyWith(debtsState: -1);
      }
    }
    // Load home page debts
    if (event is DebtsAllLoad) {
      try {
        yield state.copyWith(allDebtsState: 0);

        final debts = await _debtsProvider.loadDebts('debts');

        yield state.copyWith(allDebts: debts);

        yield state.copyWith(allDebtsState: 1);
      } catch (e) {
        yield state.copyWith(allDebtsState: -1);
      }
    }

    // Store debt
    if (event is DebtStore) {
      yield state.copyWith(debt: event.debt);

      final debt = await _debtsProvider.createDebt(event.debt);

      yield state.copyWith(allDebts: [debt, ...state.allDebts]);
    }

    // Remove debt
    if (event is DebtDelete) {
      final status = await _debtsProvider.deleteDebt(event.debtId);

      if (status == 'success') {
        final allDebts = state.allDebts.where((d) => d.id != event.debtId).toList();

        yield state.copyWith(allDebts: allDebts);
      }
    }
  }
}
