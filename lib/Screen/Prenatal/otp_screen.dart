import 'dart:convert';

import 'package:fitmom/Screen/Prenatal/purchased_package_screen.dart';
import 'package:fitmom/Screen/requests/mothods.dart';
import 'package:fitmom/Screen/requests/progressbar.dart';
import 'package:fitmom/Screen/requests/requestp.dart';
import 'package:fitmom/Widgest/sizedbox.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ndialog/ndialog.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgest/popsup/snackbars.dart';
import '../../utils/constants.dart';
// import 'package:http/http.dart' as http;

// import '../utils/paging.dart';



class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key,required this.mob});
  final String mob;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {


 String otp = "";
  late SharedPreferences prefs;

   @override
  void initState() {
    super.initState();
    getPrefs();
  }

   Future<void> getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId') ?? 0;
    
  }

  

   late int  userId;

  
  Future<void> _verifyNumber() async {
    var url = "/api/Users/verifyMobile";
    otp = pinController.text;
    
    Map<String, dynamic> params = {
      "mobileNo": widget.mob,
      "otp": otp,
    };

    ProgressDialog pds = progresssbar(
        context, "Requesting...", "Please Wait requesting to verify the OTP...", true);

    pds.show();
    var result =
        await requestp(context, url, params, Method.post, "params", pds, 10);
    pds.dismiss();


    if (result.isEmpty) {
      return;
    }
    Map sessionData = jsonDecode(result);

    if (sessionData.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 300), () {
        showSnackBar(context: context, content: sessionData["message"] ?? '');
      });
      // var mobno = widget.mob;

      if (sessionData["message"]
          .toString()
          .toLowerCase()
          .contains("successfully")) {
            // ignore: use_build_context_synchronously
            Navigator.push(context, MaterialPageRoute(builder: (context)=>PurchasedPacakageScreen(userId: userId,)));
        // // var encreptedText = MyEncryptions.encrypt(mobno);
        // var regdata = prefs.getString("regdata") ?? "";
        // Map<String, dynamic> regData =
        //     Map<String, dynamic>.from(jsonDecode(regdata));
        // print("regData $regData");
        // Map sessionData = {
        //   "userId": int.parse("${regData["userId"] ?? 0}"),
        //   "register": true,
        //   "paging": rn == "resetpin"
        //       ? Paging.paging["dashboard"]
        //       : Paging.paging["login"],
        //   "mob": mobno,
        //   // "mobuid": encreptedText,
        // };
        // print("passing data $sessionData");

      }
    } else {
      if (!mounted) return;
      showSnackBar(
          context: context,
          content: sessionData["message"],
          d: {"bgColor": appThemeColor});
    }
  }

TextEditingController pinController = TextEditingController();
  final focusNode = FocusNode();
  String rn = "";

  final defaultPinTheme = PinTheme(
    width: 50,
    height: 50,
    margin: const EdgeInsets.symmetric(horizontal: 8),
    textStyle:  TextStyle(
      fontSize: 18,
      color: Color.fromRGBO(10, 31, 50, 1),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: appThemeColor),
    ),
  );
  

   @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appLightColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               BackButton(
                  onPressed: (){Navigator.pop(context);},
                ),
                height40,
                Center(
                  child: Image.asset("assets/images/img4.png",height: 60,width: 120),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text(
                    "OTP Verification",
                    style: mainHeadingStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    "Complete your verification process.....",
                    style: contentStyle,
                  ),
                ),
                
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        child: Pinput(
                          
                          controller: pinController,
                          focusNode: focusNode,
                          androidSmsAutofillMethod:
                              AndroidSmsAutofillMethod.smsUserConsentApi,
                          listenForMultipleSmsOnAndroid: true,
                          defaultPinTheme: defaultPinTheme,
                          hapticFeedbackType: HapticFeedbackType.heavyImpact,
                          onCompleted: (pin) {
                            debugPrint('onCompleted: $pin');
                            _verifyNumber();
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>PurchasedPacakageScreen()));
                          },
                          onChanged: (value) {
                            debugPrint('onChanged: $value');
                          },
                          cursor: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 9),
                                width: 22,
                                height: 1,
                                color: appBgColor,
                              ),
                            ],
                          ),
                         
                          errorPinTheme: defaultPinTheme.copyBorderWith(
                            border: Border.all(color: Colors.redAccent),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Did not receive an OTP?",
                        style: contentStyle
                      ),
                      TextButton(
                        onPressed: () {
                          
                        },
                        child: Text(
                          "Resend OTP",
                          style: themeTextStyle
                        ),
                      ),
                    ],
                  ),
                  // height8,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Incorrect Number?",
                          style: contentStyle
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            " Change",
                            style: themeTextStyle
                          ),
                        ),
                      ],
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}