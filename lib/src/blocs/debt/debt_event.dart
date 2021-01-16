part of 'debt_bloc.dart';

@immutable
abstract class DebtEvent {}

class DebtsLoad extends DebtEvent {}

class DebtsAllLoad extends DebtEvent {}

class DebtStore extends DebtEvent {
  final DebtModel debt;

  DebtStore(this.debt);
}

class DebtDelete extends DebtEvent {
  final int debtId;

  DebtDelete(this.debtId);
}
