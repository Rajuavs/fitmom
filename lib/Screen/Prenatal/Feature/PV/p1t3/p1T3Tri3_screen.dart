import 'package:flutter/material.dart';

import '../../../../../Widgest/sizedbox.dart';
import '../../../../../Widgest/videoDescription.dart';
import '../../../../../utils/constants.dart';




class P1T3Tri3Screen extends StatefulWidget {
  const P1T3Tri3Screen({super.key});

  @override
  State<P1T3Tri3Screen> createState() => _P1T3Tri3ScreenState();
}

class _P1T3Tri3ScreenState extends State<P1T3Tri3Screen> {
  @override
  Widget build(BuildContext context) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              
              height40,
              Text("Week 40",style: headingStyle,),
              Divider(),
              videoDescription(),
              Divider(),
              videoDescription(),
              height20,
              Text("Week 39",style: headingStyle,),
              Divider(),
              videoDescription(),
              Divider(),
              videoDescription(),
              Divider(),
              videoDescription(),
              height20,
              Text("Week 38",style: headingStyle,),
              Divider(),
              videoDescription(),
              Divider(),
              


            ],);
  }
}