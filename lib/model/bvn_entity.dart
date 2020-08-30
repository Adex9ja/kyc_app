import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
part 'bvn_entity.g.dart';
@JsonSerializable()
class BvnEntity{
  String firstname;
  String lastname;
  String dob;
  String bvn;
  String phone;
  BvnEntity(this.firstname, this.lastname, this.dob, this.bvn, this.phone);

  factory BvnEntity.fromJson(Map<String, dynamic> json) => _$BvnEntityFromJson(json);
  Map<String, dynamic> toJson() => _$BvnEntityToJson(this);
}