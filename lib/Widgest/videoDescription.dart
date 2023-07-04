import 'package:fitmom/Widgest/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';




Widget videoDescription() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: 75.h,
                            maxWidth: 100.w,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            image: DecorationImage(image: AssetImage("assets/images/img2.png",),fit: BoxFit.cover)
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              videoStatus(),
                              height4,
                              Text("Breathing & Relaxation Part 1",
                                                          style: videoHeadingStyle,maxLines: 2,overflow: TextOverflow.ellipsis,),
                            
                              Text("Instructor: Dr.Apoorva Ravi",style: contentStyle,),
                              height2,  
                              Text("14/10/2023",style: videoContentStyle,),
                            ],
                          ),
                        )
                       ],),
    );
  }

Widget videoStatus() {
  return Container(
                            height: 20,
                            width: 75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.orange.shade100,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Image.asset("assets/icons/icon4.png"),
                              Padding(
                                padding: const EdgeInsets.only(left:4.0),
                                child: Text("RECORDED",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w600,color: Colors.orange),),
                              )
                            ]),
                          );
}

Widget liveVideoStatus() {
  return Container(
                            height: 20,
                            width: 75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.red.shade100,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Image.asset("assets/icons/icon7.png",),
                              Padding(
                                padding: const EdgeInsets.only(left:4.0),
                                child: Text("LIVE",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w600,color: Colors.red),),
                              )
                            ]),
                          );
}
