// import 'package:fitmom/Screen/requests/requestp.dart';
import 'package:fitmom/Widgest/sizedbox.dart';
import 'package:fitmom/Widgest/videoDescription.dart';
import 'package:fitmom/utils/constants.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../model/getUserWelcomeVideoData.dart';
// import '../requests/mothods.dart';
import 'package:http/http.dart' as http;



class WelcomeVideoScreen extends StatefulWidget {
  const WelcomeVideoScreen({super.key,required this.userId});
  final int userId;

  @override
  State<WelcomeVideoScreen> createState() => _WelcomeVideoScreenState();
}

class _WelcomeVideoScreenState extends State<WelcomeVideoScreen> {

  @override
  void initState() {
    _welcomeVideoList();
    super.initState();
  }
//get welcome video


List<GetUsersWelcomeVideosData> wVideo = [];
Future<void> _welcomeVideoList() async {
    var  apiUrl =
        "https://fitmomwebapi.jaspertech.xyz/api/Users/GetUsersWelcomeVideos";
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
      var _welVido = getUsersWelcomeVideosDataFromJson(result);
      setState(() {
        if (_welVido.isEmpty) {
          const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(appThemeColor),
            ),
          );
        } else {
          wVideo = _welVido;
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
                  Text("Welcome Videos",style: mainHeadingStyle,),
                ],
              ),
              height4,
              Text("Watch our introduction videos to get started with our exercises and guidelines.",style: contentStyle,),
              height40,
              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ListView(
                                                  physics: const ClampingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  children: wVideo.map((e) => welcomeVideoList(e)).toList(),
                                                ),
                                              ),
              
            //   videoDescription(),
            //   Divider(),
              
            //   videoDescription(),
            //  Divider(),
            //   videoDescription(),
            //   Divider(),
            //   videoDescription(),
              
              


            ],),
        )),
      ),
    );
  }

  Widget welcomeVideoList(GetUsersWelcomeVideosData e){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: 75,
                            maxWidth: 100,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
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
                            
                              Text(e.instructor,style: contentStyle,),
                              // height2,  
                              // Text("14/10/2023",style: videoContentStyle,),
                            ],
                          ),
                        )
                       ],),
    );
  }
}