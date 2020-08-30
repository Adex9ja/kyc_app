import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_app/main.dart';

class ResponseActivity extends StatefulWidget{
  @override
  _ResponseActivity createState() => _ResponseActivity();
}

class _ResponseActivity extends State<ResponseActivity>{
  Map data;
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Verification Completed"),
      ),
      body: SafeArea(
        child: Padding(
          padding: mediumSpacing,
          child:  Column(
            children: <Widget>[
              fabSize,
              Center(
                  child: Icon(Icons.verified_user, color: colorPrimary, size: 128,),
                ),
              fabSize,
              Row(
                children: <Widget>[
                  Text("Account Number", style: style2,),
                  Expanded(child: Text(data['account_number'], style: style, textAlign: TextAlign.right,),)
                ],
              ),
              mediumSize,
              Row(
                children: <Widget>[
                  Text("Account Name", style: style2,),
                  Expanded(child: Text(data['account_name'], style: style, textAlign: TextAlign.right,),)
                ],
              ),
              mediumSize,
              Row(
                children: <Widget>[
                  Text("BVN", style: style2,),
                  Expanded(child: Text(data['bvn'].bvn, style: style, textAlign: TextAlign.right,),)
                ],
              ),
              mediumSize,
              Row(
                children: <Widget>[
                  Text("Phone Number", style: style2,),
                  Expanded(child: Text(data['bvn'].phone, style: style, textAlign: TextAlign.right,),)
                ],
              ),
              mediumSize,
              Row(
                children: <Widget>[
                  Text("Date of Birth", style: style2,),
                  Expanded(child: Text(data['bvn'].dob, style: style, textAlign: TextAlign.right,),)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}