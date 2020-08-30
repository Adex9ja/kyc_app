import 'package:flutter_starter_app/model/account_entity.dart';
import 'package:flutter_starter_app/model/bank_entity.dart';
import 'package:flutter_starter_app/model/bvn_entity.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'base.dart';
part 'data_service.g.dart';


@RestApi()
abstract class GetDataService  {
  factory GetDataService(Dio dio, {String baseUrl}) = _GetDataService;


  @POST("resources")
  Future<HttpResponse> getBankList(@Body() Map<String, String> request);

  @POST("resources")
  Future<BaseData<AccountEntity>> verifyAcctNumber(@Body() Map<String, String> request);

  @POST("resources")
  Future<BaseData<BvnEntity>> validateBVN(@Body() Map<String, String> request);

}