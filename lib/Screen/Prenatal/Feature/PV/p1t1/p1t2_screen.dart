import 'package:flutter/material.dart';

import '../../../../../Widgest/sizedbox.dart';
import '../../../../../Widgest/videoDescription.dart';
import '../../../../../utils/constants.dart';




class P1T2Tri1Screen extends StatefulWidget {
  const P1T2Tri1Screen({super.key});

  @override
  State<P1T2Tri1Screen> createState() => _P1T2Tri1ScreenState();
}

class _P1T2Tri1ScreenState extends State<P1T2Tri1Screen> {
  @override
  Widget build(BuildContext context) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              
              height40,
              Text("Week 12",style: headingStyle,),
              Divider(),
              videoDescription(),
              Divider(),
              videoDescription(),
              height20,
              Text("Week 11",style: headingStyle,),
              Divider(),
              videoDescription(),
              Divider(),
              videoDescription(),
              Divider(),
              videoDescription(),
              height20,
              Text("Week 10",style: headingStyle,),
              Divider(),
              videoDescription(),
              Divider(),
              


            ],);
  }
}