// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryModel _$HistoryModelFromJson(Map<String, dynamic> json) => HistoryModel(
      changeAmount: json['change_amount'] as int? ?? 0,
      changeTime: json['change_time'] as String? ?? '',
    );

Map<String, dynamic> _$HistoryModelToJson(HistoryModel instance) =>
    <String, dynamic>{
      'change_amount': instance.changeAmount,
      'change_time': instance.changeTime,
    };
