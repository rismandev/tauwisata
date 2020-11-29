import 'package:flutter/material.dart';
import 'package:tauwisata/common/styles.dart';

class RedPrimaryButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const RedPrimaryButton({
    Key key,
    this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed ?? () {},
      color: primaryRedColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
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
