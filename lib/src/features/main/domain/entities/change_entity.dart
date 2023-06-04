import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:qaza_tracker/src/features/main/data/models/change_model.dart';

class ChangeEntity extends Equatable {
  final int changeAmount;
  final String changeTime;

  const ChangeEntity({
    this.changeAmount = 0,
    this.changeTime = '',
  });

  factory ChangeEntity.fromJson(Map<String, dynamic> json) =>
      ChangeModel.fromJson(json);

  @override
  List<Object?> get props => [
        changeAmount,
        changeTime,
      ];
}

class ChangeConverter
    implements JsonConverter<ChangeEntity, Map<String, dynamic>> {
  const ChangeConverter();

  @override
  ChangeEntity fromJson(Map<String, dynamic> json) =>
      ChangeModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(ChangeEntity object) => <String, dynamic>{
        'change_amount': object.changeAmount,
        'change_time': object.changeTime,
      };
}
