import 'package:flutter/material.dart';
import 'package:tauwisata/common/styles.dart';

class FavoritePage extends StatelessWidget {
  static String routeName = 'favorite_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        textTheme: customTextTheme,
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.white),
        title: Text('Favorit'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text(
          'Kosong',
          style: Theme.of(context)
              .textTheme
              .bodyText2
              .copyWith(color: primaryRedColor, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
