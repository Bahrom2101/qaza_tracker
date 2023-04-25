part of 'login_bloc.dart';

class LoginState extends Equatable {
  final FormzSubmissionStatus statusLogin;
  final String message;

  const LoginState({
    this.statusLogin = FormzSubmissionStatus.initial,
    this.message = '',
  });

  LoginState copWith({
    FormzSubmissionStatus? statusLogin,
    String? message,
  }) =>
      LoginState(
        statusLogin: statusLogin ?? this.statusLogin,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        statusLogin,
        message,
      ];
}
