part of 'history_bloc.dart';

@immutable
abstract class HistoryEvent {
  const HistoryEvent();
}

class InitialEvent extends HistoryEvent {
  final String salah;

  const InitialEvent(this.salah);
}

class ChangeStatusEvent extends HistoryEvent {
  final FormzSubmissionStatus status;
  final String message;

  const ChangeStatusEvent(this.status, [this.message = '']);
}

class UpdateEvent extends HistoryEvent {
  const UpdateEvent();
}
