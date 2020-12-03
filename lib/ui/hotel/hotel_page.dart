import 'package:flutter/material.dart';
import 'package:tauwisata/common/functions.dart';
import 'package:tauwisata/common/navigation.dart';
import 'package:tauwisata/data/model/hotel.dart';
import 'package:tauwisata/ui/hotel/hotel_detail_page.dart';
import 'package:tauwisata/ui/layouts/app_list_layout.dart';
import 'package:tauwisata/widgets/card/hotel.dart';

class HotelPage extends StatefulWidget {
  static String routeName = 'hotel_page';

  @override
  _HotelPageState createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
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
                      return HotelCard(
                        photoURL: item.photoURL,
                        title: item.name,
                        location: item.location,
                        description: item.description,
                        onPressDetail: () => Navigation.navigate(
                          HotelDetailPage.routeName,
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
