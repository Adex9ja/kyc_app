import 'package:flutter_starter_app/model/account_entity.dart';
import 'package:flutter_starter_app/model/bank_entity.dart';
import 'package:json_annotation/json_annotation.dart';


part 'base.g.dart';
@JsonSerializable()
class BaseData<T>{
    @_Converter()
    T data;
    String error;
    String status;
    bool resolved;
    String message;



    BaseData(this.data, this.error, this.status, this.resolved, this.message);

    factory BaseData.fromJson(Map<String, dynamic> json) =>  _$BaseDataFromJson(json);
    Map<String, dynamic> toJson() => _$BaseDataToJson(this);
 }


class _Converter<T> implements JsonConverter<T, Object> {
    const _Converter();

    @override
    T fromJson(Object json) {
        if(json == null)
            return null;

        if (json is Map<String, dynamic> && json.containsKey('account_name'))
            return AccountEntity.fromJson(json) as T;

        else
            return null;

    }

    @override
    Object toJson(T object) {
        // This will only work if `object` is a native JSON type:
        //   num, String, bool, null, etc
        // Or if it has a `toJson()` function`.
        return object;
    }
}
