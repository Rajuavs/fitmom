import 'dart:convert';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fitmom/Screen/Prenatal/Feature/PV/sessio_viseo_screen.dart';
import 'package:fitmom/Screen/Prenatal/Feature/Packages/packages_screen.dart';
import 'package:fitmom/Screen/Prenatal/Feature/live_video_screen.dart';
import 'package:fitmom/Screen/Prenatal/Feature/welcome_video_screen.dart';
import 'package:fitmom/Screen/Prenatal/Settings/settings_screen.dart';
import 'package:fitmom/Screen/requests/mothods.dart';
import 'package:fitmom/Screen/requests/requestp.dart';
import 'package:fitmom/Screen/video%20screen.dart';
import 'package:fitmom/notification/show_notification.dart';
import 'package:fitmom/utils/constants.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;
import '../../Widgest/customThemeButton.dart';
import '../../Widgest/gretting.dart';
import '../../Widgest/popsup/snackbars.dart';
import '../../Widgest/sizedbox.dart';
import '../../Widgest/videoDescription.dart';
import '../../model/userProfileDetailData.dart';
import '../../notification/sendpost.dart';
import 'Settings/SFeatures/update_profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.prefs});
  // final int userId;
  final SharedPreferences prefs;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // late SharedPreferences prefs;
  // late int  userId;
  late SharedPreferences prefs;
  int userId = 0;
  String fbToken = '';

  @override
  void initState() {
    prefs = widget.prefs;
    super.initState();
    initPrefs();

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

  Future<void> initPrefs() async {
    if (prefs.containsKey('userId')) {
      userId = prefs.getInt('userId') ?? 0;
    }
    if (userId == 0) {
      prefs = await SharedPreferences.getInstance();
      userId = prefs.getInt('userId') ?? 0;
    }
    fbToken = prefs.getString('fbToken') ?? '';
    _getUserDetail();

    initFCM();
  }

  Future<void> _getUserDetail() async {
    var url = "https://fitmomwebapi.jaspertech.xyz/api/Users/GetUserDetails";
    url = "$url?accountId=$userId";
    var response = await http.get(
      Uri.parse(url),
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      // ignore: unused_local_variable
      UserProfileDetailData userPData =
          userProfileDetailDataFromJson(response.body);
      setState(() {
        userData = userPData;
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
      body: userId==0? CircularProgressIndicator(): SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                          backgroundImage:
                              NetworkImage(userData?.profilePicPath ?? ""),
                          // backgroundImage: AssetImage("assets/images/img1.png"),
                        ),
                        width12,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              greeting(),
                              style: contentStyle,
                            ),
                            Text(
                              "${userData?.firstName} ${userData?.lastName}",
                              style: mainHeadingStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    // IconButton(onPressed: (){
                    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreen(userId: userId,)));
                    // }, icon: Icon(Icons.settings_outlined,size: 24,color: appTextColor.withOpacity(0.4),))
                  ],
                ),
                height30,
                Container(
                  constraints: const BoxConstraints(
                    maxHeight: 100,
                  ),
                  decoration: BoxDecoration(
                      color: appLightColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(

                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: const TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '12',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w700,
                                          color: appThemeColor),
                                    ),
                                    TextSpan(
                                        text: ' Weeks',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: appTextColor),
                                        children: <WidgetSpan>[
                                          WidgetSpan(
                                              child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 5)))
                                        ]),
                                    TextSpan(
                                        text: '4',
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w700,
                                            color: appThemeColor),
                                        children: [
                                          WidgetSpan(
                                              child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 8)))
                                        ]),
                                    TextSpan(
                                        text: 'Days',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: appTextColor),
                                        children: [
                                          WidgetSpan(
                                              child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 5)))
                                        ]),
                                  ],
                                ),
                              ),
                              Text("Expected DOD : 11th October 2023",
                                  style: contentStyle),
                            ],
                          ),
                          Image.asset("assets/images/img11.png")
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: CustomTheemButton(
                      buttonText: "send notification",
                      ontap: () {

                        // updateFbToken();
                        _sendNotificaiton();
                        // _showNotification();
                      }),
                ),
                height20,
                Container(
                  constraints: const BoxConstraints(maxHeight: 550),
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
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(
                                "Calender & Schedule",
                                style: headingStyle,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        SizedBox(
                          height: 300,
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const VideoScreen()));
                          },
                          child: Container(
                            // constraints: BoxConstraints(maxHeight: 160),
                            decoration: BoxDecoration(
                                color: appLightColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: appBorderColor)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset("assets/icons/icon2.png"),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: Text(
                                          "Upcoming Session",
                                          style: headingStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
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
                    featureContents(
                      "My Profile",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateDetailsScreen(
                              userId: userId,
                            ),
                          ),
                        );
                      },
                    ),
                    featureContents(
                      "My Packages",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PackagesScreen(),
                          ),
                        );
                      },
                    ),
                    featureContents(
                      "Settings",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsScreen(
                              userId: userId,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                height28,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    featureContents(
                      "Previous\nVideos",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SessionVideoScreen(
                              userId: userId,
                            ),
                          ),
                        );
                      },
                    ),
                    featureContents(
                      "Live\nVideos",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GuestVideoScreen(
                              userId: userId,
                            ),
                          ),
                        );
                      },
                    ),
                    featureContents(
                      "Guideline\nVideos",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WelcomeVideoScreen(
                              userId: userId,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                height28,
                Container(
                  constraints: const BoxConstraints(maxHeight: 250),
                  decoration: BoxDecoration(
                      color: appLightColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: appBorderColor)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset("assets/icons/icon3.png"),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(
                                "Guidelines & Precautions",
                                style: headingStyle,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 50.0,
                  ),
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/img3.svg",
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              "Made With Love in Namma Bengaluru\nAll rights reserved.",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                color: Color.fromRGBO(197, 197, 197, 1),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: appBorderColor),
                color: appLightColor),
          ),
          height4,
          Text(
            name,
            style: contentStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showNotification() async {
    // Create a notification content
    var content = NotificationContent(
      id: 1,
      channelKey: 'basic_channel',
      title: 'Hello',
      body: 'This is an awesome notification!',
      notificationLayout: NotificationLayout.Default,
    );

    // Schedule the notification to be displayed
    // await AwesomeNotifications().createNotification(content);
    await AwesomeNotifications().createNotification(content: content);
  }

  Future<void> _sendNotificaiton() async {
    Map<String, dynamic> callJdata = <String, dynamic>{
      'notification': <String, dynamic>{
        'body': "body message testing....",
        'title': "title message seding2",
        'android_channel_id': 'amica_user',
        // 'id'
      },
      'priority': 'high',
      'data': <String, dynamic>{
        'type': 'messaging',
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'id': '2',
        'status': 'done',
        'subText': "sub text",
        'receiverId': "Receiver Id",
        'callerId': "caller id",
      },
      "to": "$fbToken",
    };

// $.ajax({
//     url: 'https://fcm.googleapis.com/fcm/send',
//     headers: {
//     'Content-Type': 'application/json',
//       'Authorization': 'key=AAAAS2bsr_M:APA91bEspYKBQCDyp1fF7FbpAwvGiVndNc3bOUDoRPpVX0a1xE7tm5zLO2GPsWM7ITlPmm1PM8lkUe4g4ijqDh4wwabaiU6FYStNRWCLQ3N8xJVlxLEB_6aEBw_Z3d6Rpz3WNH9m8wG0',
   
//     },
//     method: 'POST',
//     dataType: 'json',
//     data: {"notification":{"body":"body message testing","title":"title message test","android_channel_id":"amica_user"},"priority":"high","data":{"type":"messaging","click_action":"FLUTTER_NOTIFICATION_CLICK","id":"2","status":"done","subText":"sub text","receiverId":"Receiver Id","callerId":"caller id"},"to":"dOJ9is-lR0-w-IgytZHNY_:APA91bFrDrLciG6B5xUWGUcaXLScjx2LxcE627svt3NWDr5PppJs_9-3VLCx6z3NQ6MfKLHj6BkVkxVnhbotl9bSDKLpbcFe5ZvLox2dFIukyZuLCNzGFmKQGXdx-scfx6jVnAozW6NI"},
//     success: function(data){
//       console.log('succes: '+data);
//     }
//   });
    print(callJdata);

    try {
      Future.delayed(const Duration(seconds: 3),() async {
      await SendNotification().sendnotificaiton(callJdata);
      });
    } catch (e) {
      print("sending message exception $e");
    }
  }

  Future<void> initFCM() async {
    final messaging = FirebaseMessaging.instance;
    if (Platform.isAndroid) {
      String? fbToken_ = await messaging.getToken();
      debugPrint("fbToken $fbToken_");
      if (fbToken_ != null) {
        if (fbToken != fbToken_) {
          fbToken = fbToken_;
          prefs.setString('fbToken', fbToken);
          updateFbToken();
        }
      }
    }


    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      var noti = message.notification?.toMap();
      var data = message.data;
      var datamap = message.toMap();

      debugPrint("datamap $datamap");
      debugPrint("data $data");
      debugPrint("noti $noti");
      ShowNotification.showMessage(message);
    });
  }
  
  Future<void> updateFbToken() async {
      var url = "/api/Users/UpdateUserFbtoken";
    Map data = {'accountId':userId.toString(),'fbtoken':fbToken};
    var result =await requestpNoPopUpWE(url: url, method: Method.put, type: 'params',par: data);
    print("output resutl $result");
    if (!result.toString().contains("Error::::")) {
     // ignore: use_build_context_synchronously
     showSnackBar(context: context, content: "Notification token updated",d:{'bgColor':Colors.green});
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, content: "Notification token update failed",d:{'bgColor':Colors.red});
      
    }
  }
}
