// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bvn_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BvnEntity _$BvnEntityFromJson(Map<String, dynamic> json) {
  return BvnEntity(
    json['firstname'] as String,
    json['lastname'] as String,
    json['dob'] as String,
    json['bvn'] as String,
    json['phone'] as String,
  );
}

Map<String, dynamic> _$BvnEntityToJson(BvnEntity instance) => <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'dob': instance.dob,
      'bvn': instance.bvn,
      'phone': instance.phone,
    };
