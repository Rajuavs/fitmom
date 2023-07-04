// To parse this JSON data, do
//
//     final userProfileDetailData = userProfileDetailDataFromJson(jsonString);

import 'dart:convert';

UserProfileDetailData userProfileDetailDataFromJson(String str) => UserProfileDetailData.fromJson(json.decode(str));

String userProfileDetailDataToJson(UserProfileDetailData data) => json.encode(data.toJson());

class UserProfileDetailData {
    int userId;
    int accountId;
    String firstName;
    String lastName;
    String email;
    String mobileNo;
    int age;
    int countryId;
    int stateId;
    int cityId;
    String pincode;
    String dateOfDelivery;
    String profilePicPath;

    UserProfileDetailData({
        required this.userId,
        required this.accountId,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.mobileNo,
        required this.age,
        required this.countryId,
        required this.stateId,
        required this.cityId,
        required this.pincode,
        required this.dateOfDelivery,
        required this.profilePicPath,
    });

    factory UserProfileDetailData.fromJson(Map<String, dynamic> json) => UserProfileDetailData(
        userId: json["userId"],
        accountId: json["accountId"],
        firstName: json["firstName"]?? "",
        lastName: json["lastName"]??"",
        email: json["email"]??"",
        mobileNo: json["mobileNo"],
        age: json["age"]?? 0,
        countryId: json["countryId"]??0,
        stateId: json["stateId"]??0,
        cityId: json["cityId"]??0,
        pincode: json["pincode"] ?? "",
        dateOfDelivery: json["dateOfDelivery"]??"",
        profilePicPath: json["profilePicPath"]??"",
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "accountId": accountId,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "mobileNo": mobileNo,
        "age": age,
        "countryId": countryId,
        "stateId": stateId,
        "cityId": cityId,
        "pincode": pincode,
        "dateOfDelivery": dateOfDelivery,
        "profilePicPath": profilePicPath,
    };
}
