import 'package:json_annotation/json_annotation.dart';
import 'package:qaza_tracker/src/features/main/domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel extends UserEntity {
  const UserModel({
    super.email,
    super.fajr,
    super.zuhr,
    super.asr,
    super.maghrib,
    super.isha,
    super.witr,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
