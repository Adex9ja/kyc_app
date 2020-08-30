// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseData<T> _$BaseDataFromJson<T>(Map<String, dynamic> json) {
  return BaseData<T>(
    _Converter<T>().fromJson(json['data']),
    json['error'] as String,
    json['status'] as String,
    json['resolved'] as bool,
    json['message'] as String,
  );
}

Map<String, dynamic> _$BaseDataToJson<T>(BaseData<T> instance) =>
    <String, dynamic>{
      'data': _Converter<T>().toJson(instance.data),
      'error': instance.error,
      'status': instance.status,
      'resolved': instance.resolved,
      'message': instance.message,
    };
