part of 'debt_bloc.dart';

class DebtState {}

//
// DEBTS
//

class DebtsLoadingState extends DebtState {}

class DebtsLoadedState extends DebtState {
  final List<DebtModel> debts;

  DebtsLoadedState({
    @required this.debts,
  });
}

class DebtsErrorState extends DebtState {}

//
// DEBTS ALL
//

class DebtsAllLoadingState extends DebtState {}

class DebtsAllLoadedState extends DebtState {
  final List<DebtModel> debts;

  DebtsAllLoadedState({
    @required this.debts,
  });
}

class DebtsAllErrorState extends DebtState {}

//
// DEBT Store
//

class DebtStoreLoadingState extends DebtState {}

class DebtStoreState extends DebtState {
  final DebtModel debt;

  DebtStoreState({
    @required this.debt,
  });
}

class DebtStoreErrorState extends DebtState {}
