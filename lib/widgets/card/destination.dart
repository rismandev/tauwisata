import 'package:flutter/material.dart';
import 'package:tauwisata/common/styles.dart';
import 'package:tauwisata/widgets/skeleton/skeletonloader.dart';

class DestinationCard extends StatelessWidget {
  final String photoURL;
  final String title;
  final String location;
  final String description;
  final Function onPressFavorite;
  final Function onPressDetail;

  const DestinationCard({
    Key key,
    @required this.photoURL,
    this.title,
    this.location,
    this.description,
    this.onPressFavorite,
    this.onPressDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
      decoration: _decoratedBox(),
      child: Row(
        children: [
          InkWell(
            onTap: onPressDetail,
            child: _buildPhoto(),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 2.5),
                  InkWell(
                    onTap: onPressDetail,
                    child: Text(
                      title ?? 'Title',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                          height: 1,
                          color: primaryDarkColor,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(height: 5),
                  InkWell(
                    onTap: onPressDetail,
                    child: Text(
                      location ?? 'Kota, Provinsi',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                          color: primaryDarkColor,
                          height: 1,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: InkWell(
                      onTap: onPressDetail,
                      child: Text(
                        description ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: Theme.of(context).textTheme.caption.copyWith(
                            color: primaryDarkColor,
                            fontWeight: FontWeight.w300,
                            height: 1.25,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onPressFavorite,
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        'Tambahkan ke favorit',
                        style: Theme.of(context).textTheme.caption.copyWith(
                            color: primaryRedColor,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildPhoto() {
    return Container(
      width: 100,
      height: 130,
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          this.photoURL,
          fit: BoxFit.cover,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) {
              return child;
            }
            return AnimatedOpacity(
              child: child,
              opacity: frame == null ? 0 : 1,
              duration: const Duration(seconds: 1),
              curve: Curves.easeOut,
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress != null) {
              return SkeletonLoader();
            }
            return child;
          },
        ),
      ),
    );
  }

  BoxDecoration _decoratedBox() {
    return BoxDecoration(
      color: Colors.white,
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
    );
  }
}
