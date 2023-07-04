import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:fitmom/Screen/Prenatal/otp_screen.dart';
import 'package:fitmom/Screen/requests/progressbar.dart';
import 'package:fitmom/Widgest/popsup/snackbars.dart';
import 'package:fitmom/Widgest/sizedbox.dart';
import 'package:http/http.dart' as http;
import 'package:fitmom/utils/constants.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ndialog/ndialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgest/customThemeButton.dart';
import '../../notification/sendpost.dart';
// import '../utils/paging.dart';
// import '../utils/session/session_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController numberController =
      TextEditingController(text: '9898989886');
  final formKey = GlobalKey<FormState>();
  // Future<void> _loginUser() async {
  //   var url = "https://fitmomwebapi.jaspertech.xyz/api/Users/UserLogin";
  //   Map<String, dynamic> params = {
  //     "mobileNo": numberController.text,
  //   };
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var regdata = prefs.getString("regdata");
  //   debugPrint("shared Prefs $regdata");
  //   if (!mounted) {
  //     return;
  //   }

  //   var param = jsonEncode(params);
  //   Map<String, String> header = <String, String>{
  //     "Content-Type": "application/json; charset=utf-8",
  //     "Accept": "*/*",
  //     "Access-Control-Allow-Origin": "*",
  //     "Access-Control-Allow-Methods": "POST,GET,PUT,DELETE",
  //   };

  //     var response = await http.post(
  //       Uri.parse(url),
  //       headers: header,
  //       body: param,
  //     );
  //     print(response.statusCode);
  //     debugPrint(response.body);
  //     if (response.statusCode == 200) {
  //       if (!mounted) return;
  //       var jd = jsonDecode(response.body.toString());

  //       saveData(jd["userId"]).then((value) {
  //           Navigator.pushReplacement(
  //           context,
  //   MaterialPageRoute(builder: (context) => OTPScreen(mob:numberController.text),)
  //         );
  //       });

  //     } else {

  //     }
  // }
  // Future saveData(int userId) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString("number", numberController.text);
  //   prefs.setBool("register", true);
  //   prefs.setInt("userId", userId);
  // }
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
                  height40,
                  Center(
                    child: Image.asset(
                      "assets/images/img4.png",
                      height: 90,
                      width: 160,
                    ),
                  ),
                  height40,
                  Text(
                    "Welcome to the Fitmom Club",
                    style: mainHeadingStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      "Enter your Mobile Number to get started",
                      style: contentStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TextFormField(
                      style: textFieldInputStyle,
                      controller: numberController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 10),
                        hintText: "Enter Your Mobile Number",
                        counterText: "",
                        hintStyle: TextStyle(
                            // fontSize: 14,
                            color: appTextColor.withOpacity(0.4),
                            fontWeight: FontWeight.w400),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                                color: appTextColor.withOpacity(0.3),
                                width: 1)),
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
                    padding: const EdgeInsets.only(top: 20.0),
                    child: CustomTheemButton(
                        buttonText: "Get OTP",
                        ontap: () {
                          if (formKey.currentState!.validate()) {
                            _loginUser();

                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen(mob: numberController.text,),),);
                          }
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "By registering you accept our",
                        style: smallContentStyle,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Terms & Conditions/Privacy Policy",
                            style: smallThemeColorStyle,
                          ))
                    ],
                  ),
                 
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

    // pds.show();
    // debugPrint("requesting....");
    // var result =
    //     await requestp(context, url, params, Method.post, "raw", pds, 10);
    // debugPrint("print result:::: $result");
    // debugPrint("requesting.... end");
    // pds.dismiss();

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
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);
    if (response.statusCode == 200) {
      if (!mounted) return;
      var jd = jsonDecode(response.body.toString());
      saveData(jd["userId"]).then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OTPScreen(mob: numberController.text),
          ),
        );
        showSnackBar(context: context, content: "Login Successfully!!");
      });
    } else {
      // if (!mounted) return;
      pds.dismiss();
      // ignore: use_build_context_synchronously
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
