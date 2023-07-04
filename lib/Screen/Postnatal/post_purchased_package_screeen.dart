
import 'package:fitmom/Screen/Postnatal/post_payment_screen.dart';
import 'package:fitmom/Widgest/customThemeButton.dart';
import 'package:fitmom/model/myPackageData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Widgest/sizedbox.dart';
import '../../utils/constants.dart';



class PostPurchasedPacakageScreen extends StatefulWidget {
  const PostPurchasedPacakageScreen({super.key, required this.userId});
  // final SharedPreferences prefs;
  final int userId;

  @override
  State<PostPurchasedPacakageScreen> createState() => _PostPurchasedPacakageScreenState();
}

class _PostPurchasedPacakageScreenState extends State<PostPurchasedPacakageScreen> {

  late SharedPreferences prefs;
  @override
  void initState() {
    _getPackage();
    super.initState();
  }

MyPackageData? package;
Future<void> _getPackage() async {
    var url = "https://fitmomwebapi.jaspertech.xyz/api/Users/GetUserPackage";
    url = "$url?userId=${widget.userId}";
    var response = await http.get(
      Uri.parse(url),
    );
    print(response.body);
    if (response.statusCode == 200) {
      // package = jsonDecode(response.body);
      package = myPackageDataFromJson(response.body);
      
           setState(() {});
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("No package found"),
        ),
      );
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
                
                  Text("Packages Purchased",style: mainHeadingStyle,),
                ],
              ),
              height4,
              Text("Confirm the package you have selected with us",style: contentStyle,),
              height40,
              Container(
                constraints: BoxConstraints(
                  minHeight: 200,
                  maxHeight: 400
                ),
                // height: 400.h,
                decoration: BoxDecoration(
                  color: appLightColor,
                  // border: Border.all(color: appBorderColor,width: 1),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: appBorderColor,
                      blurRadius: 4.4,
                      offset: Offset(0.0, 3.0)
                    )
                  ]

                ),
                child: Column(
                  children: [
                    Container(
                      height: 80.h,
                      decoration: BoxDecoration(
                        color: appThemeColor,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8)),
                      ),
                      child: Center(child: Text(
                        
                        package?.packageName ?? " ",
                        maxLines: 2,
                        // "6-Months Prenatal Fitness",
                      style: GoogleFonts.poppins(
  fontSize: 20.sp,
  color: appLightColor,
  fontWeight: FontWeight.w600
),),),
                    ),
                    height40,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          packageContents(package?.description?? ""),
                          height20,
                          Text("DURATION : ${package?.duration}",style: headingStyle,),
                          height20,
                         Text("MRP : ${package?.mrp}",style: headingStyle,),
                          
                          
                        ],
                      ),
                    )
                  ],
                ),
              ),

              
            ],),
        )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: CustomTheemButton(buttonText: "Pay Now", ontap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>PostRazorPayScreen()));
        }),
      ),
    );
  }

  Widget packageContents(String text) {
    return Text(text,style: packageContentStyle,);
  }
}