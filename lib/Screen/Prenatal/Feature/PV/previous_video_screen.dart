// import 'package:fitmom/Widgest/sizedbox.dart';
// import 'package:fitmom/Widgest/videoDescription.dart';
// import 'package:fitmom/utils/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:http/http.dart' as http;

// import '../../../../model/getUserSessionVideoData.dart';



// class PreviousVideoScreen extends StatefulWidget {
//   const PreviousVideoScreen({super.key,required this.userId});
//   final int userId;

//   @override
//   State<PreviousVideoScreen> createState() => _PreviousVideoScreenState();
// }

// class _PreviousVideoScreenState extends State<PreviousVideoScreen> {
  
//   @override
//   void initState() {
//     _sessionVideoList();
//     super.initState();
//   }

  

//   List<GetUsersSessionVideosData> sVideo = [];
// Future<void> _sessionVideoList() async {
//     var  apiUrl =
//         "https://fitmomwebapi.jaspertech.xyz/api/Users/GetUsersSessionVideos";
//         apiUrl = "$apiUrl?accountId=${widget.userId}";
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SafeArea(child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 15),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("Previous Videos",style: mainHeadingStyle,),
//               height4,
//               Text("View previous exercises videos you would like to rewatch ot catch up with",style: contentStyle,),
//               height40,
              
//               Padding(
//                                                 padding:
//                                                     const EdgeInsets.only(bottom: 10),
//                                                 child: ListView(
//                                                   physics: const ClampingScrollPhysics(),
//                                                   shrinkWrap: true,
//                                                   children: sVideo.map((e) => sessionVideoList(e)).toList(),
//                                                 ),
//                                               ),
//               // videoDescription(),
//               // Divider(),
//               // videoDescription(),
//               // height20,
//               // Text("Last Week",style: headingStyle,),
//               // Divider(),
//               // videoDescription(),
//               // Divider(),
//               // videoDescription(),
//               // Divider(),
//               // videoDescription(),
//               // height20,
//               // Text("Week 7",style: headingStyle,),
//               // Divider(),
//               // videoDescription(),
//               // Divider(),
              


//             ],),
//         )),
//       ),
//     );
//   }
//   Widget sessionVideoList(GetUsersSessionVideosData e){
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Week ${e.weekId}",style: headingStyle,),
//               // Divider(),
//             Row(children: [
//                               Container(
//                                 constraints: BoxConstraints(
//                                   maxHeight: 75.h,
//                                   maxWidth: 100.w,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(6),
//                                   border: Border.all(color: appTextColor.withOpacity(0.2)),
//                                   image: DecorationImage(image: NetworkImage(e.thambnailPath),fit: BoxFit.cover)
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left:12.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     videoStatus(),
//                                     height4,
//                                     Text(e.title,
//                                                                 style: videoHeadingStyle,maxLines: 2,overflow: TextOverflow.ellipsis,),
                                  
//                                     Text("${e.instructor}",style: contentStyle,),
//                                     // height2,  
//                                     // Text("14/10/2023",style: videoContentStyle,),
//                                   ],
//                                 ),
//                               )
//                              ],),
//                              Divider(),
//           ],
//         ),
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Widgest/sizedbox.dart';
import '../../../../utils/constants.dart';
import 'p1t3/p1T3Tri2_screen.dart';
import 'p1t3/p1T3Tri3_screen.dart';
import 'p1t3/p1t3Tri1_screen.dart';


class PreviousVideoScreen extends StatefulWidget {
  const PreviousVideoScreen({super.key});

  @override
  State<PreviousVideoScreen> createState() => _PreviousVideoScreenState();
}

class _PreviousVideoScreenState extends State<PreviousVideoScreen> with TickerProviderStateMixin{

  late TabController _controller;
 

  @override
  void initState() {
    _controller =
        TabController(length: 3, vsync: this,);
        initPrefs();
    super.initState();
  }

  
@override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late SharedPreferences prefs;
  late int  userId;


  
  
  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      userId = prefs.getInt("userId") ?? 0;
    });
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
                                            // labelPadding: EdgeInsets.symmetric(horizontal: 10),
                                            padding: EdgeInsets.symmetric(horizontal: 16),
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
                                              Tab(
                                                text:  "Trimester 3",
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
                                                    maxHeight: 4200),
                                                child: TabBarView(
                                                  controller: _controller,
                                                  children: [
                                                    
                                                    P1T3Tri1Screen(userId: userId,),
                                                    P1T3Tri2Screen(),
                                                    P1T3Tri3Screen(),
                                                    
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