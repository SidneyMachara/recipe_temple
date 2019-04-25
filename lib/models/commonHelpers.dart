import 'package:flutter/material.dart';

class CommonHelpers{

  CommonHelpers();

  void showToast(BuildContext context, String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content:  Text(message),
        duration:  Duration(seconds: 1),
//        action: SnackBarAction(
//            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

}
