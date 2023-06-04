// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeModel _$ChangeModelFromJson(Map<String, dynamic> json) => ChangeModel(
      changeAmount: json['change_amount'] as int? ?? 0,
      changeTime: json['change_time'] as String? ?? '',
    );

Map<String, dynamic> _$ChangeModelToJson(ChangeModel instance) =>
    <String, dynamic>{
      'change_amount': instance.changeAmount,
      'change_time': instance.changeTime,
    };
