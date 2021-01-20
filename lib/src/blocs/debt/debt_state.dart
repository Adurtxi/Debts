part of 'debt_bloc.dart';

class DebtState {
  List<DebtModel> debts;
  int debtsState;

  List<DebtModel> allDebts;
  int allDebtsState;

  List<DebtModel> userDebts;
  int userDebtsState;

  DebtState({
    this.debts,
    this.debtsState,
    this.allDebts,
    this.allDebtsState,
    this.userDebts,
    this.userDebtsState,
  });

  DebtState copyWith({
    debts,
    debtsState,
    allDebts,
    allDebtsState,
    userDebts,
    userDebtsState,
  }) =>
      DebtState(
        debts: debts ?? this.debts,
        debtsState: debtsState ?? this.debtsState,
        allDebts: allDebts ?? this.allDebts,
        allDebtsState: allDebtsState ?? this.allDebtsState,
        userDebts: userDebts ?? this.userDebts,
        userDebtsState: userDebtsState ?? this.userDebtsState,
      );
}
