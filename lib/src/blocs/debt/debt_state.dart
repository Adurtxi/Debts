part of 'debt_bloc.dart';

class DebtState {
  final List<DebtModel> debts;
  final int debtsState;

  final List<DebtModel> allDebts;
  final int allDebtsState;

  final DebtModel debt;
  final int debtState;

  DebtState({
    this.debts,
    this.debtsState,
    this.allDebts,
    this.allDebtsState,
    this.debt,
    this.debtState,
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
          debt: debt ?? this.debt,
          debtState: debtState ?? this.debtState);
}
