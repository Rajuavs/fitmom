import 'package:fitmom/Widgest/sizedbox.dart';
import 'package:fitmom/Widgest/videoDescription.dart';
import 'package:fitmom/utils/constants.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import '../../../../model/getUserSessionVideoData.dart';



class SessionVideoScreen extends StatefulWidget {
  const SessionVideoScreen({super.key,required this.userId});
  final int userId;

  @override
  State<SessionVideoScreen> createState() => _SessionVideoScreenState();
}

class _SessionVideoScreenState extends State<SessionVideoScreen> {
  
  @override
  void initState() {
    _sessionVideoList();
    super.initState();
  }

  

  List<GetUsersSessionVideosData> sVideo = [];
Future<void> _sessionVideoList() async {
    var  apiUrl =
        "https://fitmomwebapi.jaspertech.xyz/api/Users/GetUsersSessionVideos";
        apiUrl = "$apiUrl?accountId=${widget.userId}";
    // Map<String, dynamic> body = {};

    final response = await http.get(
      Uri.parse(apiUrl),
    );
    var result = response.body.toString();
    print("result : $result");
    // if (response.statusCode == 200) {
      if ( result.toString().contains("Error::::")) {
        String msg = result.toString().replaceAll("Error::::", "");
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar( SnackBar(content: Text(msg)));

        return;
      }
      var _sessionVido = getUsersSessionVideosDataFromJson(result);
      setState(() {
        if (_sessionVido.isEmpty) {
          const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(appThemeColor),
            ),
          );
        } else {
          sVideo = _sessionVido;
        }
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
              Row(
                children: [
                  BackButton(
                  onPressed: (){Navigator.pop(context);},
                ),
                  Text("Previous Videos",style: mainHeadingStyle,),
                ],
              ),
              height4,
              Text("View previous exercises videos you would like to rewatch ot catch up with",style: contentStyle,),
              height40,
              
              Padding(
                                                padding:
                                                    const EdgeInsets.only(bottom: 10),
                                                child: ListView(
                                                  physics: const ClampingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  children: sVideo.map((e) => sessionVideoList(e)).toList(),
                                                ),
                                              ),
              // videoDescription(),
              // Divider(),
              // videoDescription(),
              // height20,
              // Text("Last Week",style: headingStyle,),
              // Divider(),
              // videoDescription(),
              // Divider(),
              // videoDescription(),
              // Divider(),
              // videoDescription(),
              // height20,
              // Text("Week 7",style: headingStyle,),
              // Divider(),
              // videoDescription(),
              // Divider(),
              


            ],),
        )),
      ),
    );
  }
  Widget sessionVideoList(GetUsersSessionVideosData e){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Week ${e.weekId}",style: headingStyle,),
              // Divider(),
            Row(children: [
                              Container(
                                constraints: BoxConstraints(
                                  maxHeight: 75,
                                  maxWidth: 100,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: appTextColor.withOpacity(0.2)),
                                  image: DecorationImage(image: NetworkImage(e.thambnailPath),fit: BoxFit.cover)
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    videoStatus(),
                                    height4,
                                    Text(e.title,
                                                                style: videoHeadingStyle,maxLines: 2,overflow: TextOverflow.ellipsis,),
                                  
                                    Text("${e.instructor}",style: contentStyle,),
                                    // height2,  
                                    // Text("14/10/2023",style: videoContentStyle,),
                                  ],
                                ),
                              )
                             ],),
                             Divider(),
          ],
        ),
      ),
    );
  }
}




