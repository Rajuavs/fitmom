import 'dart:convert' show jsonDecode;
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart' show ProgressDialog;

import '../../Widgest/popsup/show_dialog.dart';
import 'http_request.dart';
import 'mothods.dart';

HttpServerHttp httpServiceHttp = HttpServerHttp();
Future<dynamic> requestp(BuildContext context, String url, var par,
    Method method, String type, ProgressDialog pds, int? sec) async {
  var result = await httpServiceHttp
      .request(
          baseurl: "",
          url: url,
          method: method,
          params: par,
          timeout: sec ?? 10,
          type: type,
          auth: true)
      .onError((error, stackTrace) {
    try {
      pds.dismiss();
    } catch (_) {}
    try {
      Map erJ = jsonDecode(error.toString());
      String errormsg = "$error";
      if (erJ.containsKey("message")) {
        errormsg = erJ["message"].toString();
      } else if (erJ.containsKey("title")) {
        errormsg = erJ["title"].toString();
      }
      ShowDialogs.showDialogs(
          context: context,
          title: "Response",
          img: "",
          message: errormsg,
          onPressed: (v) {
            debugPrint("clicked $v");
          },
          buttons: [],
          isCancelable: true);
    } catch (e) {
      ShowDialogs.showDialogs(
          context: context,
          title: "Error",
          img: "",
          message: "$error",
          onPressed: (v) {
            debugPrint("clicked $v");
          },
          buttons: [],
          isCancelable: true);
    }
    return "";
  });

  return result;
}

Future<dynamic> requestpNoPopUp(
    String url, var par, Method method, String type) async {
  var result = await httpServiceHttp
      .request(
          baseurl: "",
          url: url,
          method: method,
          params: par,
          timeout: 10,
          type: type,
          auth: true)
      .onError((error, stackTrace) {
    return "";
  });
  return result;
}

Future<dynamic> requestpNoPopUpWE(
    {required String url,
    var par,
    required Method method,
    required String type,
    int? sec}) async {
  sec = sec ?? 10;
  var result = await httpServiceHttp
      .request(
          baseurl: "",
          url: url,
          method: method,
          params: par,
          timeout: sec,
          type: type,
          auth: true)
      .onError((error, stackTrace) {
    return "Error::::$error";
  });

  return result;
}

Future<dynamic> requestp2(BuildContext context, String url, var par,
    Method method, String type, int? sec) async {
  var result = await httpServiceHttp
      .request(
          baseurl: "",
          url: url,
          method: method,
          params: par,
          timeout: sec ?? 10,
          type: type,
          auth: true)
      .onError((error, stackTrace) {
    try {
      Map erJ = jsonDecode(error.toString());
      String errormsg = "$error";
      if (erJ.containsKey("message")) {
        errormsg = erJ["message"].toString();
      } else if (erJ.containsKey("title")) {
        errormsg = erJ["title"].toString();
      }
      ShowDialogs.showDialogs(
          context: context,
          title: "Error",
          img: "",
          message: errormsg,
          onPressed: (v) {
            debugPrint("clicked $v");
          },
          buttons: [],
          isCancelable: true);
    } catch (e) {
      ShowDialogs.showDialogs(
          context: context,
          title: "Error",
          img: "",
          message: "$error",
          onPressed: (v) {
            debugPrint("clicked $v");
          },
          buttons: [],
          isCancelable: true);
    }
    return "";
  });
  return result;
}
