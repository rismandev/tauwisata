import 'package:flutter/material.dart';
import 'package:tauwisata/common/navigation.dart';
import 'package:tauwisata/common/sizeconfig.dart';
import 'package:tauwisata/common/styles.dart';
import 'package:tauwisata/ui/dashboard_page.dart';
import 'package:tauwisata/widgets/button/red_primary.dart';

class WelcomePage extends StatelessWidget {
  static String routeName = 'welcome_page';

  final String _text =
      'Jangan khawatir, kini dengan aplikasi TauWisata kamu bisa dengan mudah mencari destinasi wisata, tempat makan, dan penginapan untuk berlibur.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildLogo(),
              _buildTitle(context),
              _buildDescription(context),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: RedPrimaryButton(
                    onPressed: () => Navigation.pushAndRemove(
                      DashboardPage.routeName,
                    ),
                    text: "Lanjut",
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset('assets/shapes/shape_top.png'),
          ),
        ],
      ),
    );
  }

  Container _buildDescription(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.symmetric(vertical: 30),
      child: Text(
        _text,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(color: primaryDarkColor, fontWeight: FontWeight.w400),
      ),
    );
  }

  Container _buildTitle(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Text(
        'Pusing Cari Tempat Liburan?',
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(color: primaryDarkColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container _buildLogo() {
    return Container(
      width: double.infinity,
      alignment: Alignment.bottomCenter,
      height: SizeConfig.heightMultiplier * 50,
      child: Container(
        width: SizeConfig.widthMultiplier * 80,
        margin: EdgeInsets.only(bottom: 20),
        child: Image.asset(
          'assets/images/welcome.png',
        ),
      ),
    );
  }
}
