import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:qaza_tracker/src/features/history/data/models/history_model.dart';

class HistoryEntity extends Equatable {
  final String email;
  final String salah;
  final int amount;
  final String time;

  const HistoryEntity({
    this.email = '',
    this.salah = '',
    this.amount = 0,
    this.time = '',
  });

  factory HistoryEntity.fromJson(Map<String, dynamic> json) =>
      HistoryModel.fromJson(json);

  @override
  List<Object?> get props => [
    email,
    salah,
    amount,
    time,
  ];
}

class HistoryConverter
    implements JsonConverter<HistoryEntity, Map<String, dynamic>> {
  const HistoryConverter();

  @override
  HistoryEntity fromJson(Map<String, dynamic> json) =>
      HistoryModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(HistoryEntity object) => <String, dynamic>{
    'salah': object.salah,
    'email': object.email,
    'amount': object.amount,
    'time': object.time,
  };
}
