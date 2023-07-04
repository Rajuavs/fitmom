import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        CircularProgressIndicator,
        Color,
        FocusManager,
        MediaQuery,
        Orientation,
        Size;

class SmallFun {
  static hideKeyBoard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static bool getOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static Size getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }
}

setFSfsu(bool isPortrait, double sp) {
  return isPortrait ? sp : (sp / 1.8);
}

setHfsu(bool isPortrait, double h) {
  return isPortrait ? h : (h * 1.8);
}

loading({Color? crl}) {
  return Center(
    child: CircularProgressIndicator(
      strokeWidth: 2,
      color: crl,
    ),
  );
}
