import 'package:flutter/material.dart' show debugPrint;
import 'package:shared_preferences/shared_preferences.dart';

class SessionManageR {
  Future<bool> logout() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // return prefs.clear();

    // instance.prefs.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.clear();
      return true;
    } catch (e) {
      print("prefs Error $e");
      return false;
    }
  }


  static Future<dynamic> setSession(Map res) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      if (res.containsKey("accId")) {
        prefs.setInt("accId", res["accId"]);
        prefs.setBool("register", res["register"] ?? false);
        prefs.setString("paging", res["paging"]);
        prefs.setString("mob", res["mob"] ?? "");
        // prefs.setString("mobuid", res["mobuid"] ?? "");
        // prefs.setString("mtype", ""); //prenatel,postnatel
        prefs.setString("imgUrl", res["imgUrl"] ?? '');
        prefs.setString("name", res["fullName"] ?? '');

  

        // prefs.remove("regdata");
        if (res.containsKey("profileStatus")) {
          int prosts = res["profileStatus"] ?? 0;
          print("session manager profileStatus $prosts");
          
          if (prosts == 1) {
          } else if (prosts > 2 && prosts <= 6) {
            
            if (prosts <= 3) {
              prefs.setBool("amp", true);
            } else if (prosts <= 4) {
              prefs.setBool("amp", true);
              prefs.setBool("mlp", true);
            } else if (prosts <= 5) {
              prefs.setBool("amp", true);
              prefs.setBool("mlp", true);
              prefs.setBool("mdlp", true);
            } else if (prosts <= 6) {
              prefs.setBool("amp", true);
              prefs.setBool("mlp", true);
              prefs.setBool("mdlp", true);
              prefs.setBool("mpp", true);
              prefs.setString("paging", res["paging"]);
            } else if (prosts <= 6) {
              prefs.setBool("amp", true);
              prefs.setBool("mlp", true);
              prefs.setBool("mdlp", true);
              prefs.setBool("mpp", true);
              prefs.setString("paging", res["paging"]);
            }
          }
        }
        return true;
      } else {
        debugPrint("getting here session manager");
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      // debugPrint(s);
      return false;
    }
  }

  static Future<dynamic> setSessionReg(String data) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("regdata", data);
      return true;
    } catch (_) {}
    return false;
  }

  static bool setSessiontoken(String fbtoken, SharedPreferences prefs) {
    try {
      prefs.setString("fbToken", fbtoken);
      return true;
    } catch (_) {
      return false;
    }
  }
}
