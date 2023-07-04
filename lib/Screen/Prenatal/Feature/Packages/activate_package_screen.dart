// import 'package:expandable/expandable.dart';
// import 'package:fitmom/Widgest/videoDescription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:month_selector/month_selector.dart';

import '../../../../Widgest/sizedbox.dart';
import '../../../../utils/constants.dart';



class ActivatePackageScreen extends StatefulWidget {
  const ActivatePackageScreen({super.key});

  @override
  State<ActivatePackageScreen> createState() => _ActivatePackageScreenState();
}

class _ActivatePackageScreenState extends State<ActivatePackageScreen> with TickerProviderStateMixin{
  late TabController _monthController;
  DateTime? month;
  String monthDisplay(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return "$month/$year";
  }
 

  @override
  void initState() {
    _monthController =
        TabController(length: 6, vsync: this,);
    super.initState();
  }
var date = DateTime.now();
  
@override
  void dispose() {
    _monthController.dispose();
    super.dispose();
  }
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BackButton(
                  onPressed: (){Navigator.pop(context);},
                ),
                  Text("Package Details",style: mainHeadingStyle,),
                ],
              ),
              height32,
              Container(
                  constraints: BoxConstraints(
                    maxHeight: 180,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(image: AssetImage("assets/images/img6.png"),fit: BoxFit.cover),
                  ),
                  child: Stack(children: [
                    
                    Positioned(
                      top: 30.h,
                      left: 135.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pre-Natal",style: GoogleFonts.poppins(
                 fontSize: 12.sp,
                 color: appLightColor,
                 fontWeight: FontWeight.w400
               )),
               height4,
               Text("Trimester 2 Package",style: GoogleFonts.poppins(
                 fontSize: 17.sp,
                 color: appLightColor,
                 fontWeight: FontWeight.w500
               )),
               height4,
               Text("+ 24 Weeks of Complete Support",style: GoogleFonts.poppins(
                 fontSize: 11.sp,
                 color: appLightColor,
                 fontWeight: FontWeight.w500
               )),
               height4,
               Text("+ 12 Live Session",style: GoogleFonts.poppins(
                 fontSize: 11.sp,
                 color: appLightColor,
                 fontWeight: FontWeight.w500
               )),
               height12,
               Text("-150 Days Remaining",style: GoogleFonts.poppins(
               fontSize: 14.sp,
               color: Colors.blue.shade900,
               fontWeight: FontWeight.w500
               ))
                        ],
                      ),)
                  ],),
                 ),
                 height16,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    monthContents("JAN"),
                    monthContents("FEB"),
                    monthContents("MAR"),
                    monthContents("APR"),
                    monthContents("MAY"),
                    monthContents("JUN"),
                    monthContents("JUL"),
                    monthContents("AUG"),
                    monthContents("SEP"),
                    monthContents("OCT"),
                    monthContents("NOV"),
                    monthContents("DEC"),
                  ],),
                ),
                height20,
                Text("Week 12",style: headingStyle,),
                height16,
              
            ]),
        )),
      ),
    );
  }

  Widget monthContents(String mName) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(constraints: BoxConstraints(
                    maxHeight: 60.h,
                    maxWidth: 60.w,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: activePackageColor,width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(mName,style: activePackageColorStyle,),
                  ),),
    );
  }


}