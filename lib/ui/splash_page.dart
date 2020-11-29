import 'package:flutter/material.dart';
import 'package:tauwisata/common/navigation.dart';
import 'package:tauwisata/common/styles.dart';
import 'package:tauwisata/ui/welcome_page.dart';

class SplashPage extends StatefulWidget {
  static String routeName = 'splash_page';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _actionDelay();
    super.initState();
  }

  void _actionDelay() async {
    await Future.delayed(Duration(seconds: 3), () {
      Navigation.pushAndRemove(WelcomePage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: primaryGreenColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                'assets/images/splash.png',
                fit: BoxFit.contain,
              ),
            ),
            CircularProgressIndicator(
              backgroundColor: primaryRedColor,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
