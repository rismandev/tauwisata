import 'package:flutter/material.dart';
// import 'package:tauwisata/common/functions.dart';
import 'package:tauwisata/common/sizeconfig.dart';
import 'package:tauwisata/common/styles.dart';

class AppListLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onPressFilter;
  final Widget child;

  const AppListLayout({
    Key key,
    this.title,
    this.subtitle,
    this.onPressFilter,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: SizeConfig.heightMultiplier * 100,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Stack(
          children: [
            if (this.child != null) ...{
              this.child,
            },
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildAppHeader(context),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildAppHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  this.title ?? 'Destinasi Wisata',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: primaryDarkColor, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 2.5),
                Text(
                  this.subtitle ?? 'Cari lebih banyak wisata di indonesia!',
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                      height: 1,
                      color: primaryDarkColor,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          // InkWell(
          //   onTap: () => showCustomAlert(
          //     context,
          //     title: "Segera Hadir!",
          //     subtitle:
          //         "Fitur ini akan segera hadir, Silahkan dukung kami agar lebih cepat kami kerjakan!",
          //   ),
          //   child: Container(
          //     padding: EdgeInsets.all(10),
          //     margin: EdgeInsets.only(left: 10),
          //     decoration: BoxDecoration(
          //       color: primaryGreenColor,
          //       shape: BoxShape.circle,
          //     ),
          //     child: Image.asset(
          //       'assets/icons/icon_filter.png',
          //       width: 20,
          //       height: 20,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
