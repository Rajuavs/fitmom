import 'package:fitmom/Widgest/sizedbox.dart';
import 'package:fitmom/Widgest/videoDescription.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

import '../utils/constants.dart';


class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              height: 230,
              width: double.infinity,
              image: AssetImage("assets/images/img2.png",),fit: BoxFit.cover,),
              
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 28,horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Breathing & Relaxation Part 1",style: headingStyle,),
                        height8,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Instructor : Dr.Apoorva Ravi",style: contentStyle,),
                             videoStatus(),
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    Text("Description",style: videoHeadingStyle,),
                    height8,
                    ReadMoreText("Lorem ipsum dolor sit amet. Id cupiditate debitis quo quia odit id similique reprehenderit et odit expedita eos dignissimos autem. Id dolores illum aut dolore velit et impedit omnis ea itaque numquam vel quas suscipit eos mollitia delectus sed sint saepe. Id voluptas officiis ea Quis voluptas cum iste temporibus cum laboriosam necessitatibus.",style: videoContentStyle,
                    trimLines: 2,
  colorClickableText: appThemeColor,
  trimMode: TrimMode.Line,
  trimCollapsedText: 'Read more',
  trimExpandedText: 'Read less',
  moreStyle: TextStyle(color: appThemeColor,fontSize: 11,fontWeight: FontWeight.w500),),
   Divider(),
              height16,
              Text("Previous Videos",style: videoHeadingStyle,),
              height12,
              videoDescription(),
              height8,
              videoDescription(),
               height8,
              videoDescription(),
               height8,
              videoDescription(),

                  ],
                ),
              ),
             

           
             
          ],
        ),
      ),),
    );
  }
}