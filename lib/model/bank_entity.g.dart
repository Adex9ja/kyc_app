// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankEntity _$BankEntityFromJson(Map<String, dynamic> json) {
  return BankEntity(
    json['bankCode'] as String,
    json['bankName'] as String,
    selected: json['selected'] as bool,
  );
}

Map<String, dynamic> _$BankEntityToJson(BankEntity instance) =>
    <String, dynamic>{
      'bankCode': instance.bankCode,
      'bankName': instance.bankName,
      'selected': instance.selected,
    };
