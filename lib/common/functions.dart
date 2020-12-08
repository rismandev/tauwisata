import 'package:flutter/material.dart';

final quizScaffold = GlobalKey<ScaffoldState>();

void showCustomAlert(
  BuildContext context, {
  String title,
  String subtitle,
  String textConfirm,
  Function onConfirm,
  Function callback,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title ?? 'Segera hadir!'),
        content: Text(subtitle ?? 'Fitur pemesanan akan segera hadir!'),
        actions: [
          if (onConfirm != null) ...{
            FlatButton(
              child: Text(
                'Batal',
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: Colors.red),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          },
          FlatButton(
            child: Text(
              textConfirm ?? 'Oke',
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Colors.blue),
            ),
            onPressed: () {
              Navigator.pop(context);
              if (callback != null) callback();
              if (onConfirm != null) onConfirm();
            },
          ),
        ],
      );
    },
  );
}

void showCustomSnackBar(
  BuildContext context, {
  String text,
  Color backgroundColor,
  Color textColor,
  Duration duration,
  bool useContext = false,
}) {
  final snackbar = SnackBar(
    duration: duration ?? Duration(seconds: 2),
    backgroundColor: backgroundColor ?? Colors.green[700],
    content: Text(
      text ?? 'text',
      style: Theme.of(context).textTheme.caption.copyWith(
          color: textColor ?? Colors.white, fontWeight: FontWeight.w600),
    ),
  );
  if (useContext) {
    Scaffold.of(context).showSnackBar(snackbar);
  } else {
    quizScaffold.currentState.showSnackBar(snackbar);
  }
}
