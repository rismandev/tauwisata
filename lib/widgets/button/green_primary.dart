import 'package:flutter/material.dart';
import 'package:tauwisata/common/styles.dart';

class GreenPrimaryButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final BorderRadius borderRadius;
  final IconData icon;

  const GreenPrimaryButton({
    Key key,
    this.text,
    this.onPressed,
    this.borderRadius,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed ?? () {},
      color: primaryGreenColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(10),
      ),
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      splashColor: primaryBrownColor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text ?? 'Button',
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          if (icon != null) ...{
            SizedBox(width: 20),
            Icon(
              icon,
              color: Colors.white,
            ),
          },
        ],
      ),
    );
  }
}
