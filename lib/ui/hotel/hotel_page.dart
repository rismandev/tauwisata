import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tauwisata/common/functions.dart';
import 'package:tauwisata/common/navigation.dart';
import 'package:tauwisata/data/model/favorite.dart';
import 'package:tauwisata/data/model/hotel.dart';
import 'package:tauwisata/data/provider/database_provider.dart';
import 'package:tauwisata/data/provider/hotel_provider.dart';
import 'package:tauwisata/ui/hotel/hotel_detail_page.dart';
import 'package:tauwisata/ui/layouts/app_list_layout.dart';
import 'package:tauwisata/widgets/card/hotel.dart';

class HotelPage extends StatelessWidget {
  static String routeName = 'hotel_page';

  @override
  Widget build(BuildContext context) {
    return AppListLayout(
      title: "Daftar Penginapan",
      subtitle: "Cari tempat penginapan ternyaman di Indonesia!",
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 90),
            ),
            FutureBuilder(
              future: DefaultAssetBundle.of(
                context,
              ).loadString('assets/hotel.json'),
              builder: (context, snapshot) {
                List<HotelModel> hotels = parseHotelFromJson(
                  snapshot.data,
                );
                double sizeHeight =
                    hotels.length > 0 ? 166.0 * hotels.length : 0;

                return ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: sizeHeight),
                  child: ListView.builder(
                    itemCount: hotels.length,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      HotelModel item = hotels[index];
                      return Consumer2<DatabaseProvider, HotelProvider>(
                        builder: (context, provider, hProvider, child) {
                          return HotelCard(
                            id: item.id,
                            photoURL: item.photoURL,
                            title: item.name,
                            location: item.location,
                            description: item.description,
                            onPressDetail: () {
                              if (!hProvider.isMinimum) {
                                hProvider.onChangeDetailSize();
                              }
                              Navigation.navigate(
                                HotelDetailPage.routeName,
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
                                subMenu: 'hotel',
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
