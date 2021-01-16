part of 'debt_bloc.dart';

class DebtState {}

// DEBTS

class DebtsInitialState extends DebtState {}

class DebtsLoadingState extends DebtState {}

class DebtsLoadedState extends DebtState {
  final List<DebtModel> debts;

  DebtsLoadedState({
    @required this.debts,
  });
}

class DebtsErrorState extends DebtState {}
