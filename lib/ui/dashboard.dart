import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_starter_app/core/base.dart';
import 'package:flutter_starter_app/core/retrofit_client.dart';
import 'package:flutter_starter_app/db/app_database.dart';
import 'package:flutter_starter_app/main.dart';
import 'package:flutter_starter_app/model/account_entity.dart';
import 'package:flutter_starter_app/model/bank_entity.dart';
import 'package:flutter_starter_app/model/bvn_entity.dart';
import 'package:flutter_starter_app/utils/repository.dart';
import 'package:retrofit/retrofit.dart';


class DashBoardActivity extends StatefulWidget{
  @override
  _DashBoardActivity createState() => _DashBoardActivity();

}

class _DashBoardActivity extends State<DashBoardActivity>{
  int _currentStep = 0;
  var states = [StepState.editing, StepState.indexed, StepState.indexed];
  var isActives = [true, false, false];
  var _accountNumberForm = GlobalKey<FormState>();
  var _bvnForm = GlobalKey<FormState>();
  String _accountNumber = "";
  String _bvnNumber = "";
  String _accountName = "";
  List<BankEntity> _bankList;



  @override
  void initState() {
    super.initState();
    downloadBanks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Stepper(
            steps: steps(),
            currentStep: _currentStep,
            type: StepperType.horizontal,
            onStepCancel: cancel,
            onStepContinue: next,
            onStepTapped: goTo
          ),
        )
    );
  }

  steps(){
    return  [
      Step(
          title: const Text("Account"),
          isActive: isActives[0],
          content: Form(
            key: _accountNumberForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("Let's get to know you", style: style.copyWith(fontSize: 24),),
                mediumSize,
                Text("Please enter your account number", style: style,),
                fabSize,
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      counterText: "",
                      contentPadding: EdgeInsets.all(10),
                      hintStyle: style,
                      hintText: "Enter Account Number",
                      border: OutlineInputBorder()
                  ),
                  maxLines: 1,
                  maxLength: 10,
                  validator: (value) => value.isEmpty ?  'Phone can\'t be empty' : null,
                  onSaved: (value) => _accountNumber = value.trim(),
                ),
                fabSize
              ],
            ),
          ),
          state: states[0],
          subtitle: const Text("Number")
      ),
      Step(
          title: const Text("Bank"),
          isActive: isActives[1],
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("Which bank do you use?", style: style.copyWith(fontSize: 24),),
              mediumSize,
              StreamBuilder<List<BankEntity>>(
                stream: AppDatabase.getInstance().taskDao.getBankList(),
                builder: (context, snapshot){
                  if(snapshot.hasData && snapshot.data != null && snapshot.data.length > 0){
                    _bankList = _bankList == null ? snapshot.data : _bankList;
                    return Container(
                      child: ListView.separated(
                        itemCount: _bankList == null ? 0 : _bankList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _bankList.forEach((element) => element.selected = false );
                                  _bankList[index].selected = true;
                                });
                              },
                              child: Padding(
                                padding: mediumSpacing,
                                child: Row(
                                  children: <Widget>[
                                    Icon(_bankList[index].selected ? Icons.radio_button_checked : Icons.radio_button_unchecked, color: _bankList[index].selected ? colorPrimary : colorGrey,),
                                    VerticalDivider(),
                                    Expanded(child: Text(_bankList[index].bankName),)
                                  ],
                                ),
                              )
                          );
                        },
                        separatorBuilder: (context, index){
                          return SizedBox( height: 1, width: MediaQuery.of(context).size.width, child: Container( color: colorLightGrey,),);
                        },
                      ),
                      height: MediaQuery.of(context).size.height - 250,
                      width: MediaQuery.of(context).size.width,
                    );
                  }
                  else
                    return Container(
                      height: 300,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.not_interested, size: 124, color: colorPrimary,),
                            mediumSize,
                            FlatButton.icon(onPressed: () => reloadBanks(), icon: Icon(Icons.refresh), label: Text("Empty bank list...Tap here to reload", style: style,)),
                          ],
                        )
                      ),
                    );
                },
              ),
            ],
          ),
          state: states[1],
          subtitle: const Text("Information")
      ),
      Step(
          title: const Text("BVN"),
          isActive: isActives[2],
          content: Form(
            key: _bvnForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("One more thing!", style: style.copyWith(fontSize: 24),),
                mediumSize,
                Text("We need to verify your BVN information", style: style,),
                fabSize,
                TextFormField(
                  controller: TextEditingController(text: _accountNumber),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      counterText: "",
                      contentPadding: EdgeInsets.all(10),
                      hintStyle: style,
                      border: OutlineInputBorder(),
                      fillColor: colorLightGrey,
                  ),
                  maxLines: 1,
                  maxLength: 10,
                  readOnly: true,
                  validator: (value) => value.isEmpty ?  'Account Number can\'t be empty' : null,
                ),
                mediumSize,
                TextFormField(
                  controller: TextEditingController(text: _accountName),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      counterText: "",
                      contentPadding: EdgeInsets.all(10),
                      hintStyle: style,
                      border: OutlineInputBorder()
                  ),
                  maxLines: 1,
                  maxLength: 10,
                  readOnly: true,
                  validator: (value) => value.isEmpty ?  'Account Name can\'t be empty' : null,
                ),
                mediumSize,
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      counterText: "",
                      contentPadding: EdgeInsets.all(10),
                      hintStyle: style,
                      hintText: "Enter BVN Number",
                      border: OutlineInputBorder()
                  ),
                  maxLines: 1,
                  maxLength: 11,
                  validator: (value) => value.isEmpty ?  'BVN can\'t be empty' : null,
                  onSaved: (value) => _bvnNumber = value.trim(),
                ),
                fabSize
              ],
            ),
          ),
          state: states[2],
          subtitle: const Text("Number")
      ),

    ];
  }

  next() {
    _currentStep + 1 != 3 ? goTo(_currentStep + 1)  : submitForm();
  }

  cancel() {
    if (_currentStep > 0)
      goBack(_currentStep - 1);
    else
      attemptClose();
  }

  goTo(int step) {
    switch(step){
      case 0:
        goBack(step);
        break;
      case 1:
        var formPersonal = _accountNumberForm.currentState;
        if(formPersonal != null){
          if(formPersonal.validate()){
            formPersonal.save();
            if(_accountNumber.length == 10)
              moveToFormIndex(step);
            else
              toastInfo("Invalid account number");
          }
          else
            states[_currentStep] = StepState.error;
        }
        else
          goBack(step);
        break;
      case 2:
          var bank = _bankList.firstWhere((element) => element.selected, orElse: null);
          if(bank != null)
            verifyAccountNumber(bank);
          else
            toastInfo("Please select a bank");
        break;
    }
    setState(() {

    });
  }

  moveToFormIndex(int step){
    states[_currentStep] = StepState.complete;
    isActives[_currentStep] = false;
    _currentStep = step;
    states[step] = states[step] == StepState.complete ? StepState.complete : StepState.editing;
    isActives[step] = true;
  }

  goBack(int step) {
    isActives.fillRange(0, isActives.length, false);
    isActives[step] = true;
    _currentStep  = step;
    setState(() {  });
  }

  submitForm() {
    var bvnForm = _bvnForm.currentState;
    if(bvnForm.validate()){
      bvnForm.save();
      if(_bvnNumber.length >= 10)
        verifyBVn();
      else
        toastInfo("Invalid BVN Number");
    }
    else
      states[_currentStep] = StepState.error;
    setState(() {});
  }

  void attemptClose() {
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Exit Verification", style: style,),
        content: Text("Are you sure you wanted to exit this verification wizard? If yes, kindly note all information will be cleared"),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel", style: style,),
          ),
          FlatButton(
            onPressed: () => SystemNavigator.pop(animated: true),
            child: Text("Yes", style: style,),
          )
        ],
      );
    });
  }

  onError(Object object) {
    loadingFailed(errorOccurs);
  }

  FutureOr bankListResponse(HttpResponse value) {
    loadingSuccessful(null);
    if(value.response.statusCode == 200){
      var data = value.data as Map;
      _bankList = data.entries.map((e) => BankEntity(e.key, e.value)).toList();
      Repository.getInstance().saveBankList(_bankList);
    }
  }

  Future<void> verifyAccountNumber(BankEntity bank) async {
    await startLoading(context, "Fetching Account Name...");
    var request =  { "inquire": "accountname", "accountnumber": _accountNumber, "bankcode": bank.bankCode };
    RetrofitClientInstance.getInstance().getDataService().verifyAcctNumber(request).then(acctVerificationResponse).catchError(onError);
  }

  FutureOr acctVerificationResponse(BaseData<AccountEntity> value) {
    if(value.status == "success" && value.resolved){
      loadingSuccessful(null);
      _accountName = value.data.account_name;
      moveToFormIndex(_currentStep + 1);
      setState(() {});
    }
    else
      loadingFailed(value.error);
  }

  Future<void> verifyBVn() async {
    await startLoading(context, "Verifying BVN...");
    var request = {"inquire": "bvn", "bvn": _bvnNumber };
    RetrofitClientInstance.getInstance().getDataService().validateBVN(request).then(bvnResponse).catchError(onError);
  }

  FutureOr bvnResponse(BaseData<BvnEntity> value) {
    if(value.status == "success" && value.data != null){
      loadingSuccessful(null);
      var data = { "bvn" : value.data, "account_number" : _accountNumber, "account_name" : _accountName };
      Navigator.pushNamed(context, '/dashboard/response', arguments: data);
      clearForm();
    }
    else
      loadingFailed(value.message);
  }

  void clearForm() {
    _accountName = "";
    _accountNumber = "";
    _bvnNumber = "";
    _currentStep = 0;
    states = [StepState.editing, StepState.indexed, StepState.indexed];
    isActives = [true, false, false];
    _bvnForm.currentState.reset();
    _bankList.forEach((element) => element.selected = false);
    setState(() {});
  }

  reloadBanks() async {
    await startLoading(context, "Fetching available banks...");
    downloadBanks();
  }

  void downloadBanks() {
    var request = {"inquire": "banks"};
    RetrofitClientInstance.getInstance().getDataService().getBankList(request).then(bankListResponse).catchError(onError);
  }
}

