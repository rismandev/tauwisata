import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tauwisata/common/functions.dart';
import 'package:tauwisata/common/navigation.dart';
import 'package:tauwisata/data/model/favorite.dart';
import 'package:tauwisata/data/model/food.dart';
import 'package:tauwisata/data/provider/database_provider.dart';
import 'package:tauwisata/data/provider/food_provider.dart';
import 'package:tauwisata/ui/foods/food_detail_page.dart';
import 'package:tauwisata/ui/layouts/app_list_layout.dart';
import 'package:tauwisata/widgets/card/food.dart';

class FoodPage extends StatelessWidget {
  static String routeName = 'food_page';

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
                      return Consumer2<DatabaseProvider, FoodProvider>(
                        builder: (context, provider, fProvider, child) {
                          return FoodCard(
                            id: item.id,
                            photoURL: item.photoURL,
                            title: item.name,
                            location: item.location,
                            description: item.description,
                            onPressDetail: () {
                              if (!fProvider.isMinimum) {
                                fProvider.onChangeDetailSize();
                              }
                              Navigation.navigate(
                                FoodDetailPage.routeName,
                                arguments: item,
                              );
                            },
                            onPressFavorite: () {
                              FavoriteModel model = new FavoriteModel(
                                id: item.id,
                                name: item.name,
                                category: item.category,
                                description: item.description,
                                location: item.location,
                                photoURL: item.photoURL,
                                price: item.price,
                                totalFavorite: item.totalFavorite,
                                subMenu: 'food',
                              );
                              provider.addFavorite(model).then((value) {
                                if (value) {
                                  showCustomSnackBar(
                                    context,
                                    useContext: true,
                                    text: "Berhasil menambahkan ke favorite!",
                                    backgroundColor: Colors.green[800],
                                    textColor: Colors.white,
                                    duration: Duration(milliseconds: 800),
                                  );
                                }
                              });
                            },
                          );
                        },
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
