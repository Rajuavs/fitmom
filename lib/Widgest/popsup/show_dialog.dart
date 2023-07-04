import 'package:fitmom/utils/constants.dart';
import 'package:flutter/material.dart';

import '../sizedbox.dart';

class ShowDialogs {
  static showDialogs(
      {required BuildContext context,
      required String title,
      required String img,
      required String message,
      // required String buttonText,
      required Function onPressed,
      required List buttons,
      required bool isCancelable}) {
    showDialog(
        context: context,
        barrierDismissible: isCancelable,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return isCancelable;
            },
            child: AlertDialog(
              title: Text(title),
              // content: Text(message),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                (img.isEmpty)
                    ? Container()
                    : SizedBox(
                        height: 60,
                        child: Image.asset(
                          img, //'assets/award.gif',
                          height: 100,
                          width: 100,
                        ),
                      ),
                if (message.isNotEmpty)
                  Text(
                    message,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: appDarkColor),
                  ),
                // const SizedBox(
                //   height: 15,
                // ),
                // Text(message,
                //     style: const TextStyle(
                //         fontSize: 12,
                //         color: Color.fromARGB(255, 154, 154, 154),
                //         fontWeight: FontWeight.w500,
                //         fontStyle: FontStyle.normal)),
                if (buttons.isEmpty) height20
              ]),
              actions: buttons.isEmpty
                  ? null
                  : buttons
                      .map(
                        (e) => TextButton(
                          child: Text(e),
                          onPressed: () {
                            onPressed(e);
                          },
                        ),
                      )
                      .toList(),
              // TextButton(
              //   child: Text(buttons[1]),
              //   onPressed: () {
              //     onPressed(buttons[1]);
              //   },
              // )
              // ],
            ),
          );
        });
  }

  static showdialogsuc({
    required String t,
    required String message,
    required String img,
    required String bstring,
    required bool isDismissable,
    required BuildContext context,
    required List buttons,
    required Function(dynamic) onPressed,
  }) {
    showDialog(
        context: context,
        barrierDismissible: isDismissable,
        builder: (context) {
          return AlertDialog(
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              if (img.isNotEmpty)
                SizedBox(
                  height: 80,
                  child: Image.asset(
                    img, //'assets/award.gif',
                    height: 100,
                    width: 100,
                  ),
                ),
              if (t.isNotEmpty)
                Text(
                  t,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: appDarkColor),
                ),
              if (message.isNotEmpty) height16,
              if (message.isNotEmpty)
                Text(message,
                    style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 154, 154, 154),
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal)),
              if (bstring.isNotEmpty) height20,
              if (bstring.isNotEmpty)
                Text(
                  bstring,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: appDarkColor),
                ),
            ]),
            actions: buttons.isEmpty
                ? null
                : buttons
                    .map(
                      (b) => TextButton(
                        child: Text(b),
                        onPressed: () {
                          onPressed(b);
                        },
                      ),
                    )
                    .toList(),
          );
        });
  }
}
