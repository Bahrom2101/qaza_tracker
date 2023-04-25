part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {
  const LoginEvent();
}

class ChangeStatusEvent extends LoginEvent {
  final FormzSubmissionStatus status;
  final String message;

  const ChangeStatusEvent(this.status, [this.message = '']);
}
