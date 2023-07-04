import 'package:fitmom/Screen/Postnatal/Features/post_live_video_screen.dart';
import 'package:fitmom/Screen/Postnatal/Features/post_previous_video_screen.dart';
import 'package:fitmom/Screen/Postnatal/settings/post_settings_screen.dart';
import 'package:fitmom/Screen/Prenatal/Feature/Packages/packages_screen.dart';

import 'package:fitmom/Screen/video%20screen.dart';
import 'package:fitmom/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;
import '../../Widgest/gretting.dart';
import '../../Widgest/popsup/snackbars.dart';
import '../../Widgest/sizedbox.dart';
import '../../Widgest/videoDescription.dart';
import '../../model/userProfileDetailData.dart';
import 'Features/post_welcome_video_screen.dart';
import 'settings/post_update_profile_page.dart';

class PostDashboardScreen extends StatefulWidget {
  const PostDashboardScreen({super.key,required this.userId});
  final int userId;
  

  @override
  State<PostDashboardScreen> createState() => _PostDashboardScreenState();
}

class _PostDashboardScreenState extends State<PostDashboardScreen> {

 
  // late SharedPreferences prefs;
  // late int  userId;


   @override
  void initState() {
    super.initState();
    _getUserDetail();
    // _sessionVideoList();
    
    // initPrefs();
  }
  
  // Future<void> initPrefs() async {
  //   prefs = await SharedPreferences.getInstance();

  //   setState(() {
  //     userId = prefs.getInt("userId") ?? 0;
  //   });
  // }

 //get user detail
   UserProfileDetailData? userData;
Future<void> _getUserDetail() async {
    var url = "https://fitmomwebapi.jaspertech.xyz/api/Users/GetUserDetails";
    url = "$url?accountId=${widget.userId}";
    var response = await http.get(
      Uri.parse(url),
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
    // ignore: unused_local_variable
    UserProfileDetailData  userPData = userProfileDetailDataFromJson(response.body);
      
           setState(() {
          userData =   userPData;
           });
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, content: "No Data found");
    }
  }

 
//   late CalendarController _calendarController;
//   late var _dataSource;

//   List<GetUsersSessionVideosData> sVideo = [];
// Future<void> _sessionVideoList() async {
//     var  apiUrl =
//         "https://fitmomwebapi.jaspertech.xyz/api/Users/GetUsersSessionVideos";
//         apiUrl = "$apiUrl?accountId=${userId}";
//     // Map<String, dynamic> body = {};

//     final response = await http.get(
//       Uri.parse(apiUrl),
//     );
//     var result = response.body.toString();
//     print("result : $result");
//     // if (response.statusCode == 200) {
//       if ( result.toString().contains("Error::::")) {
//         String msg = result.toString().replaceAll("Error::::", "");
//         // ignore: use_build_context_synchronously
//         ScaffoldMessenger.of(context)
//             .showSnackBar( SnackBar(content: Text(msg)));

//         return;
//       }
//       var _sessionVido = getUsersSessionVideosDataFromJson(result);
//       setState(() {
//         if (_sessionVido.isEmpty) {
//           const Center(
//             child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(appThemeColor),
//             ),
//           );
//         } else {
//           sVideo = _sessionVido;
//         }
//       });
    
