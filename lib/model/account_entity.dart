import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
part 'account_entity.g.dart';
@JsonSerializable()
class AccountEntity{
  String account_name;
  AccountEntity(this.account_name);

  factory AccountEntity.fromJson(Map<String, dynamic> json) => _$AccountEntityFromJson(json);
  Map<String, dynamic> toJson() => _$AccountEntityToJson(this);
}