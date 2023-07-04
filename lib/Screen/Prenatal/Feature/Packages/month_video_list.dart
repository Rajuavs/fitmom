import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../Widgest/sizedbox.dart';
import '../../../../utils/constants.dart';

class MonthViceVideoListScreen extends StatefulWidget {
  const MonthViceVideoListScreen({super.key});

  @override
  State<MonthViceVideoListScreen> createState() => _MonthViceVideoListScreenState();
}

class _MonthViceVideoListScreenState extends State<MonthViceVideoListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                BackButton(
                  onPressed: (){Navigator.pop(context);},
                ),
                width4,
                Text("Your Videos",style: mainHeadingStyle,),
              ],
            ),
              height32,
               SizedBox(
                                                                                      height: 370.h,
                                                                                      // child: TableCalendar(focusedDay: DateTime.now(), firstDay: DateTime.now(), lastDay: DateTime(2030)),
                                                                                      child: SfCalendar(
                                                                                        view: CalendarView.month,
                                                                                        todayHighlightColor: appThemeColor,
                                                                                        cellBorderColor: appLightColor,
          //                                                                               
                                                                                        
                                                                                    
                                                                                      ),
                                                                                    ),
          ],
        ),
      )),
    );
  }
}