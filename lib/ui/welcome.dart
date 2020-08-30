  import 'package:flutter/material.dart';
import 'package:flutter_starter_app/utils/const.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class WelcomeActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            SizedBox(height: 180,),
            Expanded(
              child: IntroductionScreen(
                globalBackgroundColor: Colors.transparent,
                showNextButton: true,
                showSkipButton: true,
                skip: Text("Skip"),
                next: Text("Next"),
                done: Text("Get Started"),
                pages: getPages(),
                onDone: () => gotoLoginPage(context),
                onSkip: () => gotoLoginPage(context),
              ),
            ),
          ],
        ),
      ),
    );

  }

  final myPage = const PageDecoration(
    bodyTextStyle: TextStyle(fontSize: 14)
  );
  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        image: Image.asset("assets/splash1.png"),
        title: "Know your customer",
        body: "Get to know your customer information according to CBN regulation",
        decoration: myPage
      ),
      PageViewModel(
        image: Image.asset("assets/splash2.png"),
        title: "Account Name Search",
        body: "Fetching an account name from bank made easy. You only needs customer's account number",
          decoration: myPage
      ),
      PageViewModel(
        image: Image.asset("assets/splash3.png"),
        title: "BVN Verification",
        body: "Verify customer identity on the go. Match there BVN record against their provided information",
          decoration: myPage
      ),
    ];
  }

  gotoLoginPage(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(Const.FIRST_TIME, false);
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

}
