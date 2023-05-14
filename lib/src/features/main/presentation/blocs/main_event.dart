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

  const ChangeValueEvent(this.index, this.value);
}

class AddPeriodEvent extends MainEvent {
  final int days;

  const AddPeriodEvent(this.days);
}

class UpdateEvent extends MainEvent {
  const UpdateEvent();
}
