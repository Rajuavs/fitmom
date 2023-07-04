import 'dart:async';
// import 'package:fitmom/Screen/dashboard_screen.dart';
// import 'package:fitmom/Screen/option_screen.dart';
// import 'package:fitmom/utils/constants.dart';
import 'package:fitmom/Screen/Prenatal/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Prenatal/dashboard_screen.dart';
import 'Prenatal/your_details_screen.dart';
import 'option_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences prefs;
  bool isLoggedIn = false;
  late int userId;
  bool isProfileCompleted = false;
  @override
  void initState() {
    getPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: appLightColor,
      // body: Text("bodyyyyyyyy")
      body: Center(child: Image.asset("assets/images/img4.png")),
    );
  }

  Future<void> getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId') ?? 0;

    // var page = userId == 0
    //   ? YourDetailsScreen(userId: userId)
    //   : (isProfileCompleted == true
    //       ? DashboardScreen(prefs: prefs)
    //       : const LoginScreen());
    dynamic page = YourDetailsScreen(userId: userId);
    if (prefs.containsKey('userId')) {
      page = DashboardScreen(prefs: prefs);
    } else {
      page = const LoginScreen();
    }

    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
    );
  }
}
