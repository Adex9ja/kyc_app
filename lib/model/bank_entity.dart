import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
part 'bank_entity.g.dart';
@JsonSerializable()
@Entity(tableName: "bank_entity")
class BankEntity{
  @PrimaryKey(autoGenerate: false)
  String bankCode;
  String bankName;
  bool selected;

  BankEntity(this.bankCode, this.bankName, {this.selected = false});

  factory BankEntity.fromJson(Map<String, dynamic> json) => _$BankEntityFromJson(json);
  Map<String, dynamic> toJson() => _$BankEntityToJson(this);
}