//   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(userData?.profilePicPath??""),
                        // backgroundImage: AssetImage("assets/images/img1.png"),
                      ),
                      width12,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(greeting(),style: contentStyle,),
                        Text("${userData?.firstName} ${userData?.lastName}",style: mainHeadingStyle,),
                      ],),
                      
                  ],),
                  // IconButton(onPressed: (){
                  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreen(userId: widget.userId,)));
                  // }, icon: Icon(Icons.settings_outlined,size: 24.h,color: appTextColor.withOpacity(0.4),))
                ],
              ),
              height30,
              Container(
                constraints: BoxConstraints(
                  maxHeight: 100.h,
                ),
                decoration: BoxDecoration(
                  color: appLightColor,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: '12',
                                                        style: TextStyle(
                                                            fontSize: 30.sp,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: appThemeColor),
                                                      ),
                                                      TextSpan(
                                                          text: ' Weeks',
                                                          style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                              color: appTextColor),
                                                          children: const <
                                                              WidgetSpan>[
                                                            WidgetSpan(
                                                                child: Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                5)))
                                                          ]),
                                                      TextSpan(
                                                          text: '4',
                                                          style: TextStyle(
                                                              fontSize: 30.sp,
                                                              fontWeight:
                                                                  FontWeight.w700,
                                                              color: appThemeColor),
                                                          children: const [
                                                            WidgetSpan(
                                                                child: Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                8)))
                                                          ]),
                                                      TextSpan(
                                                          text: 'Days',
                                                          style: TextStyle(
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                              color: appTextColor),
                                                          children: const [
                                                            WidgetSpan(
                                                                child: Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                5)))
                                                          ]),
                                                    ],
                                                  ),
                                                ),
                
                                                Text(
                                                  "Expected DOD : 11th October 2023",
                                                  style: contentStyle),
                                              ],
                                            ),
                                            Image.asset("assets/images/img11.png")
                  ]),
                ),
              ),
             height20,
              Container(
                constraints: BoxConstraints(
                  maxHeight: 550.h
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: appBorderColor),
                  color: appLightColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/icons/icon1.png"),
                          Padding(
                            padding: const EdgeInsets.only(left:12.0),
                            child: Text("Calender & Schedule",style: headingStyle,),
                          ),
                        ],
                      ),
                      Divider(),
                      SizedBox(
                                                                                      height: 300.h,
                                                                                      child: SfCalendar(
                                                                                        view: CalendarView.month,
                                                                                        todayHighlightColor: appThemeColor,
                                                                                        cellBorderColor: appLightColor,
          //                                                                               dataSource: _dataSource,
          //                                                                               controller: _calendarController,
          //                                                                               onViewChanged: (ViewChangedDetails details){
          //                                                                                 List<DateTime> dates = details.visibleDates;
          //                                                                                 String calendarTimeZone = '';
          // List<Object> videos = _dataSource.getVisibleAppointments(
          //     dates[0], calendarTimeZone,
          //     dates[(details.visibleDates.length) - 1]);
          //                                                                               },
                                                                                        
                                                                                    
                                                                                      ),
                                                                                    ),
                                                                                     height12,
             GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoScreen()));
              },
               child: Container(
                constraints: BoxConstraints(
                  maxHeight: 160.h
                ),
                decoration: BoxDecoration(
                  color: appLightColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: appBorderColor)
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset("assets/icons/icon2.png"),
                            Padding(
                              padding: const EdgeInsets.only(left:12.0),
                              child: Text("Upcoming Session",style: headingStyle,),
                            ),
                          ],
                        ),
                        Divider(),
                        height4,
             
                       videoDescription(),
                      ],
                    ),
                  ),
               ),
             ),
                    ],
                  ),
                ),
              ),
             height28,
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              featureContents("My Profile",(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PostUpdateDetailsScreen(userId: widget.userId,),),);
              },),
              featureContents("My Packages",(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PackagesScreen(),),);
              },),
              featureContents("Settings",(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PostSettingsScreen(userId: widget.userId,),),);
              },),
             ],),
             height28,
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              featureContents("Previous\nVideos",(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PosSessionVideoScreen(userId: widget.userId,),),);
              },),
              featureContents("Live\nVideos",(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PostLiveVideoScreen(userId: widget.userId,),),);
              },),
              featureContents("Guideline\nVideos",(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PostWelcomeVideoScreen(userId: widget.userId,),),);
              },),
             ],),
             height28,
             Container(
               constraints: BoxConstraints(
                maxHeight: 250.h
              ),
              decoration: BoxDecoration(
                color: appLightColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: appBorderColor)
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                        children: [
                          Image.asset("assets/icons/icon3.png"),
                          Padding(
                            padding: const EdgeInsets.only(left:12.0),
                            child: Text("Guidelines & Precautions",style: headingStyle,),
                          ),
                        ],
                      ),
                      Divider(),
                ],),
              ),
             ),
               Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0,),
                  child: Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    SvgPicture.asset("assets/images/img3.svg",),
                    Padding(
                      padding: const EdgeInsets.only(top:5.0),
                      child: Text("Made With Love in Namma Bengaluru\nAll rights reserved.",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300, color: Color.fromRGBO(197, 197, 197, 1),),textAlign: TextAlign.center,),
                    ),
                ]),
                  ),
                ),
            ],
          ),
        ),
      ),),
    );
  }

  
  Widget featureContents(String name, VoidCallback ontap) {
    return GestureDetector(
      onTap: ontap,
      child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: appBorderColor),
                      color: appLightColor
                    ),
                  ),
                  height4,
                  Text(name,style: contentStyle,textAlign: TextAlign.center,),
                ],
              ),
    );
  }
}