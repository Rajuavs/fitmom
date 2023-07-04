// To parse this JSON data, do
//
//     final myPackageData = myPackageDataFromJson(jsonString);

import 'dart:convert';

MyPackageData myPackageDataFromJson(String str) => MyPackageData.fromJson(json.decode(str));

String myPackageDataToJson(MyPackageData data) => json.encode(data.toJson());

class MyPackageData {
    int packageId;
    String packageName;
    int mrp;
    String description;
    String duration;

    MyPackageData({
        required this.packageId,
        required this.packageName,
        required this.mrp,
        required this.description,
        required this.duration,
    });

    factory MyPackageData.fromJson(Map<String, dynamic> json) => MyPackageData(
        packageId: json["packageId"],
        packageName: json["packageName"],
        mrp: json["mrp"],
        description: json["description"],
        duration: json["duration"],
    );

    Map<String, dynamic> toJson() => {
        "packageId": packageId,
        "packageName": packageName,
        "mrp": mrp,
        "description": description,
        "duration": duration,
    };
}
