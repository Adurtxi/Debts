part of 'debt_bloc.dart';

class DebtState {
  List<DebtModel> debts;
  int debtsState;

  List<DebtModel> allDebts;
  int allDebtsState;

  DebtState({
    this.debts,
    this.debtsState,
    this.allDebts,
    this.allDebtsState,
  });

  DebtState copyWith({
    debts,
    debtsState,
    allDebts,
    allDebtsState,
    debt,
    debtState,
  }) =>
      DebtState(
        debts: debts ?? this.debts,
        debtsState: debtsState ?? this.debtsState,
        allDebts: allDebts ?? this.allDebts,
        allDebtsState: allDebtsState ?? this.allDebtsState,
      );
}
