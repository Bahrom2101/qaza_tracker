import 'package:json_annotation/json_annotation.dart';
import 'package:qaza_tracker/src/features/main/domain/entities/change_entity.dart';

part 'change_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ChangeModel extends ChangeEntity {
  const ChangeModel({
    super.changeAmount,
    super.changeTime,
  });

  factory ChangeModel.fromJson(Map<String, dynamic> json) =>
      _$ChangeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeModelToJson(this);
}
