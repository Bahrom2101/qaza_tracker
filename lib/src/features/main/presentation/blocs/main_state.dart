part of 'main_bloc.dart';

class MainState extends Equatable {
  final UserEntity user;
  final FormzSubmissionStatus statusFetch;
  final String message;
  final int forUpdate;

  const MainState({
    this.user = const UserEntity(),
    this.statusFetch = FormzSubmissionStatus.initial,
    this.message = '',
    this.forUpdate = 1,
  });

  MainState copWith({
    UserEntity? user,
    FormzSubmissionStatus? statusFetch,
    String? message,
    int? forUpdate,
  }) =>
      MainState(
        user: user ?? this.user,
        statusFetch: statusFetch ?? this.statusFetch,
        message: message ?? this.message,
        forUpdate: forUpdate ?? this.forUpdate,
      );

  @override
  List<Object?> get props => [
        user,
        statusFetch,
        message,
        forUpdate,
      ];
}
