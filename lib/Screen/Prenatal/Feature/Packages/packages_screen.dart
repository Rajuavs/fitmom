import 'package:fitmom/Screen/Prenatal/Feature/Packages/activate_package_screen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Widgest/sizedbox.dart';
import '../../../../utils/constants.dart';



class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> with TickerProviderStateMixin{
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
              Row(
                children: [
                  BackButton(
                  onPressed: (){Navigator.pop(context);},
                ),
                  Text("Packages",style: mainHeadingStyle,),
                ],
              ),
              height32,
              Text("Active Packages",style: greyHeadingStyle,),
               height20,
               GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ActivatePackageScreen()));
                },
                 child: Container(
                  constraints: BoxConstraints(
                    maxHeight: 180,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(image: AssetImage("assets/images/img6.png"),fit: BoxFit.cover),
                  ),
                  child: Stack(children: [
                    
                    Positioned(
                      top: 30,
                      left: 135,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pre-Natal",style: GoogleFonts.poppins(
                 fontSize: 12,
                 color: appLightColor,
                 fontWeight: FontWeight.w400
               )),
               height4,
               Text("Trimester 2 Package",style: GoogleFonts.poppins(
                 fontSize: 17,
                 color: appLightColor,
                 fontWeight: FontWeight.w500
               )),
               height4,
               Text("+ 24 Weeks of Complete Support",style: GoogleFonts.poppins(
                 fontSize: 11,
                 color: appLightColor,
                 fontWeight: FontWeight.w500
               )),
               height4,
               Text("+ 12 Live Session",style: GoogleFonts.poppins(
                 fontSize: 11,
                 color: appLightColor,
                 fontWeight: FontWeight.w500
               )),
               height12,
               Text("-150 Days Remaining",style: GoogleFonts.poppins(
               fontSize: 14,
               color: Colors.blue.shade900,
               fontWeight: FontWeight.w500
               ))
                        ],
                      ),)
                  ],),
                 ),
               ),
             height32,
              Text("Recommended Packages",style: greyHeadingStyle,),
              height20,  
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                packageCategory("assets/images/img7.png","Pre-Natal","5 Day Workshop\non Baby Prep.","₹480"),
                packageCategory("assets/images/img8.png","Post-Natal","Heal & Recover\nLevel 1","₹1215"),
                 
              ],),
height32,
              Text("All Packages",style: greyHeadingStyle,),
              height20, 
              TabBar(
                 indicatorColor: appThemeColor,
                 
                                            indicatorWeight: 3,
                                            labelStyle: GoogleFonts.poppins(fontSize: 16,),
                                            indicatorPadding: EdgeInsets.zero,
                                            // indicatorSize: TabBarIndicatorSize.tab,
                                            labelPadding: EdgeInsets.symmetric(horizontal: 30),
                                            padding: EdgeInsets.symmetric(horizontal: 30),
                                            unselectedLabelColor:
                                               appTextColor,
                                            labelColor: appThemeColor,
                                            tabs: [
                                              Tab(
                                          
                                                
                                                text:  "Prenatal",
                                                
                                              ),
                                              Tab(
                                              
                                                text:  "Postnatal",
                                                
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
                                                    maxHeight: 250),
                                                child: TabBarView(
                                                  controller: _controller,
                                                  children: [
                                                    Container(
                                                      constraints: BoxConstraints(maxHeight: 200),
                                                      child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                packageCategory("assets/images/img7.png","Pre-Natal","5 Day Workshop\non Baby Prep.","₹480"),
                packageCategory("assets/images/img8.png","Post-Natal","Heal & Recover\nLevel 1","₹1215"),
                 
              ],),
                                                    ),
                                                     Container(
                                                      constraints: BoxConstraints(maxHeight: 200),
                                                      child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                packageCategory("assets/images/img9.png","Post-Natal","Restrengthen & Revive\nLevel 2.","₹1215"),
                packageCategory("assets/images/img10.png","Post-Natal","Transform & Thrive\nLevel 3","₹1215"),
                 
              ],),
                                                    ),
                                                   
                                                    
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
            ]),
        )),
      ),
    );
  }

  Widget packageCategory(String img,String term,String desc, String price) {
    return Container(
                constraints: BoxConstraints(
                maxWidth: 160,
                maxHeight: 180
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(image: AssetImage(img),fit: BoxFit.cover),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 12,
                    left: 8,
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(term,style: GoogleFonts.poppins(
fontSize: 12,
color: appLightColor,
fontWeight: FontWeight.w400
)),
Text(desc,style: GoogleFonts.poppins(
fontSize: 17,
color: appLightColor,
fontWeight: FontWeight.w500
)),

Text(price,style: GoogleFonts.poppins(
fontSize: 17,
color: appLightColor,
fontWeight: FontWeight.w500
)),
                    ],),),
                  
                ],
              ),
              );
  }
}