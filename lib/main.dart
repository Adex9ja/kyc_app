import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_starter_app/core/retrofit_client.dart';
import 'package:flutter_starter_app/db/app_database.dart';
import 'package:flutter_starter_app/ui/dashboard.dart';
import 'package:flutter_starter_app/ui/verification_response.dart';
import 'package:flutter_starter_app/ui/welcome.dart';
import 'package:flutter_starter_app/utils/const.dart';
import 'package:flutter_starter_app/utils/secret.dart';
import 'package:flutter_starter_app/utils/secret_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  _MyApp createState()  => _MyApp();
}

class _MyApp extends State<MyApp>{

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF017E30), //or set color with:
    ));
    return MaterialApp(
      title: 'Bill Splitter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: colorWhite,
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: colorPrimary,
      ),
      home: FutureBuilder(
        future: isFirstTime(),
        builder: (context, snapshot){
          if(snapshot.hasData)
            return snapshot.data ? WelcomeActivity() : DashBoardActivity();
          else
            return Center( child: CircularProgressIndicator(),);
        },
      ),
      routes: {
        '/dashboard' : (context) => DashBoardActivity(),
        '/dashboard/response' : (context) => ResponseActivity(),
      },
    );
  }

  Future<bool> isFirstTime() async {
    await AppDatabase.init();
    Secret secret = await SecretLoader(secretPath: "assets/config.json").load();
    RetrofitClientInstance.getInstance().reset(secret.merchantID, secret.merchantKey);
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(Const.FIRST_TIME) ?? true;
  }
}



//Styles
final TextStyle style = TextStyle( fontSize: 14.0);
final TextStyle style2 = TextStyle( fontSize: 14.0, color: colorGrey);

//Colors
final Color colorPrimary = Colors.green;
final Color colorRed = Colors.red;
final Color colorWhite = Colors.white;
final Color colorLightGrey = Color(0xFFF0F0F0);
final Color colorGrey = Colors.grey;
final Color colorBlack = Colors.black;
final Color colorBlue = Colors.blue;

//Sizes
final SizedBox smallSize = SizedBox(height: 5.0,);
final SizedBox mediumSize = SizedBox(height: 10.0,);
final SizedBox fabSize = SizedBox(height: 16.0,);
final SizedBox bigSize = SizedBox(height: 20.0,);

//Paddings
final EdgeInsets smallSpacing = EdgeInsets.all(5);
final EdgeInsets mediumSpacing = EdgeInsets.all(10);
final EdgeInsets fabSpacing = EdgeInsets.all(16);
final EdgeInsets bigSpacing = EdgeInsets.all(20);


final String errorOccurs = "Network Connection Fails!";

ProgressDialog _progressDialog;
Future<void> startLoading(BuildContext context, [String message = "Please wait..."]) async {
  if(_progressDialog != null && _progressDialog.isShowing()) _progressDialog.hide();
  _progressDialog = ProgressDialog(context, isDismissible: false,);
  _progressDialog.update(message: message, progress: 100);
  await _progressDialog.show();
}
void updateLoading(BuildContext context, String message){
  _progressDialog.update(message: message);
}
void loadingSuccessful(String message,  [bool showDialog = false, BuildContext context]){
  if(_progressDialog != null && _progressDialog.isShowing()) _progressDialog.hide().then((isHidden){
    if(message != null){
      if(showDialog)
        showMessageWithDialog(message, context);
      else
        toastSuccess(message);
    }
  });
}
void showMessageWithDialog(String message, BuildContext context) {
  showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      title: Text("Message", style: style,),
      content: Text(message, style: style,),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Okay", style: style,),
        )
      ],
    );
  });
}
Future<void> loadingFailed(String message) async {
  if(_progressDialog!= null )
    await _progressDialog.hide();
  if(message != null)
    toastError(message);
}
void toastSuccess(String message) {
  Fluttertoast.showToast(msg: message == null ? '' : message, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.green, textColor: Colors.white);
}
void toastInfo(String message) {
  Fluttertoast.showToast(msg: message == null ? '' : message, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.blue, textColor: Colors.white, );
}
void toastError(String message) {
  Fluttertoast.showToast(msg: message == null ? '' : message, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.red, textColor: Colors.white);
}
