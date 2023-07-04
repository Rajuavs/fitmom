
// import 'package:fitmom/Screen/Feature/PV/p1t3/p1T3Tri2_screen.dart';
// import 'package:fitmom/Screen/Feature/PV/p1t3/p1T3Tri3_screen.dart';
// import 'package:fitmom/Screen/Feature/PV/p1t3/p1t3Tri1_screen.dart';
// import 'package:flutter/material.dart';

// import '../../../../Widgest/sizedbox.dart';
// import '../../../../utils/constants.dart';


// class P1T3TabsScreen extends StatefulWidget {
//   const P1T3TabsScreen({super.key});
//   final int 

//   @override
//   State<P1T3TabsScreen> createState() => _P1T3TabsScreenState();
// }

// class _P1T3TabsScreenState extends State<P1T3TabsScreen> with TickerProviderStateMixin{

//   late TabController _controller;
 

//   @override
//   void initState() {
//     _controller =
//         TabController(length: 3, vsync: this,);
//     super.initState();
//   }

  
// @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
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
//               TabBar(
//                                             indicatorColor: appThemeColor,
//                                             indicatorWeight: 3,
//                                             indicatorPadding: EdgeInsets.zero,
//                                             // labelPadding: EdgeInsets.symmetric(horizontal: 10),
//                                             padding: EdgeInsets.symmetric(horizontal: 16),
//                                             unselectedLabelColor:
//                                                appTextColor,
//                                             labelColor: appThemeColor,
//                                             tabs: [
//                                               Tab(
//                                                 text:  "Trimester 1",
//                                               ),
//                                               Tab(
//                                                 text:  "Trimester 2",
//                                               ),
//                                               Tab(
//                                                 text:  "Trimester 3",
//                                               ),
//                                             ],
//                                             isScrollable: true,
//                                             controller: _controller,
//                                           ),
//                                           Column(
//                                             // shrinkWrap: true,
//                                             children: [
//                                               Container(
//                                                 constraints: BoxConstraints(
//                                                     maxHeight: 1200),
//                                                 child: TabBarView(
//                                                   controller: _controller,
//                                                   children: [
                                                    
//                                                     P1T3Tri1Screen(userId: ,),
//                                                     P1T3Tri2Screen(),
//                                                     P1T3Tri3Screen(),
                                                    
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
              
      
      
//             ],),
//         )),
//       ),
//     );
//   }
// }