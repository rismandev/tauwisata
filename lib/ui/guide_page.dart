import 'package:flutter/material.dart';
import 'package:tauwisata/common/sizeconfig.dart';
import 'package:tauwisata/common/styles.dart';

class GuidePage extends StatelessWidget {
  static String routeName = 'guide_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          height: SizeConfig.heightMultiplier * 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [gradientPrimaryGreen, primaryGreenColor],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    'Petunjuk TauWisata',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(shadows: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: primaryShadowColor,
                        blurRadius: 4,
                        spreadRadius: 0,
                      ),
                    ], color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
                _buildQuizGuide(context),
                _buildDestinationGuide(context),
                _buildFoodGuide(context),
                _buildHotelGuide(context),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildHotelGuide(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: primaryShadowColor.withOpacity(0.30),
            blurRadius: 10,
            offset: Offset.zero,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              'Fitur Hotel',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: primaryRedColor, fontWeight: FontWeight.w600),
            ),
          ),
          Divider(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hotel yang ditampilkan merupakan Hotel yang berada di Seluruh Indonesia.',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      color: primaryDarkColor, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Text(
                  'Kamu bisa menambahkan beberapa hotel ke daftar favorit dengan menekan icon love di halaman detail.',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      color: primaryDarkColor, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildFoodGuide(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: primaryShadowColor.withOpacity(0.30),
            blurRadius: 10,
            offset: Offset.zero,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              'Fitur Makanan',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: primaryRedColor, fontWeight: FontWeight.w600),
            ),
          ),
          Divider(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Makanan yang ditampilkan merupakan Makanan Khas di Seluruh Indonesia.',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      color: primaryDarkColor, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Text(
                  'Kamu bisa menambahkan beberapa makanan ke daftar favorit dengan menekan icon love di halaman detail.',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      color: primaryDarkColor, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildDestinationGuide(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: primaryShadowColor.withOpacity(0.30),
            blurRadius: 10,
            offset: Offset.zero,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              'Fitur Wisata',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: primaryRedColor, fontWeight: FontWeight.w600),
            ),
          ),
          Divider(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wisata yang ditampilkan merupakan Destinasi Wisata di Seluruh Indonesia.',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      color: primaryDarkColor, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Text(
                  'Terdapat 3 Kategori yang sudah dikelompokkan oleh TauWisata, antara lain :\n\nWisata alam,\nWisata bahari\nWisata budaya.\n',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      color: primaryDarkColor, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Text(
                  'Kamu bisa menambahkan beberapa wisata ke daftar favorit dengan menekan icon love di halaman detail.',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      color: primaryDarkColor, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildQuizGuide(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: primaryShadowColor.withOpacity(0.30),
            blurRadius: 10,
            offset: Offset.zero,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              'Fitur Kuis',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: primaryRedColor, fontWeight: FontWeight.w600),
            ),
          ),
          Divider(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kuis berisi 10 soal dengan pertanyaan acak seputar wisata, makanan dan penginapan.',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      color: primaryDarkColor, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Text(
                  'Setiap pertanyaan hanya dapat menjawab max 15 detik.',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      color: primaryDarkColor, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Text(
                  'Jika waktu yang diberikan habis, maka kuis akan dianggap salah.',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      color: primaryDarkColor, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Text(
                  'Hasil Kuis akan tersimpan setelah kamu selesai menjawab 10 soal.',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      color: primaryDarkColor, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Text(
                  'Saat ini kamu hanya dapat menyimpan hasil kuis sebanyak 1 kali',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      color: primaryDarkColor, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Text(
                  'Kamu bisa mengulang kuis dengan mereset hasil kuis sebelumnya.',
                  style: Theme.of(context).textTheme.caption.copyWith(
                      color: primaryDarkColor, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
