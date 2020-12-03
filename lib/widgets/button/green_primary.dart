import 'package:flutter/material.dart';
import 'package:tauwisata/common/styles.dart';

class GreenPrimaryButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final BorderRadius borderRadius;

  const GreenPrimaryButton({
    Key key,
    this.text,
    this.onPressed,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed ?? () {},
      color: primaryGreenColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(10),
      ),
      padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
      splashColor: primaryBrownColor,
      child: Text(
        text ?? 'Button',
        style: Theme.of(context)
            .textTheme
            .button
            .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }
}
