import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constants.dart';

Widget themeMaterialButton(VoidCallback ontap, String buttonText) {
    return SizedBox(
      width: 160.w,
      child: MaterialButton(
                        color: appThemeColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        onPressed: ontap,
                      child: Center(child: Text(buttonText,style: GoogleFonts.poppins(
  fontSize: 14.sp,
  color: appLightColor,
  fontWeight: FontWeight.w300
),),),),
    );
  }

  Widget themeOutlineButton(VoidCallback ontap, String buttonText) {
    return SizedBox(
      width: 160.w,
      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: appThemeColor,width: 1)
                        ),
                        onPressed: ontap, child: Text(buttonText,style: themeTextStyle,)),
    );
  }