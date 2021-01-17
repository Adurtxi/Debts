part of 'debt_bloc.dart';

@immutable
abstract class DebtEvent {}

class DebtsLoad extends DebtEvent {}

class DebtsAllLoad extends DebtEvent {}

class DebtStore extends DebtEvent {
  final DebtModel debt;
  final String previousPage;

  DebtStore(this.debt, this.previousPage);
}

class DebtMarkAsPaid extends DebtEvent {
  final int debtId;

  DebtMarkAsPaid(this.debtId);
}

class DebtDelete extends DebtEvent {
  final int debtId;

  DebtDelete(this.debtId);
}
