import 'package:flutter/material.dart';
import 'package:tauwisata/common/styles.dart';
import 'package:tauwisata/ui/favorite/destination.dart';
import 'package:tauwisata/ui/favorite/food.dart';
import 'package:tauwisata/ui/favorite/hotel.dart';

class FavoritePage extends StatelessWidget {
  static String routeName = 'favorite_page';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          textTheme: customTextTheme,
          iconTheme: IconThemeData(color: Colors.white),
          actionsIconTheme: IconThemeData(color: Colors.white),
          title: Text('Favorit'),
          bottom: _buildTabBar(context),
        ),
        body: TabBarView(
          children: [
            FavoriteDestination(),
            FavoriteFood(),
            FavoriteHotel(),
          ],
        ),
      ),
    );
  }

  TabBar _buildTabBar(BuildContext context) {
    return TabBar(
      indicatorColor: Colors.white,
      labelPadding: EdgeInsets.symmetric(vertical: 10),
      unselectedLabelColor: primaryDarkColor.withOpacity(0.7),
      labelColor: Colors.white,
      unselectedLabelStyle: Theme.of(context)
          .textTheme
          .subtitle2
          .copyWith(fontWeight: FontWeight.w400),
      labelStyle: Theme.of(context)
          .textTheme
          .subtitle2
          .copyWith(fontWeight: FontWeight.w600),
      tabs: [
        Text('Destinasi'),
        Text('Makanan'),
        Text('Hotel'),
      ],
    );
  }
}
