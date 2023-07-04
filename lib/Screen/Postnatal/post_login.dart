
import 'dart:convert';

import 'package:fitmom/Screen/Postnatal/post_otp_screen.dart';
import 'package:fitmom/Screen/requests/mothods.dart';
import 'package:fitmom/Screen/requests/progressbar.dart';
import 'package:fitmom/Screen/requests/requestp.dart';
import 'package:fitmom/Widgest/popsup/snackbars.dart';
import 'package:fitmom/Widgest/sizedbox.dart';
import 'package:http/http.dart' as http;
import 'package:fitmom/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ndialog/ndialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgest/customThemeButton.dart';
// import '../utils/paging.dart';
// import '../utils/session/session_manager.dart';



class PostLoginScreen extends StatefulWidget {
  const PostLoginScreen({super.key});

  @override
  State<PostLoginScreen> createState() => _PostLoginScreenState();
}

class _PostLoginScreenState extends State<PostLoginScreen> {
  TextEditingController numberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: appLightColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Center(
                      child: Image.asset("assets/images/img4.png",height: 60.h,width: 120.w,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Text(
                      "Hey! Welcome to the Fitmom Club",
                      style: mainHeadingStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      "Enter your Mobile Number to get started",
                      style: contentStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: TextFormField(
                      style: textFieldInputStyle,
                      controller: numberController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: InputDecoration(
                        hintText: "Enter Your Mobile Number",
                        counterText: "",
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: appTextColor,
                            fontWeight: FontWeight.w400),
                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(6),
                       borderSide: BorderSide(color: appTextColor.withOpacity(0.3),width: 1)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Mobile Number";
                        } else if (!RegExp(
                                r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s/0-9]*$')
                            .hasMatch(value)) {
                          return "Enter Correct Phone Number";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: CustomTheemButton(buttonText: "Get OTP", ontap: (){
                      if(formKey.currentState!.validate()){
                        _loginUser();

                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen(mob: numberController.text,),),);

                      }
                    }),
                  ),
                  height12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text("By registering you accept our",style: smallContentStyle,),
                    TextButton(onPressed: (){}, child: Text("Terms & Conditions/Privacy Policy",style: smallThemeColorStyle,))
                  ],)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  //user login
 Future<void> _loginUser() async {
    var url = "https://fitmomwebapi.jaspertech.xyz/api/Users/UserLogin";
    Map<String, dynamic> params = {
      "mobileNo": numberController.text,
    };
   
    ProgressDialog pds = progresssbar(
        context, "Requesting...", "Please Wait requesting to login...", true);

    pds.show();
    debugPrint("requesting....");
    var result =
        await requestp(context, url, params, Method.post, "raw", pds, 10);
    debugPrint("print result:::: $result");
    debugPrint("requesting.... end");
    pds.dismiss();

    var param = jsonEncode(params);
    Map<String, String> header = <String, String>{
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "*/*",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "POST,GET,PUT,DELETE",
    };


      var response = await http.post(
        Uri.parse(url),
        headers: header,
        body: param,
      );
      print(response.statusCode);
      debugPrint(response.body);
      if (response.statusCode == 200) {
        if (!mounted) return;
        var jd = jsonDecode(response.body.toString());
        saveData(jd["userId"]).then((value) {
            Navigator.pushReplacement(
            context,
    MaterialPageRoute(builder: (context) => PostOTPScreen(mob:numberController.text),),);
        showSnackBar(context: context, content: "Login Successfully!!");
        });
      } else {
        // if (!mounted) return;
        pds.dismiss();
        showSnackBar(context: context, content: "Something went wrong");
      }
  }

  Future saveData(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("number", numberController.text);
    prefs.setBool("register", true);
    prefs.setInt("userId", userId);
  }

   
  }


  


