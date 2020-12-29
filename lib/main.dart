import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tauwisata/common/navigation.dart';
import 'package:tauwisata/common/sizeconfig.dart';
import 'package:tauwisata/common/styles.dart';
import 'package:tauwisata/data/helper/database_helper.dart';
import 'package:tauwisata/data/provider/database_provider.dart';
import 'package:tauwisata/data/provider/destination_provider.dart';
import 'package:tauwisata/data/provider/food_provider.dart';
import 'package:tauwisata/data/provider/hotel_provider.dart';
import 'package:tauwisata/ui/dashboard_page.dart';
import 'package:tauwisata/ui/destination/destination_page.dart';
import 'package:tauwisata/ui/destination/destination_detail_page.dart';
import 'package:tauwisata/ui/favorite/favorite_page.dart';
import 'package:tauwisata/ui/foods/food_detail_page.dart';
import 'package:tauwisata/ui/guide_page.dart';
import 'package:tauwisata/ui/hotel/hotel_detail_page.dart';
import 'package:tauwisata/ui/hotel/hotel_page.dart';
import 'package:tauwisata/ui/quiz/take_quiz_page.dart';
import 'package:tauwisata/ui/foods/food_page.dart';
import 'package:tauwisata/ui/settings_page.dart';
import 'package:tauwisata/ui/splash_page.dart';
import 'package:tauwisata/ui/welcome_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
        ChangeNotifierProvider(create: (context) => DestinationProvider()),
        ChangeNotifierProvider(create: (context) => FoodProvider()),
        ChangeNotifierProvider(create: (context) => HotelProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);

            return MaterialApp(
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child,
                );
              },
              title: 'TauWisata',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: primaryGreenColor,
                textTheme: customTextTheme,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              navigatorKey: navigatorKey,
              routes: {
                SplashPage.routeName: (_) => SplashPage(),
                WelcomePage.routeName: (_) => WelcomePage(),
                DashboardPage.routeName: (_) => DashboardPage(),
                DestinationPage.routeName: (_) => DestinationPage(),
                FoodPage.routeName: (_) => FoodPage(),
                HotelPage.routeName: (_) => HotelPage(),
                TakeQuizPage.routeName: (_) => TakeQuizPage(),
                GuidePage.routeName: (_) => GuidePage(),
                SettingsPage.routeName: (_) => SettingsPage(),
                FavoritePage.routeName: (_) => FavoritePage(),
                DestinationDetailPage.routeName: (context) =>
                    DestinationDetailPage(
                      destination: ModalRoute.of(context).settings.arguments,
                    ),
                FoodDetailPage.routeName: (context) => FoodDetailPage(
                      food: ModalRoute.of(context).settings.arguments,
                    ),
                HotelDetailPage.routeName: (context) => HotelDetailPage(
                      hotel: ModalRoute.of(context).settings.arguments,
                    ),
              },
              initialRoute: SplashPage.routeName,
            );
          },
        );
      },
    );
  }
}
