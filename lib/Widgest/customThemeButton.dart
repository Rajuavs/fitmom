import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';



// ignore: must_be_immutable
class CustomTheemButton extends StatelessWidget {
   CustomTheemButton({
    Key? key,
   required this.buttonText,
   required this.ontap,
  }) : super(key: key);

 String buttonText;
 VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: appThemeColor
          
        ),
        child: Center(
          child: Text(
            buttonText,
            style: buttonTextStyle
          ),
        ),
      ),
    );
  }
}