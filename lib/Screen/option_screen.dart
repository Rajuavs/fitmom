import 'package:fitmom/Screen/Prenatal/login_screen.dart';
import 'package:fitmom/Widgest/sizedbox.dart';
import 'package:fitmom/utils/constants.dart';
import 'package:flutter/material.dart';


import 'Postnatal/post_login.dart';


class OptionScreen extends StatefulWidget {
  const OptionScreen({super.key});

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 15),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset("assets/images/img4.png",height: 60,width: 120,),),
              height32,
              Text("Let’s Get Started!",style: headingStyle,),
              Text("Choose what closely represents you....",style: contentStyle,),
              
              Padding(
                padding: const EdgeInsets.only(top:80.0),
                child: Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      // constraints: BoxConstraints(
                      //   maxHeight: 100.h,
                      //   minWidth: 100.h
                      // ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: appThemeColor,width: 1),
                      ),
                      child: Center(child: Text("Prenatal",style: videoHeadingStyle,)),
                    ),
                  ),
                ),
              ),
              height20,
              Divider(),
              height20,
              Center(
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PostLoginScreen()));
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    // constraints: BoxConstraints(
                    //   maxHeight: 100.h,
                    //   minWidth: 100.h
                    // ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: appThemeColor,width: 1),
                    ),
                    child: Center(child: Text("Postnatal",style: videoHeadingStyle,)),
                  ),
                ),
              ),
            
          ]),
        ),
      ),

    );
  }
}