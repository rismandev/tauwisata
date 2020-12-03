import 'package:flutter/material.dart';
import 'package:tauwisata/common/functions.dart';
import 'package:tauwisata/common/navigation.dart';
import 'package:tauwisata/data/model/food.dart';
import 'package:tauwisata/ui/foods/food_detail_page.dart';
import 'package:tauwisata/ui/layouts/app_list_layout.dart';
import 'package:tauwisata/widgets/card/food.dart';

class FoodPage extends StatefulWidget {
  static String routeName = 'food_page';

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  @override
  Widget build(BuildContext context) {
    return AppListLayout(
      title: "Daftar Restoran",
      subtitle: "Cari tempat makan enak di indonesia!",
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 90),
            ),
            FutureBuilder(
              future: DefaultAssetBundle.of(
                context,
              ).loadString('assets/food.json'),
              builder: (context, snapshot) {
                List<FoodModel> foods = parseFoodFromJson(
                  snapshot.data,
                );
                double sizeHeight = foods.length > 0 ? 166.0 * foods.length : 0;

                return ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: sizeHeight),
                  child: ListView.builder(
                    itemCount: foods.length,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      FoodModel item = foods[index];
                      return FoodCard(
                        photoURL: item.photoURL,
                        title: item.name,
                        location: item.location,
                        description: item.description,
                        onPressDetail: () => Navigation.navigate(
                          FoodDetailPage.routeName,
                          arguments: item,
                        ),
                        onPressFavorite: () => showCustomAlert(
                          context,
                          subtitle: "Fitur Tambah Favorit akan segera hadir!",
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
