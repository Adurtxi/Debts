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
    if (event is DebtsLoadEvent) {
      try {
        yield DebtsLoadingState();

        final debts = await _debtsProvider.loadDebts('defaulter-debts-to-pay');

        yield DebtsLoadedState(debts: debts);
      } catch (e) {
        yield DebtsErrorState();
      }
    }
  }
}
