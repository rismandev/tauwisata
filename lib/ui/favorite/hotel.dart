import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tauwisata/common/enum.dart';
import 'package:tauwisata/common/functions.dart';
import 'package:tauwisata/common/navigation.dart';
import 'package:tauwisata/common/styles.dart';
import 'package:tauwisata/data/model/hotel.dart';
import 'package:tauwisata/data/provider/database_provider.dart';
import 'package:tauwisata/ui/destination/destination_detail_page.dart';
import 'package:tauwisata/widgets/card/hotel.dart';

class FavoriteHotel extends StatelessWidget {
  const FavoriteHotel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Consumer<DatabaseProvider>(
        builder: (context, value, child) {
          if (value.state == ResultState.Loading) {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                backgroundColor: primaryRedColor,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          } else if (value.state == ResultState.Error) {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              child: Text(
                'Maaf sepertinya ada kesalahan, silahkan buka ulang aplikasi!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: primaryRedColor, fontWeight: FontWeight.w600),
              ),
            );
          } else if (value.hotels.length == 0) {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              child: Text(
                'Kamu belum mempunyai Hotel Favorit, Silahkan tambahkan dari menu Hotel!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: primaryRedColor, fontWeight: FontWeight.w600),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: value.hotels.length,
              padding: EdgeInsets.symmetric(vertical: 20),
              itemBuilder: (context, index) {
                HotelModel item = value.hotels[index];
                return Consumer<DatabaseProvider>(
                  builder: (context, provider, child) {
                    return HotelCard(
                      id: item.id,
                      photoURL: item.photoURL,
                      title: item.name,
                      location: item.location,
                      marginTop: index == 0 ? 20 : null,
                      description: item.description,
                      onPressDetail: () => Navigation.navigate(
                        DestinationDetailPage.routeName,
                        arguments: item,
                      ),
                      useRemoveFunction: true,
                      onPressFavorite: () {
                        provider.removeFavorite(item.id).then((value) {
                          if (value) {
                            showCustomSnackBar(
                              context,
                              useContext: true,
                              text: "Berhasil menghapus dari favorite!",
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
            );
          }
        },
      ),
    );
  }
}
