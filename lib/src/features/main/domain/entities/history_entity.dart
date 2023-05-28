import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:qaza_tracker/src/features/main/data/models/history_model.dart';

class HistoryEntity extends Equatable {
  final int changeAmount;
  final String changeTime;

  const HistoryEntity({
    this.changeAmount = 0,
    this.changeTime = '',
  });

  factory HistoryEntity.fromJson(Map<String, dynamic> json) =>
      HistoryModel.fromJson(json);

  @override
  List<Object?> get props => [
        changeAmount,
        changeTime,
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
        'change_amount': object.changeAmount,
        'change_time': object.changeTime,
      };
}
