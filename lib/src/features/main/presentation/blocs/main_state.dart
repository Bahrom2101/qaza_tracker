part of 'main_bloc.dart';

class MainState extends Equatable {
  final UserEntity user;
  final FormzSubmissionStatus statusFetch;
  final String message;

  const MainState({
    this.user = const UserEntity(),
    this.statusFetch = FormzSubmissionStatus.initial,
    this.message = '',
  });

  MainState copWith({
    UserEntity? user,
    FormzSubmissionStatus? statusFetch,
    String? message,
  }) =>
      MainState(
        user: user ?? this.user,
        statusFetch: statusFetch ?? this.statusFetch,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        user,
        statusFetch,
        message,
      ];
}
