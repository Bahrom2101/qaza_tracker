import 'package:json_annotation/json_annotation.dart';
import 'package:qaza_tracker/src/features/main/domain/entities/history_entity.dart';

part 'history_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HistoryModel extends HistoryEntity {
  const HistoryModel({
    super.changeAmount,
    super.changeTime,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);
}
