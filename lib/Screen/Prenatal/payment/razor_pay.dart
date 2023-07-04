import 'package:fitmom/Screen/Prenatal/your_details_screen.dart';
import 'package:fitmom/Widgest/customThemeButton.dart';
import 'package:fitmom/Widgest/sizedbox.dart';
import 'package:fitmom/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RazorPayScreen extends StatefulWidget {
  const RazorPayScreen({super.key});

  @override
  State<RazorPayScreen> createState() => _RazorPayScreenState();
}

class _RazorPayScreenState extends State<RazorPayScreen> {

  late SharedPreferences prefs;
  late int  userId;


   @override
  void initState() {
    super.initState();
    initPrefs();
  }
  
  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      userId = prefs.getInt("userId") ?? 0;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("RAZOR PAY",style: mainHeadingStyle,),
            height16,
            CustomTheemButton(buttonText: "Next", ontap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> YourDetailsScreen(userId: userId,),),);
            })
          ],
        ),
      ),
    );
  }
}



