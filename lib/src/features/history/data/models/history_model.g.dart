// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryModel _$HistoryModelFromJson(Map<String, dynamic> json) => HistoryModel(
      email: json['email'] as String? ?? '',
      salah: json['salah'] as String? ?? '',
      amount: json['amount'] as int? ?? 0,
      time: json['time'] as String? ?? '',
    );

Map<String, dynamic> _$HistoryModelToJson(HistoryModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'salah': instance.salah,
      'amount': instance.amount,
      'time': instance.time,
    };
