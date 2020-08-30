

import 'package:flutter_starter_app/db/app_database.dart';
import 'package:flutter_starter_app/model/bank_entity.dart';

class Repository{
  static Repository _instance = Repository._internal();
  Repository._internal();
  static Repository getInstance(){
    return _instance;
  }

  void saveBankList(List<BankEntity> bankList) {
    AppDatabase.getInstance().taskDao.saveBankList(bankList);
  }




}