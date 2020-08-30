import 'package:floor/floor.dart';
import 'package:flutter_starter_app/model/bank_entity.dart';


@dao
abstract class TaskDao{

  @Insert(onConflict: OnConflictStrategy.REPLACE)
  Future<void> saveBankList(List<BankEntity> bankList);

  @Query("select * from bank_entity")
  Stream<List<BankEntity>> getBankList();

}