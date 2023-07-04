import 'package:fitmom/Widgest/sizedbox.dart';
import 'package:fitmom/Widgest/videoDescription.dart';
import 'package:fitmom/model/getUserLiveVideoData.dart';
import 'package:fitmom/utils/constants.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;


class GuestVideoScreen extends StatefulWidget {
  const GuestVideoScreen({super.key,required this.userId});
  final int userId;

  @override
  State<GuestVideoScreen> createState() => _GuestVideoScreenState();
}

class _GuestVideoScreenState extends State<GuestVideoScreen> {



  @override
  void initState() {
    _liveVideoList();
    super.initState();
  }



//get live videos
List<GetUsersLiveVideosData> lVideo = [];
Future<void> _liveVideoList() async {
    var  apiUrl =
        "https://fitmomwebapi.jaspertech.xyz/api/Users/UserLiveVideos";
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
      var _liveVido = getUsersLiveVideosDataFromJson(result);
      setState(() {
        if (_liveVido.isEmpty) {
          const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(appThemeColor),
            ),
          );
        } else {
          lVideo = _liveVido;
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
                  Text("Live Videos",style: mainHeadingStyle,),
                ],
              ),
              height4,
              Text("Watch videos from our special guests on specific topics they are experts in!",style: contentStyle,),
              height40,
               Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ListView(
                                                  physics: const ClampingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  children: lVideo.map((e) => liveVideoList(e)).toList(),
                                                ),
                                              ),
              // Text("This Week",style: headingStyle,),
              // Divider(),
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
  Widget liveVideoList(GetUsersLiveVideosData e){
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
                            image: DecorationImage(image: NetworkImage(e.instructorPhotoPath),fit: BoxFit.cover)
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              liveVideoStatus(),
                              height4,
                              Text(e.title,
                                                          style: videoHeadingStyle,maxLines: 2,overflow: TextOverflow.ellipsis,),
                            
                              Text(e.instructor,style: contentStyle,),
                              height2,  
                              Text("${e.sessionTime}",style: videoContentStyle,),
                            ],
                          ),
                        )
                       ],),
    );
  }
}