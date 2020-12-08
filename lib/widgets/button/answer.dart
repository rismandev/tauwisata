import 'package:flutter/material.dart';
import 'package:tauwisata/common/enum.dart';
import 'package:tauwisata/common/styles.dart';

class AnswerButton extends StatelessWidget {
  final String text;
  final AnswerQuestion isCorrect;
  final Function onPressed;
  final bool disabled;

  const AnswerButton({
    Key key,
    this.text,
    this.isCorrect = AnswerQuestion.DEFAULT,
    this.onPressed,
    this.disabled = false,
  }) : super(key: key);

  Color get backgroundColor {
    if (this.isCorrect == AnswerQuestion.CORRECT) {
      return primaryQuizCorrectColor;
    } else if (this.isCorrect == AnswerQuestion.WRONG) {
      return primaryRedColor;
    } else {
      return Colors.white;
    }
  }

  Color get textColor {
    if (this.isCorrect == AnswerQuestion.CORRECT ||
        this.isCorrect == AnswerQuestion.WRONG) {
      return Colors.white;
    } else {
      return primaryDarkColor;
    }
  }

  String get iconPath {
    if (this.isCorrect == AnswerQuestion.CORRECT) {
      return 'assets/icons/icon_checklist.png';
    } else if (this.isCorrect == AnswerQuestion.WRONG) {
      return 'assets/icons/icon_close.png';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: !disabled ? this.onPressed : null,
      color: backgroundColor,
      focusColor: backgroundColor,
      disabledColor: backgroundColor,
      colorBrightness: Brightness.light,
      hoverColor: backgroundColor,
      splashColor: secondaryBrownColor,
      highlightElevation: 0,
      highlightColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Colors.white,
          width: 2,
          style: isCorrect != AnswerQuestion.DEFAULT
              ? BorderStyle.solid
              : BorderStyle.none,
        ),
      ),
      elevation: 0,
      padding: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(15, 8, 15, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset.zero,
              blurRadius: 10,
              spreadRadius: 1,
              color: primaryShadowColor.withOpacity(0.25),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              this.text ?? 'Answer Text',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: textColor, fontWeight: FontWeight.w600),
            ),
            this.iconPath != null
                ? Image.asset(
                    iconPath,
                    width: 30,
                    height: 30,
                  )
                : Container(
                    width: 30,
                    height: 30,
                  ),
          ],
        ),
      ),
    );
  }
}
