import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tauwisata/common/functions.dart';
import 'package:tauwisata/common/navigation.dart';
import 'package:tauwisata/common/sizeconfig.dart';
import 'package:tauwisata/common/styles.dart';
import 'package:tauwisata/data/helper/preferences_helper.dart';
import 'package:tauwisata/ui/destination/destination_page.dart';
import 'package:tauwisata/ui/guide_page.dart';
import 'package:tauwisata/ui/hotel/hotel_page.dart';
import 'package:tauwisata/ui/quiz/take_quiz_page.dart';
import 'package:tauwisata/ui/foods/food_page.dart';

class DashboardPage extends StatefulWidget {
  static String routeName = 'dashboard_page';

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  PreferencesHelper _preferencesHelper = PreferencesHelper(
    sharedPreferences: SharedPreferences.getInstance(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          Container(
            margin: EdgeInsets.all(20),
            decoration: _decoratedBox(),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Menu Utama",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: primaryDarkColor, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSubMenu(
                        text: 'Wisata',
                        icon: 'assets/icons/icon_submenu_wisata.png',
                        onPressed: () => Navigation.navigate(
                          DestinationPage.routeName,
                        ),
                      ),
                      _buildSubMenu(
                        text: 'Makanan',
                        icon: 'assets/icons/icon_submenu_restoran.png',
                        onPressed: () => Navigation.navigate(
                          FoodPage.routeName,
                        ),
                      ),
                      _buildSubMenu(
                        text: 'Hotel',
                        icon: 'assets/icons/icon_submenu_hotel.png',
                        onPressed: () => Navigation.navigate(
                          HotelPage.routeName,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSubMenu(
                        text: 'Favorit',
                        icon: 'assets/icons/icon_submenu_favorite.png',
                        onPressed: () => showCustomAlert(
                          context,
                          subtitle: "Fitur Favorit akan segera hadir!",
                        ),
                      ),
                      _buildSubMenu(
                        text: 'Petunjuk',
                        icon: 'assets/icons/icon_submenu_about.png',
                        onPressed: () => Navigation.navigate(
                          GuidePage.routeName,
                        ),
                      ),
                      _buildSubMenu(
                        text: 'Pengaturan',
                        icon: 'assets/icons/icon_submenu_setting.png',
                        onPressed: () => showCustomAlert(
                          context,
                          subtitle: "Fitur Pengaturan akan segera hadir!",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildSubMenu({
    String text,
    String icon,
    Function onPressed,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onPressed ?? () {},
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primarySubMenuColor,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(1, 3),
                    blurRadius: 5,
                    spreadRadius: 0,
                    color: primaryShadowColor.withOpacity(0.20),
                  ),
                ],
              ),
              child: Image.asset(
                icon ?? 'assets/icons/icon_submenu_wisata.png',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                text ?? 'Wisata',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption.copyWith(
                    color: primaryBrownColor, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _decoratedBox() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          offset: Offset(-10, -10),
          color: primaryShadowColor.withOpacity(0.10),
          blurRadius: 10,
          spreadRadius: 1,
        ),
        BoxShadow(
          offset: Offset(10, 10),
          color: primaryShadowColor.withOpacity(0.10),
          blurRadius: 10,
          spreadRadius: 1,
        ),
      ],
    );
  }

  Container _buildHeader() {
    return Container(
      width: double.infinity,
      height: SizeConfig.heightMultiplier * 45,
      margin: EdgeInsets.only(bottom: 10),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Image.asset(
              'assets/images/dashboard_header.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMainMenu(
                  text: 'Hasil Kuis',
                  icon: 'assets/icons/icon_result.png',
                  onPressed: () async {
                    final quiz = await _preferencesHelper.quizResult;
                    if (quiz != null) {
                      showCustomAlert(
                        context,
                        title: "Hasil Kuis",
                        subtitle:
                            "Kamu berhasil menjawab ${quiz.correct} dari ${quiz.correct + quiz.wrong} pertanyaan dengan benar!",
                        textConfirm: "Reset Kuis",
                        onConfirm: () {
                          _preferencesHelper.deleteQuizResult();
                        },
                      );
                    } else {
                      showCustomAlert(
                        context,
                        title: "Hasil Kuis",
                        subtitle: 'Silahkan Kerjakan Kuis terlebih dahulu!',
                      );
                    }
                  },
                ),
                _buildMainMenu(
                  text: 'Jawab Kuis',
                  icon: 'assets/icons/icon_quiz.png',
                  onPressed: () async {
                    final quiz = await _preferencesHelper.quizResult;
                    if (quiz != null) {
                      showCustomAlert(
                        context,
                        title: "Kuis telah dikerjakan!",
                        subtitle: "Maaf, kuis ini telah kamu kerjakan!",
                      );
                    } else {
                      Navigation.navigate(TakeQuizPage.routeName);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildMainMenu({
    String text,
    String icon,
    Function onPressed,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      width: SizeConfig.widthMultiplier * 35,
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [primaryBrownColor, secondaryBrownColor],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: primaryShadowColor.withOpacity(0.15),
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: InkWell(
        onTap: onPressed ?? () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text ?? 'Text',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Image.asset(
              icon ?? 'assets/icons/icon_quiz.png',
              width: 50,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
