import 'package:fitmom/Screen/Prenatal/Feature/PV/p1t1/p1t2Tri2_screen.dart';
import 'package:fitmom/Screen/Prenatal/Feature/PV/p1t1/p1t2_screen.dart';
import 'package:flutter/material.dart';

import '../../../../../Widgest/sizedbox.dart';
import '../../../../../utils/constants.dart';


class PreVideosTab extends StatefulWidget {
  const PreVideosTab({super.key});

  @override
  State<PreVideosTab> createState() => _PreVideosTabState();
}

class _PreVideosTabState extends State<PreVideosTab> with TickerProviderStateMixin{

  late TabController _controller;
 

  @override
  void initState() {
    _controller =
        TabController(length: 2, vsync: this,);
    super.initState();
  }

  
@override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Previous Videos",style: mainHeadingStyle,),
              height4,
              Text("View previous exercises videos you would like to rewatch ot catch up with",style: contentStyle,),
              height40,
              TabBar(
                                            indicatorColor: appThemeColor,
                                            indicatorWeight: 3,
                                            indicatorPadding: EdgeInsets.zero,
                                            labelPadding: EdgeInsets.symmetric(horizontal: 30),
                                            padding: EdgeInsets.symmetric(horizontal: 30),
                                            unselectedLabelColor:
                                               appTextColor,
                                            labelColor: appThemeColor,
                                            tabs: [
                                              Tab(
                                          
                                                
                                                text:  "Trimester 1",
                                                
                                              ),
                                              Tab(
                                              
                                                text:  "Trimester 2",
                                                
                                              ),
                                            ],
                                            isScrollable: true,
                                            controller: _controller,
                                          ),
                                          Column(
                                            // shrinkWrap: true,
                                            children: [
                                              Container(
                                                constraints: BoxConstraints(
                                                    maxHeight: 1200),
                                                child: TabBarView(
                                                  controller: _controller,
                                                  children: [
                                                    
                                                    P1T2Tri1Screen(),
                                                    P1TRTri2Screen()
                                                    
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
              
      
      
            ],),
        )),
      ),
    );
  }
}