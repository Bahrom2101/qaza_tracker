part of 'main_bloc.dart';

abstract class MainEvent {
  const MainEvent();
}

class InitialEvent extends MainEvent {}

class ChangeStatusEvent extends MainEvent {
  final FormzSubmissionStatus status;
  final String message;

  const ChangeStatusEvent(this.status, [this.message = '']);
}

class ChangeValueEvent extends MainEvent {
  final int index;
  final int value;
  final String salah;
  final int amount;

  const ChangeValueEvent({
    required this.index,
    required this.value,
    required this.salah,
    required this.amount,
  });
}

class AddPeriodEvent extends MainEvent {
  final int days;

  const AddPeriodEvent(this.days);
}

class UpdateEvent extends MainEvent {
  const UpdateEvent();
}
