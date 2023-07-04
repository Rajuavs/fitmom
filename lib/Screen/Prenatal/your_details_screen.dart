import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:fitmom/Screen/Prenatal/dashboard_screen.dart';
import 'package:fitmom/Screen/requests/progressbar.dart';
import 'package:fitmom/Screen/requests/requestp.dart';
import 'package:fitmom/Widgest/customThemeButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Widgest/popsup/snackbars.dart';
import '../../Widgest/sizedbox.dart';
import '../../model/userProfileDetailData.dart';
import '../../utils/constants.dart';
// import 'google_map_screen.dart';
import '../google_map_screen.dart';
import '../requests/mothods.dart';

class YourDetailsScreen extends StatefulWidget {
  const YourDetailsScreen({super.key, required this.userId});
  // final SharedPreferences prefs;
  final int userId;

  @override
  State<YourDetailsScreen> createState() => _YourDetailsScreenState();
}

class _YourDetailsScreenState extends State<YourDetailsScreen> {
  String dateis = "";
  LatLng? latlng;

  TextEditingController dateController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? _image;
  final imagePick = ImagePicker();
  late SharedPreferences prefs;
  String googleApikey = "GOOGLE_MAP_API_KAY";
  String location = "Mark Current Location from Map";

  //set profile pic
  setProfilePic() {
    print("upload image");
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text(
                      "Choose existing photo",
                      style: TextStyle(fontSize: 16),
                    ),
                    minVerticalPadding: 0,
                    dense: true,
                    onTap: () {
                      Navigator.pop(context);
                      imagePickerGallery();
                    },
                  ),
                  ListTile(
                    title: const Text("Take photo",
                        style: TextStyle(fontSize: 16)),
                    minVerticalPadding: 0,
                    dense: true,
                    onTap: () {
                      Navigator.pop(context);
                      imagePickerCamera();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future imagePickerGallery() async {
    final pick = await imagePick.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
        print("SANG: " + pick.path);
        print(File(_image!.path));
      } else {
        showSnackBar(context: context, content: "No file selected");
      }
    });
  }

  Future imagePickerCamera() async {
    final pick = await imagePick.pickImage(source: ImageSource.camera);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
        print("SANG1: " + pick.path);
        print(File(_image!.path));
        print("SANG1: end " + pick.path);
      } else {
        showSnackBar(context: context, content: "No file selected");
        // showSnackBar(
        //     context, "No file selected", const Duration(seconds: 2));
      }
    });
  }

  Map selectCountry = {};
  List<Map> _country = [];

  Future _selectCountry() async {
    var url = "https://fitmomwebapi.jaspertech.xyz/api/Location/GetCountryAuto";
    // url = "$url?prefix=${prefix}";
    var response = await http.get(
      Uri.parse(url),
    );
    _country = [];
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      _country = List<Map>.from(responseData);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Country not selected"),
      ));
    }
    return Future.value(_country);
  }

  Map selectState = {};
  List<Map> _state = [];
  int? countryId;

  Future _selectState(prefix, countryId) async {
    var url = "https://fitmomwebapi.jaspertech.xyz/api/Location/GetStateAuto";
    url = "$url?countryId=${countryId}&prefix=${prefix}";
    var response = await http.get(
      Uri.parse(url),
    );
    print("URL STATE $url");
    _state = [];
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      _state = List<Map>.from(responseData);
      print(responseData);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("State not selected"),
      ));
    }
    return Future.value(_state);
  }

  Map selectCity = {};
  List<Map> _city = [];
  int? stateId;

  Future _selectCity(prefix, stateId) async {
    var url = "https://fitmomwebapi.jaspertech.xyz/api/Location/GetCityAuto";
    url = "$url?stateId=$stateId&prefix=$prefix";
    print("ur4 url $url");
    var response = await http.get(
      Uri.parse(url),
    );
    _city = [];
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      _city = List<Map>.from(responseData);
      print(responseData);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("City not selected"),
      ));
    }
    return Future.value(_city);
  }

  @override
  void initState() {
    super.initState();
    _selectCountry();
    _getUserDetail();

    // lastNameController.text = userData?.lastName??"";
    getPrefs();
  }

  late int userId;
  Future<void> getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId') ?? 0;
  }

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

  //add details api
  Future<void> _addDetails() async {
    var url = "https://fitmomwebapi.jaspertech.xyz/api/Users/UpdateUserDetails";
    Map<String, String> params = {
      "UserId": widget.userId.toString(),
      "FirstName": userData?.firstName ?? "",
      "LastName": userData?.lastName ?? "",
      "Email": userData?.email ?? "",
      "MobileNo": userData?.mobileNo ?? "",
      "Age": ageController.text,
      "CountryId": selectCountry["countryId"].toString(),
      "StateId": selectState["stateId"].toString(),
      "CityId": selectCity["id"].toString(),
      "Pincode": pinCodeController.text,
      "Location": locationController.text,
      "DateOfDelivery": dateController.text,

      // "ProfilePicPath": ""
    };

    // ignore: unused_local_variable
    var param = jsonEncode(params);

    var file1 = await http.MultipartFile.fromPath('ProfilePic', _image!.path);
    http.MultipartRequest request =
        http.MultipartRequest("PUT", Uri.parse(url));
    request.fields.addAll(params);
    request.files.add(file1);
    http.StreamedResponse response = await request.send();

    var resbody = await response.stream.bytesToString();
    print(resbody);
    print(response.statusCode);
    if (response.statusCode == 200) {
      if (!mounted) return;
      ProgressDialog pds = progresssbar(context, "Requesting...",
          "Please Wait requesting to Add Details...", true);

      pds.show();
      debugPrint("requesting....");
      var result =
          await requestp(context, url, params, Method.post, "raw", pds, 10);
      debugPrint("print result:::: $result");
      debugPrint("requesting.... end");
      pds.dismiss();
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context, content: "User Details saved successfully!");
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardScreen(
            prefs:prefs,
          ),
        ),
      );
    } else {
      if (!mounted) return;
      showSnackBar(context: context, content: "Something Went Wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                BackButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                height40,
                Center(
                  child: Image.asset("assets/images/img4.png",
                      height: 60, width: 120),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Let’s Get Started!",
                        style: mainHeadingStyle,
                      ),
                      height4,
                      Text(
                        "Complete and Confirm your details to continue ....",
                        style: contentStyle,
                      ),
                      height32,
                      Row(
                        children: [
                          CircleAvatar(
                              radius: 30,
                              backgroundColor: appBgColor,
                              child: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: ClipOval(
                                    child: _image == null
                                        ? Image.asset("assets/images/img5.png")
                                        // : Image.network(_image!.path,fit: BoxFit.cover),

                                        : Image.file(File(_image!.path),
                                            fit: BoxFit.cover)),
                              )),
                          width16,
                          Expanded(
                            // flex: gs <= 2 ? 3 : 7,
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                setProfilePic();
                              },
                              child: Container(
                                constraints: const BoxConstraints(
                                  maxHeight: 44,
                                  minHeight: 38,
                                ),
                                decoration: const BoxDecoration(
                                  color: appBgColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    dashPattern: const [6, 3],
                                    color: appBorderColor,
                                    strokeWidth: 1,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 20,
                                            alignment: Alignment.centerRight,
                                            margin: const EdgeInsets.only(right: 12),
                                            child: const Icon(
                                              Icons.file_upload_outlined,
                                              color: appTextColor,
                                              size: 20,
                                            ),
                                          ),
                                          const Flexible(
                                            child: Text(
                                              "Upload A Profile Picture. Picture. Max Size 2MB",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: appTextColor),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      height20,
                      Text(
                        "First Name",
                        style: videoHeadingStyle,
                      ),
                      height8,
                      TextFormField(
                        style: textFieldInputStyle,

                        enabled: false,
                        // controller: firstNameController,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter(RegExp(r'[a-zA-Z]+|\s'),
                              allow: true)
                        ],
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 10),
                            hintText: userData?.firstName,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                      ),
                      height20,
                      Text(
                        "Last Name",
                        style: videoHeadingStyle,
                      ),
                      height8,
                      TextFormField(
                        style: textFieldInputStyle,
                        // controller: lastNameController,
                        enabled: false,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter(RegExp(r'[a-zA-Z]+|\s'),
                              allow: true)
                        ],
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 10),
                            hintText: userData?.lastName,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                      ),
                      height20,
                      Text(
                        "Email Id",
                        style: videoHeadingStyle,
                      ),
                      height8,
                      TextFormField(
                        style: textFieldInputStyle,
                        // controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        enabled: false,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 10),
                            hintText: userData?.email,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                      ),
                      height20,
                      Text(
                        "Mobile Number",
                        style: videoHeadingStyle,
                      ),
                      height8,
                      TextFormField(
                        style: textFieldInputStyle,
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        enabled: false,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 10),
                            hintText: userData?.mobileNo,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                      ),
                      height20,
                      Text(
                        "Age",
                        style: videoHeadingStyle,
                      ),
                      height8,
                      TextFormField(
                        style: textFieldInputStyle,
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 10),
                            hintText: "Enter your age",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Age";
                          } else {
                            return null;
                          }
                        },
                      ),
                      height20,
                      Text(
                        "Location",
                        style: videoHeadingStyle,
                      ),
                      height8,
                      TextFormField(
                        style: textFieldInputStyle,

                        controller: locationController,

                        readOnly: true,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GoogleMapScreen(
                                        latlng: latlng,
                                        ontap: (v) {
                                          latlng = v as LatLng;
                                          // locationController.text =
                                          "";
                                          Navigator.pop(context);
                                          print("latlang $latlng");

                                          setState(() {});
                                        },
                                      )));
                        },
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 10),
                            hintText: "Mark Current Location from Map",
                            prefixIcon:
                                const Icon(Icons.location_on, color: appThemeColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return "Please Enter Your Location";
                        //   }
                        //     return null;

                        // },
                      ),
                      height20,
                      Text(
                        "Country",
                        style: videoHeadingStyle,
                      ),
                      height8,
                      SizedBox(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: TypeAheadField<Map>(
                            textFieldConfiguration: TextFieldConfiguration(
                                style: textFieldInputStyle,
                                autofocus: false,
                                minLines: 1,
                                controller: countryController,
                                // style: textFieldInputTextStyle,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 10),
                                    // labelText: "Country",
                                    // labelStyle: videoHeadingStyle,
                                    hintText: "Select Country from the list",
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ))),
                            suggestionsCallback: (pattern) async {
                              if (_country.isEmpty) {
                                _country = await _selectCountry();
                              }
                              List<Map> matches = [];
                              matches = _country;
                              return matches.where((element) =>
                                  element["countryName"]
                                      .toString()
                                      .toLowerCase()
                                      .contains(pattern.toLowerCase()));
                            },
                            itemBuilder: (context, item) {
                              return ListTile(
                                title: Text(
                                  item["countryName"].toString(),
                                ),
                              );
                            },
                            onSuggestionSelected: (ind) {
                              selectCountry = ind;
                              countryController.text =
                                  ind["countryName"].toString();
                            },
                          ),
                        ),
                      ),
                      height20,
                      Text(
                        "State",
                        style: videoHeadingStyle,
                      ),
                      height8,
                      SizedBox(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: TypeAheadField<Map>(
                            textFieldConfiguration: TextFieldConfiguration(
                                style: textFieldInputStyle,
                                autofocus: false,
                                minLines: 1,
                                controller: stateController,
                                // style: textFieldInputTextStyle,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 10),
                                    hintText: "Select State from the list",
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ))),
                            suggestionsCallback: (pattern) async {
                              _state = await _selectState(
                                  pattern, selectCountry["countryId"]);

                              List<Map> matches = [];
                              matches = _state;
                              return matches.where((element) =>
                                  element["stateName"]
                                      .toString()
                                      .toLowerCase()
                                      .contains(pattern.toLowerCase()));
                            },
                            itemBuilder: (context, item) {
                              return ListTile(
                                title: Text(
                                  item["stateName"].toString(),
                                ),
                              );
                            },
                            onSuggestionSelected: (ind) {
                              selectState = ind;
                              stateController.text =
                                  ind["stateName"].toString();
                            },
                          ),
                        ),
                      ),
                      height20,
                      Text(
                        "City",
                        style: videoHeadingStyle,
                      ),
                      height8,
                      SizedBox(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: TypeAheadField<Map>(
                            textFieldConfiguration: TextFieldConfiguration(
                                style: textFieldInputStyle,
                                autofocus: false,
                                minLines: 1,
                                controller: cityController,
                                // style: textFieldInputTextStyle,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 10),
                                    // labelText: "City",
                                    // labelStyle: videoHeadingStyle,
                                    hintText: "Select City from the list",
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ))),
                            suggestionsCallback: (pattern) async {
                              _city = await _selectCity(
                                  pattern, selectState["stateId"]);

                              List<Map> matches = [];
                              matches = _city;
                              return matches.where((element) =>
                                  element["cityName"]
                                      .toString()
                                      .toLowerCase()
                                      .contains(pattern.toLowerCase()));
                            },
                            itemBuilder: (context, item) {
                              return ListTile(
                                title: Text(
                                  item["cityName"].toString(),
                                ),
                              );
                            },
                            onSuggestionSelected: (ind) {
                              selectCity = ind;
                              cityController.text = ind["cityName"].toString();
                            },
                          ),
                        ),
                      ),
                      height20,
                      Text(
                        "PinCode",
                        style: videoHeadingStyle,
                      ),
                      height8,
                      TextFormField(
                        style: textFieldInputStyle,
                        controller: pinCodeController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(6)],
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 10),
                            hintText: "Enter Pincode",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Pincode";
                          } else {
                            return null;
                          }
                        },
                      ),
                      height20,
                      Text(
                        "Date of Delivery",
                        style: videoHeadingStyle,
                      ),
                      height8,
                      TextFormField(
                        style: textFieldInputStyle,
                        controller: dateController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 10),
                            // labelText: "Date of Delivery",
                            // labelStyle: videoHeadingStyle,
                            hintText: "Select from the calender",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Date of Delivery";
                          } else {
                            return null;
                          }
                        },
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: appThemeColor,
                                    onPrimary: appLightColor,
                                    onSurface: appThemeColor,
                                  ),
                                ),
                                child: SizedBox(
                                    height: 300, width: 300, child: child!),
                              );
                            },
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            // String formattedDate =
                            //     DateFormat('dd/MM/yyyy')
                            //         .format(pickedDate);
                            dateis =
                                DateFormat("yyyy-MM-dd").format(pickedDate);

                            setState(() {
                              dateController.text = dateis;
                            });
                          } else {}
                        },
                      ),
                      height40,
                      Padding(
                        padding: const EdgeInsets.only(bottom: 250),
                        child: CustomTheemButton(
                            buttonText: "Let’s Go!",
                            ontap: () {
                              if (formKey.currentState!.validate()) {
                                _addDetails();
                              }
                            }),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
