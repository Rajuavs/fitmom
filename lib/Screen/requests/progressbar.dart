import 'package:fitmom/Screen/requests/pdialog.dart';
import 'package:fitmom/utils/constants.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        CircularProgressIndicator,
        AlwaysStoppedAnimation,
        Color,
        Colors;
import 'package:ndialog/ndialog.dart' show ProgressDialog;


ProgressDialog progresssbar(BuildContext context, title, message, isCacelable) {
  ProgressDialog pds = Pdialog.pdialog(context, title, message, isCacelable);
  pds.setLoadingWidget(const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(appThemeColor),
    backgroundColor: Colors.black26,
  ));
  return pds;
}
