import 'package:flutter/material.dart';

import '../../../../../Widgest/sizedbox.dart';
import '../../../../../Widgest/videoDescription.dart';
import '../../../../../utils/constants.dart';



class P1TRTri2Screen extends StatefulWidget {
  const P1TRTri2Screen({super.key});

  @override
  State<P1TRTri2Screen> createState() => _P1TRTri2ScreenState();
}

class _P1TRTri2ScreenState extends State<P1TRTri2Screen> {
  @override
  Widget build(BuildContext context) {
    return  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              
              height40,
              Text("Week 24",style: headingStyle,),
              Divider(),
              videoDescription(),
              Divider(),
              videoDescription(),
              height20,
              Text("Week 23",style: headingStyle,),
              Divider(),
              videoDescription(),
              Divider(),
              videoDescription(),
              Divider(),
              videoDescription(),
              height20,
              Text("Week 22",style: headingStyle,),
              Divider(),
              videoDescription(),
              Divider(),
              


            ],);
  }
}