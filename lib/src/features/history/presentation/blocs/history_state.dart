part of 'history_bloc.dart';

class HistoryState extends Equatable {
  final List<HistoryEntity> histories;
  final FormzSubmissionStatus statusFetch;
  final String message;
  final int forUpdate;

  const HistoryState({
    this.histories = const [],
    this.statusFetch = FormzSubmissionStatus.initial,
    this.message = '',
    this.forUpdate = 1,
  });

  HistoryState copWith({
    List<HistoryEntity>? histories,
    FormzSubmissionStatus? statusFetch,
    String? message,
    int? forUpdate,
  }) =>
      HistoryState(
        histories: histories ?? this.histories,
        statusFetch: statusFetch ?? this.statusFetch,
        message: message ?? this.message,
        forUpdate: forUpdate ?? this.forUpdate,
      );

  @override
  List<Object?> get props => [
        histories,
        statusFetch,
        message,
        forUpdate,
      ];
}
