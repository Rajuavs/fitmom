import 'package:flutter/material.dart';

import '../../../../../Widgest/sizedbox.dart';
import '../../../../../Widgest/videoDescription.dart';
import '../../../../../utils/constants.dart';




class P1T3Tri2Screen extends StatefulWidget {
  const P1T3Tri2Screen({super.key});

  @override
  State<P1T3Tri2Screen> createState() => _P1T3Tri2ScreenState();
}

class _P1T3Tri2ScreenState extends State<P1T3Tri2Screen> {
  @override
  Widget build(BuildContext context) {
    return Column(
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