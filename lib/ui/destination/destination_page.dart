import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tauwisata/common/enum.dart';
import 'package:tauwisata/common/functions.dart';
import 'package:tauwisata/common/navigation.dart';
import 'package:tauwisata/common/styles.dart';
import 'package:tauwisata/data/model/destination.dart';
import 'package:tauwisata/data/model/favorite.dart';
import 'package:tauwisata/data/provider/database_provider.dart';
import 'package:tauwisata/data/provider/destination_provider.dart';
import 'package:tauwisata/ui/destination/destination_detail_page.dart';
import 'package:tauwisata/ui/layouts/app_list_layout.dart';
import 'package:tauwisata/widgets/card/destination.dart';

class DestinationPage extends StatefulWidget {
  static String routeName = 'destination_page';

  @override
  _DestinationPageState createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  ScrollController _scrollController = ScrollController();
  String _selectedFilter = "";

  @override
  void initState() {
    _scrollController.addListener(() {
      // Implement Animated Scroll
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void changeMenu(DestinationCategory menu) {
    switch (menu) {
      case DestinationCategory.ALAM:
        if (_selectedFilter == "alam") {
          setState(() {
            _selectedFilter = "";
          });
        } else {
          setState(() {
            _selectedFilter = "alam";
          });
        }
        break;
      case DestinationCategory.BAHARI:
        if (_selectedFilter == "bahari") {
          setState(() {
            _selectedFilter = "";
          });
        } else {
          setState(() {
            _selectedFilter = "bahari";
          });
        }
        break;
      case DestinationCategory.BUDAYA:
        if (_selectedFilter == "budaya") {
          setState(() {
            _selectedFilter = "";
          });
        } else {
          setState(() {
            _selectedFilter = "budaya";
          });
        }
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppListLayout(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              margin: EdgeInsets.only(top: 70),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMenu(
                    context,
                    icon: 'assets/icons/icon_cagar_alam.png',
                    text: "Wisata alam",
                    isActive: _selectedFilter == "alam",
                    onPressed: () => changeMenu(DestinationCategory.ALAM),
                  ),
                  _buildMenu(
                    context,
                    icon: 'assets/icons/icon_bahari.png',
                    text: "Wisata bahari",
                    isActive: _selectedFilter == "bahari",
                    onPressed: () => changeMenu(DestinationCategory.BAHARI),
                  ),
                  _buildMenu(
                    context,
                    icon: 'assets/icons/icon_budaya.png',
                    text: "Wisata budaya",
                    isActive: _selectedFilter == "budaya",
                    onPressed: () => changeMenu(DestinationCategory.BUDAYA),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: DefaultAssetBundle.of(
                context,
              ).loadString('assets/destination.json'),
              builder: (context, snapshot) {
                List<DestinationModel> destinations = parseDestinationFromJson(
                  snapshot.data,
                  filter: _selectedFilter,
                );
                double sizeHeight =
                    destinations.length > 0 ? 166.0 * destinations.length : 0;

                return ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: sizeHeight),
                  child: ListView.builder(
                    itemCount: destinations.length,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      DestinationModel item = destinations[index];
                      return Consumer2<DatabaseProvider, DestinationProvider>(
                        builder: (context, provider, dProvider, child) {
                          return DestinationCard(
                            id: item.id,
                            photoURL: item.photoURL,
                            title: item.name,
                            location: item.location,
                            description: item.description,
                            onPressDetail: () {
                              if (!dProvider.isMinimum) {
                                dProvider.onChangeDetailSize();
                              }
                              Navigation.navigate(
                                DestinationDetailPage.routeName,
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
                                subMenu: 'destination',
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

  Expanded _buildMenu(
    BuildContext context, {
    String text,
    String icon,
    bool isActive = false,
    Function onPressed,
  }) {
    return Expanded(
      child: Container(
        height: 90,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isActive ? primaryGreenColor.withOpacity(0.5) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: secondaryShadowColor.withOpacity(0.20),
              offset: Offset(-5, -5),
              blurRadius: 5,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: secondaryShadowColor.withOpacity(0.20),
              offset: Offset(5, 5),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        child: InkWell(
          onTap: onPressed ?? () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                icon ?? 'assets/icons/icon_cagar_alam.png',
                width: 30,
                height: 30,
              ),
              Text(
                text ?? 'Wisata alam',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption.copyWith(
                    color: primaryDarkColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
