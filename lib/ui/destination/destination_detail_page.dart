import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tauwisata/common/functions.dart';
import 'package:tauwisata/common/navigation.dart';
import 'package:tauwisata/common/sizeconfig.dart';
import 'package:tauwisata/common/styles.dart';
import 'package:tauwisata/data/model/destination.dart';
import 'package:tauwisata/data/model/favorite.dart';
import 'package:tauwisata/data/provider/database_provider.dart';
import 'package:tauwisata/data/provider/destination_provider.dart';
import 'package:tauwisata/widgets/button/green_primary.dart';

class DestinationDetailPage extends StatelessWidget {
  static String routeName = 'destination_detail_page';

  final DestinationModel destination;

  const DestinationDetailPage({
    Key key,
    @required this.destination,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: SizeConfig.heightMultiplier * 50,
            decoration: BoxDecoration(
              color: primaryShadowColor,
            ),
            child: Image.network(
              destination.photoURL,
              fit: BoxFit.cover,
            ),
          ),
          Consumer<DestinationProvider>(
            builder: (context, model, child) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 350),
                curve: Curves.easeIn,
                width: double.infinity,
                height: model.detailSize,
                margin: EdgeInsets.only(
                  top: model.detailMargin,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Stack(
                  overflow: Overflow.visible,
                  children: [
                    _buildDetail(
                      context,
                      onPressed: model.onChangeDetailSize,
                    ),
                    Positioned(
                      top: -25,
                      right: 25,
                      child: Consumer<DatabaseProvider>(
                        builder: (context, value, child) {
                          return FutureBuilder(
                            future: value.isFavorite(destination.id),
                            builder: (context, snapshot) {
                              bool _isFavorite = snapshot.data ?? false;

                              return _buildFavoriteButton(
                                isFavorite: _isFavorite,
                                onPressed: () {
                                  if (_isFavorite) {
                                    provider
                                        .removeFavorite(destination.id)
                                        .then((value) {
                                      if (value) {
                                        showCustomSnackBar(
                                          context,
                                          useContext: true,
                                          text:
                                              "Berhasil menghapus dari favorite!",
                                          backgroundColor: Colors.green[800],
                                          textColor: Colors.white,
                                          duration: Duration(milliseconds: 800),
                                        );
                                      }
                                    });
                                  } else {
                                    FavoriteModel model = new FavoriteModel(
                                      id: destination.id,
                                      name: destination.name,
                                      category: destination.category,
                                      description: destination.description,
                                      location: destination.location,
                                      photoURL: destination.photoURL,
                                      price: destination.price,
                                      totalFavorite: destination.totalFavorite,
                                      subMenu: 'destination',
                                    );
                                    provider.addFavorite(model).then((value) {
                                      if (value) {
                                        showCustomSnackBar(
                                          context,
                                          useContext: true,
                                          text:
                                              "Berhasil menambahkan ke favorite!",
                                          backgroundColor: Colors.green[800],
                                          textColor: Colors.white,
                                          duration: Duration(milliseconds: 800),
                                        );
                                      }
                                    });
                                  }
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 15,
            child: InkWell(
              onTap: () => Navigation.back(),
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Image.asset(
                  'assets/icons/icon_back.png',
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 15),
              child: GreenPrimaryButton(
                onPressed: () => handleShare(
                  title: "TauWisata - ${destination.name}",
                  subject: destination.description,
                ),
                icon: Icons.share,
                text: "Bagikan",
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetail(BuildContext context, {Function onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: Container(
                  width: 80,
                  height: 4,
                  decoration: BoxDecoration(
                    color: primaryDarkColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              Text(
                destination.name ?? '-',
                style: Theme.of(context).textTheme.headline5.copyWith(
                    color: primaryDarkColor, fontWeight: FontWeight.w700),
              ),
              Text(
                destination.location ?? 'Jakarta Utara, Indonesia',
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: primaryDarkColor,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildSection(
                      context,
                      text: destination.price,
                    ),
                    _buildSection(
                      context,
                      background: primaryRedPriceColor.withOpacity(0.20),
                      icon: 'assets/icons/icon_submenu_favorite.png',
                      title: 'Total Favorit',
                      text: '${destination.totalFavorite}',
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 5),
                child: Text(
                  'Deskripsi',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: primaryDarkColor, fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                destination.description ?? "No description",
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: primaryDarkColor, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildSection(
    BuildContext context, {
    Color background,
    String title,
    String text,
    String icon,
  }) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: background ?? primaryYellowPriceColor,
            ),
            child: Image.asset(
              icon ?? 'assets/icons/icon_price.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? 'Price (IDR)',
                style: Theme.of(context).textTheme.caption.copyWith(
                    color: primaryDarkColor, fontWeight: FontWeight.w400),
              ),
              Text(
                text ?? '50.000',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: primaryDarkColor, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InkWell _buildFavoriteButton({
    bool isFavorite = false,
    Function onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              offset: Offset(-2, -3),
              blurRadius: 10,
              spreadRadius: 0,
              color: primaryShadowColor.withOpacity(0.20),
            ),
            BoxShadow(
              offset: Offset(2, 3),
              blurRadius: 10,
              spreadRadius: 0,
              color: primaryShadowColor.withOpacity(0.20),
            ),
          ],
        ),
        child: Image.asset(
          isFavorite
              ? 'assets/icons/icon_submenu_favorite.png'
              : 'assets/icons/icon_favorite_default.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
