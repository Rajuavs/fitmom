// import 'package:fitmom/Screen/Settings/SFeatures/update_profile_screen.dart';
import 'package:fitmom/Screen/splash_screen.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../Widgest/gretting.dart';
import '../../../Widgest/popsup/snackbars.dart';
import '../../../Widgest/sizedbox.dart';
import '../../../model/userProfileDetailData.dart';
import '../../../utils/constants.dart';
import '../../../utils/session/session_manager.dart';
import 'SFeatures/update_profile_screen.dart';



class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key,required this.userId});
 final int userId;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  //  late int  userId;
  //  late SharedPreferences prefs;


   @override
  void initState() {
    _getUserDetail();
    super.initState();
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
                  Text("Settings",style: mainHeadingStyle,),
                ],
              ),
              height20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(userData?.profilePicPath??""),
                          ),
                          width12,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(greeting(),style: contentStyle,),
                            Text("${userData?.firstName} ${userData?.lastName}",style: headingStyle,),
                          ],),
                          
                      ],),
                       PopupMenuButton<String>(
                        itemBuilder: (context) => [
                         
                          PopupMenuItem(
                            value: "logout",
                            // row with two children
                            child: Row(
                              children: const [
                                Icon(Icons.logout),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Logout")
                              ],
                            ),
                          ),
                        ],
                        // offset: Offset(0, 100),
                        // color: Colors.grey,
                        elevation: 2,
                        position: PopupMenuPosition.under,
                        // on selected we show the dialog box
                        onSelected: (value) async {
                          // if value 1 show dialog
                          if (value == "logout") {
                            if (await SessionManageR().logout()) {
                              // ignore: use_build_context_synchronously
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SplashScreen()),
                                  (route) => false);
                            }
                          }
                        },
                        child: Image.asset("assets/icons/icon8.png"),
                      ),
                ],
              ),
                  height16,
                  Center(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 1,color: appThemeColor),
                      ),
                      onPressed: (){}, child: Text("I’ve Had my Baby, Switch To Post-Natal",style: themeTextStyle,)),
                  ),
                  Divider(),
                  height20,
                  settingsFeature((){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateDetailsScreen(userId: widget.userId)));
                  },"assets/icons/icon5.png","My Profile","Change Number, Preferences......"),
                  height30,
                  settingsFeature((){},"assets/icons/icon6.png","Packages","Change Packages..."),
                  
            ]),
        )),
      ),
    );
  }

  Widget settingsFeature(VoidCallback ontap,String image, String heading, String desc) {
    return GestureDetector(
                  onTap: ontap,
                  child: Row(children: [
                    Image.asset(image),
                    width16,
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(heading,style: videoHeadingStyle,),
                      Text(desc,style: videoContentStyle,),
                
                    ],)
                  ],),
                );
  }
}