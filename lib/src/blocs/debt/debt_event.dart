part of 'debt_bloc.dart';

@immutable
abstract class DebtEvent {}

class DebtsLoadEvent extends DebtEvent {}

class StoreDebt extends DebtEvent {
  final DebtModel debt;

  StoreDebt(this.debt);
}
