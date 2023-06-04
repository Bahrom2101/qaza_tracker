// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'] as String? ?? '',
      fajr: json['fajr'] as int? ?? 0,
      zuhr: json['zuhr'] as int? ?? 0,
      asr: json['asr'] as int? ?? 0,
      maghrib: json['maghrib'] as int? ?? 0,
      isha: json['isha'] as int? ?? 0,
      witr: json['witr'] as int? ?? 0,
      changes: (json['changes'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k, const ChangeConverter().fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'email': instance.email,
      'fajr': instance.fajr,
      'zuhr': instance.zuhr,
      'asr': instance.asr,
      'maghrib': instance.maghrib,
      'isha': instance.isha,
      'witr': instance.witr,
      'changes': instance.changes
          ?.map((k, e) => MapEntry(k, const ChangeConverter().toJson(e))),
    };
